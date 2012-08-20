package com.levels{
	import flash.utils.getDefinitionByName;
	import com.globals;
	import com.levels.level;
	import com.Sound.GlobalSounds;
	public class levelDawnControl extends levelControl
	{
		public function levelDawnControl(ID:int=0):void
		{
			super(ID);
		}
		public override function update():Object
		{
globals.levelObj.sun.x=(globals.levelObj.x+650+globals.HUD.x/1.1);
globals.levelObj.sun.y=(globals.levelObj.y+globals.HUD.y);
			return super.update();
		}
	
	}
}