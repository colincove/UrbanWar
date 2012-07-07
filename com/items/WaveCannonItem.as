package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.WeaponItem;
	import com.weapons.WaveCannon;
	import com.globals;
	import com.weapons.WeaponsEnum;

	public class WaveCannonItem extends WeaponItem 
	{
		public function WaveCannonItem():void 
		{
			super(30,this,WeaponsEnum.WAVE_CANNON);
		}
	}
}