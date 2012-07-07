package com.weapons{
	import com.interfaces.jetPackInterface;
	import flash.display.MovieClip
		import flash.media.SoundChannel;

	import flash.events.Event;
	import com.Sound.GlobalSounds;
	import com.GameComponent;
	public class jetPack extends GameComponent
	{
		private var user:jetPackInterface;
		private var fuel:int;
		private var prevFuel:int;
		private var totalFuel:int;
		private var strength:Number;
				private var soundChannel:SoundChannel;

		private var startStrength:Number;
		public var active:Boolean=true;
		public function jetPack(user:jetPackInterface, fuel:int=500):void {
			this.user=user;
			totalFuel=fuel;
			strength=-1.8;
			startStrength=-4;
			this.fuel=totalFuel;
		}
		public override function destroy():void
		{
			//super.destroy();
			//user=null;
			//soundChannel=null;
		}
		private function boost():void 
		{
			//fuel-=1;
			if(active)
			{
			Object(user).modifySpeedY(strength);
			}
		}
		public function jetPackIgnite(silent:Boolean=true):void
		{
			
			if(soundChannel==null&&!silent){
				addEventListener(Event.ENTER_FRAME, soundListener, false, 0, true);
				soundChannel=GlobalSounds.playSound('jetPack',10);
			}
			if (fuel==0) {
				user.noFuel();
			} else {
				boost();
			}
		}
		public function ignition():void {
			prevFuel=fuel;
			boost();
		}
		public function soundListener(e:Event):void {
			if (prevFuel==fuel) {
				removeEventListener(Event.ENTER_FRAME, soundListener, false);
				soundChannel.stop();
				soundChannel=null;
			}
			prevFuel=fuel;
		}
		public function removeSelf():void{
			user=null;
			strength=0;
			startStrength=0;
		}
		public function addFuel(amt:int):void {
			fuel+=amt;
			if(fuel>totalFuel){
				fuel=totalFuel;
			}
		}
		public function getFuel():Number {
			return fuel;
		}
		public function getTotal():Number {
			return totalFuel;
		}
		

		//public function
	}
}