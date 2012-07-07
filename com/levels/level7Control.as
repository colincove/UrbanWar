package com.levels{
	import com.globals;
	import flash.utils.getDefinitionByName;
	import com.Sound.GlobalSounds;
	public class level7Control extends levelControl {
		public function level7Control(ID:int=0):void {
			super(7);
			
			progRun=true;
			globals.game_progThread.addProg(this);
			levelSongChannel=GlobalSounds.playSound('song7');
		}
		
		public override function update():Object {
			//globals.groundContainer.visible=false;
			//globals.smoke.smokeBM.drawObject(globals.groundContainer);
			
			globals.levelObj.sky.x=(globals.levelObj.x+200+globals.HUD.x/1.03);
			globals.levelObj.sky.y=(globals.levelObj.y+globals.HUD.y);
			return this;
		}
		private function buildLevel():void {
		}
		public function build() {
		}
	}
}