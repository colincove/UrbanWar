package com.displayObjects{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.interfaces.Program;
	import com.globals;
	public class tmpDisplayObj extends MovieClip implements Program{
				public var progRun:Boolean;//Program Run. True if running, false if not. 

		public function tmpDisplayObj(xPos:int=0, yPos:int=0):void {
			globals.main.addChild(this);
			x=xPos;
			y=yPos;
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public function update():Object {
			if(currentFrame==totalFrames){
				parent.removeChild(this);
						globals.game_progThread.removeProg(this);

			}
			return this;
		}
public function isRunning():Boolean{
			return progRun;
		}
	}
}