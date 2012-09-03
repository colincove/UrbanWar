package com.levels{
	import flash.utils.getDefinitionByName;
	import com.Sound.GlobalSounds;
	import com.globals;
	public class level9Control extends levelControl
	{
		public function level9Control(ID:int=0):void 
		{
			super(9);
			globals.darkLevel=true;
			levelSongChannel=GlobalSounds.playSound('song6');
		}
		private function buildLevel():void
		{
		}
		public function build()
		{
		}
		public override function update():Object
		{
			if(globals.hero.x>13595.2)
			{
				globals.HUD.screenSpeedMod+=0.005;
				if(globals.hero.x>18644.4)
				{
					globals.HUD.alpha-=0.005;
					if(globals.hero.x>20392.8)
					{
						globals.endOfGame=true;
					globals.main.getGame().beatCurrentLevel();
				}
				}
				
			}
			return super.update();
		}
	}
}