package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.WeaponItem;
	import com.weapons.GausseCannon;
	import com.globals;
	import com.weapons.WeaponsEnum;

	public class GausseCannonItem extends WeaponItem 
	{
		public function GausseCannonItem():void
		{
						super(50,this,WeaponsEnum.GAUSSE_CANNON);

		}
	}
}