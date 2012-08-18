package com.UI{
		import com.events.MenuEvent;
	import flash.display.MovieClip;
	import com.UI.GameMenuPM;
	import com.globals;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import com.camera.ScreenGrabber;
	public class ScreenGrabDisplay extends MovieClip
	{
		private var bm:Bitmap;
		public function ScreenGrabDisplay():void
		{
			//GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
			bm=new Bitmap(new BitmapData(800,600,false,0x000000));
			this.addChild(bm);
			bm.scaleX=.4;
			bm.scaleY=.4;
		}
		private function update(e:MenuEvent=null):void 
		{
			bm.bitmapData=ScreenGrabber.currentGrab.bitmapData;
		}
		public function manualUpdate():void{
			update();
		}
	}
}