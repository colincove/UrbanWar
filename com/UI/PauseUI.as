package com.UI{
	import flash.display.MovieClip;
	import com.globals;
	import com.interfaces.Program;
	public class PauseUI extends MovieClip implements Program {
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function PauseUI():void {
			globals.menus_progThread.addProg(this);
			progRun=true;
		}
		public function update():Object {
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}

	}
}