package com.levels{
	import flash.display.MovieClip;
	import com.Sound.GlobalSounds;
	public class level5Control extends levelDawnControl
	{
		private var levelPuppet:level;
		public function level5Control(levelPuppet:level):void {
			super(5);
			levelSongChannel=GlobalSounds.playSound('song5');
		}
	}
}