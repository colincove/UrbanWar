package com.physics{
	import flash.events.Event;
	public class objDamage extends objShake {
		public function objDamage():void {

		}
		protected function hit(damage:int):void {
			shake(damage);
		}

	}
}