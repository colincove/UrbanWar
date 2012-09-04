package com.UI
{
	import flash.events.MouseEvent;
	import com.GameComponent;
	import com.events.MenuEvent;
	import com.globals;
	import flash.events.Event;
	import com.database.WebServices;
	import com.database.ScoreResults;
	import com.database.User;
	import flash.display.DisplayObjectContainer;
	import com.displayObjects.Numbers;
	import com.weapons.AccuracyStats;
	import flash.text.TextField;
	import com.displayObjects.RollingNumber;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class EndLevelScreen extends PromptBase
	{
		private var interval:int = 0;
		private var intervalCap:int = 50;

		private var currentPrompt:PromptBase;
		private var resultDisplay:ScoreResults;
		private var enemiesKilledDisplay:RollingNumber;
		private var accuracyDisplay:RollingNumber;
		private var pointsDisplay:RollingNumber;
		private var gearsDisplay:RollingNumber;
		
		private var levelGrade:TextField;
		private var rollingCompleted:int=0;
		private var continueTimer:Timer;
		private var startCountingTimer:Timer;
		public function EndLevelScreen():void
		{

			super(globals.main,40,true);
			continueTimer =  new Timer(7000);
			startCountingTimer =  new Timer(2000);
			resultDisplay = new ScoreResults();
			if (parent)
			{
				parent.removeChild(this);
			}
			addChild(resultDisplay);
			enemiesKilledDisplay = new RollingNumber(0);
			accuracyDisplay = new RollingNumber(0);
			pointsDisplay = new RollingNumber(0);
			gearsDisplay = new RollingNumber(0);
			enemiesKilledDisplay.addEventListener(RollingNumber.ROLLING_COMPLETE,rollingComplete);
			accuracyDisplay.addEventListener(RollingNumber.ROLLING_COMPLETE,rollingComplete);
			pointsDisplay.addEventListener(RollingNumber.ROLLING_COMPLETE,rollingComplete);
			gearsDisplay.addEventListener(RollingNumber.ROLLING_COMPLETE,rollingComplete);
			levelGrade = new TextField();
			numberDisplayContainer1.addChild(enemiesKilledDisplay);
			numberDisplayContainer2.addChild(accuracyDisplay);
			numberDisplayContainer3.addChild(gearsDisplay);
			numberDisplayContainer4.addChild(pointsDisplay);
			
			okButton.addEventListener(MouseEvent.CLICK,continueGame);
		}
		private function rollingComplete(e:Event):void
		{
			if(++rollingCompleted>4)
			{
				continueTimer.addEventListener(TimerEvent.TIMER, continueToMenu);
				continueTimer.start();
				msg.text=globals.gradingScaleController.getStatement(globals.score.score,globals.main.getGame().playLevelID);
				play();
			}
			if(rollingCompleted==1)
			{
				enemiesKilledText.visible=true;
				numberDisplayContainer1.visible=true;
				enemiesKilledDisplay.rollNumberTo(globals.enemiesKilled);
				startCountingTimer.reset();
			startCountingTimer.removeEventListener(TimerEvent.TIMER, rollingComplete);
			}
			if(rollingCompleted==2)
			{
				accuracyText.visible=true;
				numberDisplayContainer2.visible=true;
				accuracyDisplay.rollNumberTo(int(AccuracyStats.pct));
				
			}
			if(rollingCompleted==3)
			{
				gearsText.visible=true;
				numberDisplayContainer3.visible=true;
				gearsDisplay.rollNumberTo(globals.gameVars.orbs-globals.gameVars.oldOrbs);
			}
			if(rollingCompleted==4)
			{
				totalScoreText.visible=true;
				numberDisplayContainer4.visible=true;
				pointsDisplay.rollNumberTo(globals.score.score);
			}
		}
		private function continueToMenu(e:TimerEvent):void
		{
			continueTimer.removeEventListener(TimerEvent.TIMER, continueToMenu);
				continueTimer.reset();
				remove();
				globals.hideUI=false;
				if(globals.endOfGame)
				{
					globals.main. launchTitleScreen();
				}else{
					globals.main.getGame().beatCurrentLevel();
				}
			
		}
		
		public function launch():void
		{
			startCountingTimer.start();
			msg.text="";
			startCountingTimer.addEventListener(TimerEvent.TIMER, rollingComplete);
			numberDisplayContainer1.visible=false;
			numberDisplayContainer2.visible=false;
			numberDisplayContainer3.visible=false;
			numberDisplayContainer4.visible=false;
			enemiesKilledText.visible=false;
					accuracyText.visible=false;
							totalScoreText.visible=false;
							gearsText.visible=false;
			globals.hideUI=true;
			rollingCompleted=0;
			//enemiesKilledDisplay.setPointArray(globals.enemiesKilled);
			//accuracyDisplay.setPointArray(int(AccuracyStats.pct));
			//pointsDisplay.setPointArray(globals.score.score);
			//enemiesKilledDisplay.rollNumberTo(globals.enemiesKilled);
			//accuracyDisplay.rollNumberTo(int(AccuracyStats.pct));
			//pointsDisplay.rollNumberTo(globals.score.score);
			levelGrade.text = globals.gradingScaleController.getStatement(globals.score.score,globals.main.getGame().playLevelID);
			if (parent==null)
			{
				globals.main.addChild(this);
				gotoAndStop(25);
			}
			else
			{
				parent.removeChild(this);
				globals.main.addChild(this);
			}
			x =  -  parent.x;
			y =  -  parent.y;
			alpha = 0;
			globals.letPlayerLive = true;
			gotoAndStop(25);
			//gotoAndPlay(2);
			fadeIn();
			interval = 0;
			visible = true;
			screenGrab.manualUpdate();
			//currentPrompt = InfoModal.createPrompt(DisplayObjectContainer(root),"Retrieving results...");
			if (User.active)
			{
				//WebServices.getUserScore(resultDisplay,globals.main.getGame().playLevelID,resultFound, User.uid);
			}
			else
			{
				//WebServices.getScore(resultDisplay,globals.main.getGame().playLevelID,resultFound);
			}
			function resultFound():void
			{
				currentPrompt.remove();
			}
		}
		//screenShot.manualUpdate();

		//GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE));

		private function continueGame(e:MouseEvent):void
		{
			remove();
			globals.main.getGame().beatCurrentLevel();
		}
		public override function remove():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}
		private function gameSlowDown(e:Event):void
		{
			if (globals.game_progThread.isPaused)
			{

				if (interval++ >= intervalCap)
				{
					//globals.game_progThread.runThread(e);
					//globals.static_progThread.runThread(e);
					if (globals.game_progThread.isPaused)
					{

						//globals.game_progThread.resumeProgram();
						//globals.static_progThread.resumeProgram();
					}
					else
					{
						//globals.game_progThread.pauseProgram();
						//globals.static_progThread.pauseProgram();
					}
					intervalCap = 2;
					///intervalCap=int(intervalCap/2.1);
					//interval = 0;
					if (intervalCap<=2)
					{
						gotoAndStop(25);
						//gotoAndPlay(2);
						fadeIn();
						interval = 0;

						visible = true;
						intervalCap = 50;
						globals.game_progThread.resumeProgram();
						globals.static_progThread.resumeProgram();
						removeEventListener(Event.ENTER_FRAME,gameSlowDown);
						//screenGrab.manualUpdate();

						currentPrompt = InfoModal.createPrompt(DisplayObjectContainer(root),"Retrieving results...");
						if (User.active)
						{
							WebServices.getUserScore(resultDisplay,globals.main.getGame().playLevelID,resultFound, User.uid);
						}
						else
						{
							WebServices.getScore(resultDisplay,globals.main.getGame().playLevelID,resultFound);
						}
						function resultFound():void
						{
							currentPrompt.remove();
						}
					}
				}
			}
			else
			{
				if (interval++ > 5)
				{
					interval = 0;
					globals.static_progThread.pauseProgram();
					globals.game_progThread.pauseProgram();
				}
			}

		}
	}
}