package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.WeaponItem;
	import com.weapons.LaserCannon;
	import com.globals;
	import com.weapons.WeaponsEnum;

	public class LaserCannonItem extends WeaponItem {
		public function LaserCannonItem():void {
						super(50,this,WeaponsEnum.LASER);

		}
	}
}