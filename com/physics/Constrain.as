package com.physics {
	public class Constrain {
		private var p1:pointmass;
		private var p2:pointmass;
		private var length:Number;
private var dx:Number;
			private var dy:Number;
			private var dist:Number;
			private var diff:Number;
		public function Constrain(p1:pointmass, p2:pointmass, length:Number=100):void 
		{
			this.p1=p1;
			this.p2=p2;
			this.length=length;
		}
		public function update():void 
		{
			dx=p1.x-p2.x;
			dy=p1.y-p2.y;
			dist=Math.sqrt(dx*dx+dy*dy);
			diff=dist-length;
			diff=diff/dist;
			dx=dx*.5;
			dy=dy*.5;
			p1.x=p1.x-(diff*dx);
			p1.y=p1.y-(diff*dy);
			p2.x=p2.x+(diff*dx);
			p2.y=p2.y+(diff*dy);
		}
	}
}