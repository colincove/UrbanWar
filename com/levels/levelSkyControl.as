package com.levels{
	import flash.utils.getDefinitionByName;
	import com.globals;
	import com.levels.level;
	import com.Sound.GlobalSounds;
	public class levelSkyControl extends levelControl
	{
		public function levelSkyControl(ID:int=0):void
		{
			super(ID);
		}
		public override function update():Object
		{
globals.levelObj.sky.x=(globals.levelObj.x+200+globals.HUD.x/1.03);
			globals.levelObj.sky.y=(globals.levelObj.y+globals.HUD.y);
			return super.update();
		}
	
	}
}