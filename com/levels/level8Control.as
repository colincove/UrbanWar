package com.levels{
	import flash.utils.getDefinitionByName;
	import com.Sound.GlobalSounds;
	import com.globals;
	public class level8Control extends levelSkyControl{
		public function level8Control(ID:int=0):void {
			super(8);
			globals.darkLevel=true;
			levelSongChannel=GlobalSounds.playSound('song8');
		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}