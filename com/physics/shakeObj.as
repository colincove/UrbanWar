package com.physics{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import com.interfaces.Program;
	import com.globals;
		import com.displayObjects.activeObj;
		import com.GameComponent;
	public class shakeObj extends GameComponent implements Program{
		private var shakeAmt:int;
		public static const SHAKE:String="shake";
		protected var shapeX:int;
		protected var shapeY:int;
		protected var originX:int;
		protected var originY:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		private var shakeDecay:Number;
		protected var colorTran:ColorTransform;
		protected var colorControl:int;
		//(redMultiplier:Number = 1.0, greenMultiplier:Number = 1.0, blueMultiplier:Number = 1.0, alphaMultiplier:Number = 1.0, redOffset:Number = 0, greenOffset:Number = 0, blueOffset:Number = 0, alphaOffset:Number = 0)
		public function shakeObj():void {
			originY=y;
			originX=x;
			shakeDecay=1.1;
			colorControl=0;
			if (parent is activeObj) 
			{
				activeObj(parent).addArtwork(this);
			}
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public override function destroy():void
		{
			super.destroy();
			globals.game_progThread.removeProg(this);
			colorTran=null;
		}
		public function shake(damage:int):void {
			shakeAmt=damage;
			colorControl=255;
		}
		public function update():Object{
			colorTran= new ColorTransform(1,  1, 1,  1.0,  colorControl,  colorControl,  colorControl,  0);
			this.transform.colorTransform=colorTran;
			shapeX=(Math.random()-Math.random())*shakeAmt;
			shapeY=(Math.random()-Math.random())*shakeAmt;
			x=originX+shapeX;
			y=originY+shapeY;
			colorControl=colorControl/shakeDecay;
			shakeAmt=shakeAmt/shakeDecay;
			if(shakeAmt>0.5)
			{
				this.dispatchEvent(new Event(SHAKE));
			}
			return this;
		}
				public function isRunning():Boolean
				{
			return progRun;
		}
	}
}