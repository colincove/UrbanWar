package com.levels{
	import flash.utils.getDefinitionByName;
	import com.globals;
	import com.levels.level;
	import com.Sound.GlobalSounds;
	public class level4Control extends levelControl{
		public function level4Control(ID:int=0):void {
			super(4)
			progRun=true;
			globals.game_progThread.addProg(this);
			levelSongChannel=GlobalSounds.playSound('song4');
		}
		public override function update():Object{
globals.levelObj.sun.x=(globals.levelObj.x+650+globals.HUD.x/1.1);
globals.levelObj.sun.y=(globals.levelObj.y+globals.HUD.y);
			return this;
		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}