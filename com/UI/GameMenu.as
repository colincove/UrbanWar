package com.UI{
	import flash.display.MovieClip;
	import com.UI.GameMenuPM;
	import com.globals;
	import com.events.MenuEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import com.database.User;
	import com.database.WebServices;
	import com.database.ScoreResults;

	public class GameMenu extends MovieClip {
		private var updateLevelStandingTimer:Timer;
		private var resultDisplay:ScoreResults;
		private var tips:MenuTips;
		public function GameMenu():void 
		{
			tips = new MenuTips(this);
		}
		public function initialize():void{
		resultDisplay=new ScoreResults();
		//loadoutTip.okButton.addEventListener(MouseEvent.CLICK, loadoutTipOK);
			this.userStats.addChild(resultDisplay);
			resultDisplay.y=-42;
			resultDisplay.x=-105;
			this.addEventListener(MenuEvent.SELECT_LEVEL,selectLevel);
			this.addEventListener(MenuEvent.SELECT_WEAPONS, selectWeapons);
			this.stop();
			this.userStats.leaderboardsButton.addEventListener(MouseEvent.CLICK, launchLeaderboards);
			updateLevelStandingTimer=new Timer(1200);
			updateLevelStandingTimer.addEventListener(TimerEvent.TIMER,updateLevelStanding);
		}
		private function loadoutTipOK(e:MouseEvent):void{
			//removeChild(loadoutTip);
		}
		public function launch():void 
		{
			GameMenuPM.loadoutSelected
			globals.main.getGame().continueCampaign();
			fadeIn.gotoAndPlay(2);
			GameMenuPM.launching=true;
			///if(loadoutTip.parent!=null)
			//{
			//removeChild(loadoutTip);
			//}
			GameMenuPM.reset();
			GameMenuPM.startMusic();
			GameMenuPM.update();
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.LAUNCH));
			gotoAndStop(40);

			
			GameMenuPM.launching=false;
			if (User.active) {//
				WebServices.getUserScore(resultDisplay,globals.main.getGame().playLevelID,function (){},User.uid);
			} else {
				WebServices.getScore(resultDisplay,globals.main.getGame().playLevelID,function (){});
			}
			

			if (globals.main.getGame().wonLevel) {
				updateLevelStandingTimer.start();
			}
			menuStatus.setState(true);
		}
		private function updateLevelStanding(e:TimerEvent):void {
			//userStats.screenGrab.manualUpdate();
			
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE_LEVEL_STATUS));
			updateLevelStandingTimer.stop();
			updateLevelStandingTimer.reset();
		}
		private function selectLevel(e:MenuEvent):void {

			this.gotoAndPlay("selectLevel");
		}
		private function launchLeaderboards(e:MouseEvent):void {
			globals.main.launchLeaderboards();
		}
		private function selectWeapons(e:MenuEvent) {
			gotoAndStop(1);
			if(globals.main.getGame().currentLevelID==1){
			//addChild(loadoutTip);
			
			}else{
			
			}
		}
	}
}