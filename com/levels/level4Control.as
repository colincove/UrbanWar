package com.levels{
	import flash.utils.getDefinitionByName;
	import com.globals;
	import com.levels.level;
	import com.Sound.GlobalSounds;
	public class level4Control extends levelDawnControl{
		public function level4Control(ID:int=0):void {
			super(4);
			progRun=true;
			globals.game_progThread.addProg(this);
			levelSongChannel=GlobalSounds.playSound('song4');
		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}