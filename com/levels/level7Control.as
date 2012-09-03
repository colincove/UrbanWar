package com.levels{
	import com.globals;
	import flash.utils.getDefinitionByName;
	import com.Sound.GlobalSounds;
	public class level7Control extends levelSkyControl 
	{
		public function level7Control(ID:int=0):void
		{
			super(7);
			globals.darkLevel=true;
			progRun=true;
			globals.game_progThread.addProg(this);
			levelSongChannel=GlobalSounds.playSound('song7');
		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}