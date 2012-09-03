package com.physics{
	import flash.events.Event;
	import com.displayObjects.activeObj;
	import flash.display.MovieClip;
	import com.globals;
	import com.globalFunctions;
	public class movement extends activeObj {
		protected var xSpeed:Number;
		protected var ySpeed:Number;
		public var Speed:Number;
		
		protected var speedMax:Number;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		
		public function movement():void {
			super();
			xSpeed=0;
			ySpeed=0;
		}
		public override function destroy():void {
			super.destroy();
			
		}
		protected function moveObj():void {
			x+=xSpeed;
			y+=ySpeed;
		}
		public function getYSpeed():Number {
			return ySpeed;
		}
		public function getXSpeed():Number {
			return xSpeed;
		}
		protected function stopMovement():void {
			removeActiveObj();
		}
		protected function startMovement():void {
			removeActiveObj();
		}
		public function modifySpeedX(mod:Number):void {
			if ((xSpeed<=speedMax) &&(xSpeed>=(-speedMax))) {
				xSpeed+=mod;
				if (xSpeed>speedMax) {
					xSpeed=speedMax;
				}
				if (xSpeed<speedMax*-1) {
					xSpeed=- speedMax;
				}
			}
		}
		public function modifySpeedY(mod:Number):void {
			if ((ySpeed<speedMax) &&(ySpeed>-speedMax)) {
				ySpeed+=mod;

			}
		}
		
		
	}
}