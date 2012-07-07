package com.levels{
	import flash.utils.getDefinitionByName;
	import com.Sound.GlobalSounds;
	public class level9Control extends levelControl{
		public function level9Control(ID:int=0):void {
			super(9);
			levelSongChannel=GlobalSounds.playSound('song6');
		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}