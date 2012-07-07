package com.levels{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.Sound.GlobalSounds;
	import com.globals;
	public class level1Control extends levelControl{
		private var levelPuppet:level;
		private var realCamSpeed:Number;
		public function level1Control(levelPuppet:level):void 
		{
			super(1);
			if(globals.gameVars.forKarl)
			{
			this.levelPuppet=levelPuppet;
			realCamSpeed=Number(globals.gameVars.stage1.screenSpeed)
			globals.gameVars.stage1.screenSpeed=0;
try{
			//levelPuppet.neutral_contrainer.firstItem.addEventListener('itemPickedUp', itemPickedUp);
}catch(e:Error){
}
			}
			levelBackgroundChannel=GlobalSounds.playSound('Level1Backtrack');
			levelSongChannel=GlobalSounds.playSound('song1');
		}
		private function itemPickedUp(e:Event):void
		{
			globals.gameVars.stage1.screenSpeed=realCamSpeed;
		}
	}
}