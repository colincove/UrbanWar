package com.UI{
	import com.events.MenuEvent;
	import flash.display.MovieClip;
	import com.UI.GameMenuPM;
	import com.globals;
	public class LevelStatus extends MovieClip
	{
		public function LevelStatus():void
		{
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE_LEVEL_STATUS,update);
		}
		private function update(e:MenuEvent=null):void 
		{
			this.gotoAndStop(globals.main.getGame().currentLevelID);
		}
	}
}