package com.levels{
	import flash.utils.getDefinitionByName;
		import com.Sound.GlobalSounds;

	public class level6Control extends levelControl{
				private var levelPuppet:level;

		public function level6Control(ID:int=0):void 
		{
			super(6);
			this.levelPuppet=levelPuppet;
			levelSongChannel=GlobalSounds.playSound('song6');
		}
	}
}