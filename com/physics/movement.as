package com.physics{
	import flash.events.Event;
	import com.displayObjects.activeObj;
	import flash.display.MovieClip;
	import com.globals;
	import com.globalFunctions;
	public class movement extends activeObj
	{
		protected var xSpeed:Number;
		protected var ySpeed:Number;
		public var Speed:Number;
		private var checkInterval:int=0;
		protected var checkIntervalLimit:int=0;
		protected var speedMax:Number;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		private var screenCheckPoint:MovieClip;
		public function movement():void
		{
			super();
			xSpeed=0;
			ySpeed=0;
		}
		public override function destroy():void
		{
			super.destroy();
			screenCheckPoint=null;
		}
		protected function moveObj():void
		{
			x+=xSpeed;
			y+=ySpeed;
		}
		public function getYSpeed():Number 
		{
			return ySpeed;
		}
		public function getXSpeed():Number
		{
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
		public function setScreenPoint(obj:MovieClip):void {
			this.screenCheckPoint=obj;
		}
		public function checkScreen():void {
			if(++checkInterval>checkIntervalLimit){
			try {
checkInterval=0;
				if (parent!=null) {
					if (globals.levelObj.parent==null) {
					} else {
						if (globals.HUD.hitTestPoint(globalFunctions.getMainX(this),globalFunctions.getMainY(this),true)) {
							onScreen=true;
						} else {
							onScreen=false;
						}
						if ((screenCheckPoint!=null)&&(!spawned)) {
							if (globals.HUD.hitTestPoint(globalFunctions.getMainX(screenCheckPoint),globalFunctions.getMainY(screenCheckPoint),true)) {
								spawnScreen=true;
							} else {
								spawnScreen=false;
							}
						}
					}
				}
			} catch (e:Error) {
				onScreen=false;
			}
			}
		}
	}
}