package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.WeaponItem;
	import com.weapons.MissileLauncher;
	import com.globals;
	import com.weapons.WeaponsEnum;

	public class MissileLauncherItem extends WeaponItem {
		public function MissileLauncherItem():void {
			super(30,this,WeaponsEnum.MISSILE_LAUNCHER);
		}
	}
}