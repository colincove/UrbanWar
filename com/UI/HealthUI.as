
package com.UI{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.interfaces.Program;
	import flash.events.Event;
	import com.globals;
	import com.globalFunctions;
	public class HealthUI extends MovieClip  implements Program{
		private var frame:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function HealthUI():void {
			frame=0;
			progRun=true;
			
			globals.static_progThread.addProg(this);
			progRun=true;
		}
	public function update():Object{
			frame+=((1000-currentFrame)-(globals.hero.getHealth()/globals.hero.getHealthTot()*1000))/10;
			gotoAndStop(frame);
			return this;
		}
				public function isRunning():Boolean{
			return progRun;
		}
	}
}