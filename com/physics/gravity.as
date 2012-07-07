package com.physics {
	import com.globals;
	import flash.display.MovieClip;
	public class gravity extends movement {
		protected var grav:Number;
		protected var haveAir:Boolean;
				protected var ground:MovieClip;
		public function gravity():void {
			super();
			this.grav=globals.gravity;
		} 
		public override function destroy():void{
			super.destroy();
			ground=null;
		}
		protected function gravPull():void {
			ySpeed+=grav;
			haveAir=true;
		}
		public function getHaveAir():Boolean {
			return haveAir;
		}
	}
}