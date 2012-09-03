package com.displayObjects{
	import flash.display.MovieClip;
	public class smallExplosion extends tmpDisplayObj
	{
		public function smallExplosion(xPos:int, yPos:int):void
		{
			super(xPos, yPos);
			this.rotation=Math.random();
		}
	}
}