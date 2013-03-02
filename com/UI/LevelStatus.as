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
			GameMenuPM.dispatcher.addEventListener(MenuEvent.LAUNCH,onLaunch);
		}
		private function onLaunch(e:MenuEvent):void
		{
			clearSelection();
			if(globals.main.getGame().currentLevelID==1){
				selectLevel(globals.main.getGame().currentLevelID);
			}else{
				selectLevel(globals.main.getGame().currentLevelID-1);
			}
			
		}
		private function update(e:MenuEvent=null):void 
		{
			levelUnlocked.gotoAndPlay(2);
			selectLevel(globals.main.getGame().currentLevelID);
			this.gotoAndStop(globals.main.getGame().currentLevelID);
		}
		public function selectLevel(level:int):void
		{
			clearSelection();
			this["select"+level].visible=true;
		}
		private function clearSelection():void
		{
			for(var i:int=1;i<=9;i++)
			{
				this["select"+i].visible=false;
			}
		}
	}
}