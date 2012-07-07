package com.physics{
	import flash.display.MovieClip;
	public class pointmass extends MovieClip
	{
		private var ox:Number;
		private var oy:Number;
		public static var fric:Number=1.05;
		private var dx:Number;
			private var dy:Number;
		public function pointmass(ox, oy):void 
		{
			x=ox;
			y=oy;
			this.ox=ox;
			this.oy=oy;
		}
		public function update():void {
			dx=x-ox;
			dy=y-oy;
			ox=x;
			oy=y;
			x=x+dx/fric;
			//+0.6 is gravity
			y=(y+dy/fric)+.6;
			
		}
		public function stick(sx, sy):void {
			x=sx;
			y=sy;
			ox=sx;
			oy=sy;
		}
	}
}