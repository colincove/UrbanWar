package com.UI{
	import com.UI.GameMenuPM;
	import com.events.MenuEvent;
	import com.globals;
	import com.weapons.Weapon;
	import flash.display.MovieClip;
	public class MenuStatus extends MovieClip
	{
		private var numberOfPossibleWeapons:int=0;
		public function MenuStatus():void
		{
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
			
		}
		private function update(e:MenuEvent=null):void
		{
			numberOfPossibleWeapons=0;
			for(var i:int=0;i<WeaponList.weaponList.length;i++)
			{
				if(WeaponList.weaponList[i].purchased)
				{
					numberOfPossibleWeapons++;
					
				}
			}
			if(numberOfPossibleWeapons>3)
			{
				numberOfPossibleWeapons=3;
			}
			if(GameMenuPM.weaponList.length==GameMenuPM.loadOut.length)
			{
				this.gotoAndStop("select");
			}else{
				if(GameMenuPM.loadOut.length==numberOfPossibleWeapons)
				{
					this.gotoAndStop("select");
				}else{
					this.gotoAndStop("choose");
				}
			}
		}
	}
}