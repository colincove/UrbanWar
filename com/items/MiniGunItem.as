package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.WeaponItem;
	import com.weapons.MiniGun;
	import com.globals;
	import com.weapons.WeaponsEnum;

	public class MiniGunItem extends WeaponItem 
	{
		public function MiniGunItem():void 
		{
			super(50,this,WeaponsEnum.MINI_GUN);
		
		}
	}
}