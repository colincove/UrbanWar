package com.weapons{
	import flash.events.Event;
	public class ExtendedFireWeapon extends Weapon {
		public function ExtendedFireWeapon(heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5, strength:int=5, shotDelay:int=100):void {
			super(heat, heatCapacity, coolSpeed, heatSpeed, strength, shotDelay);
			shooting=false;
		}
		public function heatUp():void 
		{
			
			if (overheated) 
			{
				selfReference.stopFiring();
			} else {
				heatIntervalThing++;
				shooting=true;
				trace("A",overheated,getHeat(),getHeatSpeed(),getHeatCapacity());
				setHeat(getHeat()+getHeatSpeed());
				trace("B",overheated,getHeat(),getHeatSpeed(),getHeatCapacity());
			}
		}
		protected function stopExtendedWeapon():void 
		{
			shooting=false;
			setHeat(this.getHeatCapacity());
		}
	}/**/
}