package com.UI
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.interfaces.Program;
	import flash.events.Event;
	import com.globals;
	import com.globalFunctions;
	public class ShieldUI extends MovieClip implements Program
	{
		private var frame:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function ShieldUI():void
		{
			frame = 0;
			

			globals.static_progThread.addProg(this);
			progRun = true;
		}
		public function update():Object
		{
			if (globals.hero.shield != null)
			{

this.visible=true;
				frame+=((1000-currentFrame)-(globals.hero.shield.getRatio()*1000))/10;
				gotoAndStop(frame);
			}else{
			this.visible=false;
			}
			return this;
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
	}
}