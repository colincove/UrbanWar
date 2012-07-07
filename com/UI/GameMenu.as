package com.UI{
	import flash.display.MovieClip;
	import com.UI.GameMenuPM;
	import com.globals;
	import com.events.MenuEvent;
	import flash.events.MouseEvent;
	public class GameMenu extends MovieClip
	{
		public function GameMenu():void
		{
			this.addEventListener(MenuEvent.SELECT_LEVEL,selectLevel);
			this.addEventListener(MenuEvent.SELECT_WEAPONS, selectWeapons);
			this.stop();
			this.userStats.leaderboardsButton.addEventListener(MouseEvent.CLICK, launchLeaderboards);
		}
		public function launch():void
		{
			GameMenuPM.launching=true;
			GameMenuPM.reset();
			gotoAndStop(40);
			
			GameMenuPM.update();
			GameMenuPM.launching=false;
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