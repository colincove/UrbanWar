package com.weapons{
	public class SingleFireWeapon extends Weapon {
		public function SingleFireWeapon(heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5, radius:int=50, damage:int=20, shotDelay:int=100):void{
					super(heat, heatCapacity, coolSpeed, heatSpeed, damage, shotDelay, radius);
		}
			public function heatUp():void {
				setHeat(getHeat()+getHeatSpeed());
		}
	}
}