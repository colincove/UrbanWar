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

	public class EndLevelScreen extends PromptBase
	{
		private var interval:int = 0;
		private var intervalCap:int = 50;

		private var currentPrompt:PromptBase;
		private var resultDisplay:ScoreResults;
		private var enemiesKilledDisplay:Numbers;
		private var accuracyDisplay:Numbers;
		private var pointsDisplay:Numbers;
		
		private var levelGrade:TextField;
		public function EndLevelScreen():void
		{

			super(globals.main,40,true);
			resultDisplay = new ScoreResults();
			if (parent)
			{
				parent.removeChild(this);
			}
			fadeAnimation.addChild(resultDisplay);
			enemiesKilledDisplay = new Numbers(0);
			accuracyDisplay = new Numbers(0);
			pointsDisplay = new Numbers(0);
			levelGrade = new TextField();
			fadeAnimation.numberDisplayContainer1.addChild(enemiesKilledDisplay);
			fadeAnimation.numberDisplayContainer2.addChild(accuracyDisplay);
			fadeAnimation.numberDisplayContainer3.addChild(pointsDisplay);
			fadeAnimation.numberDisplayContainer4.addChild(levelGrade);
			fadeAnimation.okButton.addEventListener(MouseEvent.CLICK,continueGame);
		}
		public function launch():void
		{
			enemiesKilledDisplay.setPointArray(globals.enemiesKilled);
			accuracyDisplay.setPointArray(int(AccuracyStats.pct));
			pointsDisplay.setPointArray(globals.score.score);
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
			fadeAnimation.screenGrab.manualUpdate();
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
		//fadeAnimation.screenShot.manualUpdate();

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
						fadeAnimation.screenShot.screenGrabDisplay.manualUpdate();

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