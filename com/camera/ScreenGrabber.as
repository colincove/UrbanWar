package com.camera{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import com.displayObjects.debry;
	import com.globals;
	import flash.utils.Timer;
		import flash.geom.Matrix;
	import flash.events.Event;
	import flash.events.TimerEvent;
	public class ScreenGrabber
	{
		public static var currentGrab:Bitmap = new Bitmap(new BitmapData(800,600));
		public static var debryCount:int;
		public static var maxDebry:int;
		public static var timer:Timer=new Timer(300);
		public static var grabTimer:Timer=new Timer(150);
		public static var canGrab:Boolean=true;
		public function ScreenGrabber():void
		{
		}
		public static function debryAdd(debryObj:debry):void
		{
			debryCount++;
			if(debryCount>maxDebry && canGrab)
			{
				getScreen();
			}
			debryObj.addEventListener(Event.REMOVED_FROM_STAGE,debryRemoved);
		}
		public static function debryRemoved(e:Event):void{
			debryCount--;
			e.target.removeEventListener(Event.REMOVED_FROM_STAGE,debryRemoved);
		}
		public static function reset():void
		{
			maxDebry=0;
			debryCount=0;
			//currentGrab.bitmapData.dispose();
		}
		public static function getScreen():void
		{
			if(!currentGrab.parent)
			{
				globals.main.stage.addChild(currentGrab);
				currentGrab.visible=false;
			}
			grabTimer.addEventListener(TimerEvent.TIMER,grab);
			grabTimer.start();
			maxDebry=debryCount;
			canGrab=false;
		}
		public static function grab(e:TimerEvent):void
		{
			timer.start();
			grabTimer.reset();
			grabTimer.removeEventListener(TimerEvent.TIMER,grab);
			var mat:Matrix = new Matrix(1,0,0,1,(-globals.HUD.x)+400,(-globals.HUD.y)+300);
			currentGrab.bitmapData.scroll(800,0);
			currentGrab.bitmapData.draw(globals.main,mat);
		}
		public static function endTimer(e:TimerEvent):void
		{
			timer.reset();
			canGrab=true;
		}
	}
}