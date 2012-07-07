package com.items{
	import flash.display.MovieClip;
	import com.globals;
	import com.globalFunctions;
		import com.Sound.GlobalSounds;

	import com.items.Item;
	import com.items.Shield;
	public class ShieldItem extends FallingItem
	{
		public function ShieldItem(power:int=100):void 
		{
			super(40,this);
			
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public function action():void {
			GlobalSounds.playSound('GetShield');
			globals.hero.addShield(new Shield());
			if(parent!=null){
				parent.removeChild(this);
			}
			
			globals.game_progThread.removeProg(this);
		}
	}
}