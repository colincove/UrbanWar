package com.UI{
	import flash.display.MovieClip;
	import com.UI.GameMenuPM;
	import com.globals;
	import com.events.MenuEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	public class GameMenu extends MovieClip
	{
		private var updateLevelStandingTimer:Timer;
		public function GameMenu():void
		{
			this.addEventListener(MenuEvent.SELECT_LEVEL,selectLevel);
			this.addEventListener(MenuEvent.SELECT_WEAPONS, selectWeapons);
			this.stop();
			this.userStats.leaderboardsButton.addEventListener(MouseEvent.CLICK, launchLeaderboards);
			updateLevelStandingTimer = new Timer(500);
			updateLevelStandingTimer.addEventListener(TimerEvent.TIMER,updateLevelStanding);
		}
		public function launch():void
		{
			GameMenuPM.launching=true;
			GameMenuPM.reset();
			gotoAndStop(40);
			
			GameMenuPM.update();
			GameMenuPM.launching=false;
			if(globals.main.getGame().wonLevel)
			{
				updateLevelStandingTimer.start();
			}
		}
		private function updateLevelStanding(e:TimerEvent):void
		{
			userStats.screenGrab.manualUpdate();
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE_LEVEL_STATUS));
			updateLevelStandingTimer.stop();
			updateLevelStandingTimer.reset();
		}
		private function selectLevel(e:MenuEvent):void
		{
			
			this.gotoAndPlay("selectLevel");
		}
		private function launchLeaderboards(e:MouseEvent):void
		{
			globals.main.launchLeaderboards();
		}
		private function selectWeapons(e:MenuEvent)
		{
		gotoAndStop(1);
		}
	}
}