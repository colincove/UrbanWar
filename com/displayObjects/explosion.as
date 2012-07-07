package com.displayObjects{
	import flash.display.MovieClip;
	public class explosion extends tmpDisplayObj {
		public function explosion(xPos:int, yPos:int):void {
			super(xPos, yPos);
			this.rotation=Math.random();
		}
	}
}