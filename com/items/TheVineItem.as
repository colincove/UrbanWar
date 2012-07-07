package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.WeaponItem;
	import com.weapons.TheVine;
	import com.globals;
	import com.weapons.WeaponsEnum;

	public class TheVineItem extends WeaponItem {
		public function TheVineItem():void {
						super(50,this,WeaponsEnum.VINE);

		}
	}
}