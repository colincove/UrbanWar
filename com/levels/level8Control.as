package com.levels{
	import flash.utils.getDefinitionByName;
	import com.Sound.GlobalSounds;
	public class level8Control extends levelControl{
		public function level8Control(ID:int=0):void {
			super(8);
			levelSongChannel=GlobalSounds.playSound('song8');
		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}