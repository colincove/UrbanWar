package com.levels{
	import flash.utils.getDefinitionByName;
			import com.Sound.GlobalSounds;

	public class level3Control extends levelControl{
		public function level3Control(ID:int=0):void {
super(3);						
levelSongChannel=GlobalSounds.playSound('song3');

		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}