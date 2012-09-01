
package com.UI{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.interfaces.Program;
	import flash.events.Event;
	import com.globals;
	import com.globalFunctions;
	public class HealthUI extends MovieClip implements Program {
		private var frame:int;
		private var fuelFrame:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function HealthUI():void {
			frame=0;
			progRun=true;
			fuelFrame=0;

			globals.static_progThread.addProg(this);
			progRun=true;
		}
		public function update():Object {
			if (globals.hideUI) {
				visible=false;
			} else {
				visible=true;
			}
			frame+=((1000-currentFrame)-(globals.hero.getHealth()/globals.hero.getHealthTot()*1000))/10;
			gotoAndStop(frame);
			if (globals.hero.jetpack!=null) {
				fuelBar.visible=true;
				fuelFrame+=((1000-fuelBar.currentFrame)-(globals.hero.jetpack.pct*1000))/10;
				fuelBar.gotoAndStop(Math.round(fuelFrame));
			} else {
				fuelBar.visible=false;
			}
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}