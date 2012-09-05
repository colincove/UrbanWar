package com.displayObjects {
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class RollingNumber extends Numbers 
	{
private var timer:Timer;
private var currentDisplay:int;
private var rollTo:int;
private var rollBy:int;
public static const ROLLING_COMPLETE:String="rollingComplete";
		public function RollingNumber(pointInt:int) 
		{
			// constructor code
			super(pointInt);
			timer =new Timer(50);
		}
		public function rollNumberTo(num:int):void
		{
			rollBy=1;
			currentDisplay=0;
			rollTo=num;
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, roll);
		}
		private function roll(e:TimerEvent):void
		{
			currentDisplay+=rollBy;
			rollBy=rollBy*2;
			if(rollTo>currentDisplay)
			{
				setPointArray(currentDisplay);
			}else{
				setPointArray(rollTo);
				dispatchEvent(new Event(ROLLING_COMPLETE));
				timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, roll);
			}
		}
	}
}
