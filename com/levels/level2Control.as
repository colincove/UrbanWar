package com.levels{
	import flash.utils.getDefinitionByName;
		import com.Sound.GlobalSounds;

	public class level2Control extends levelControl{
				private var levelPuppet:level;

		public function level2Control(ID:int=0):void {
			super(2);
			this.levelPuppet=levelPuppet;
			
			levelSongChannel=GlobalSounds.playSound('song2');
		}
	}
}