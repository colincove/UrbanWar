package com.displayObjects{
	import flash.display.MovieClip;
	import com.globals;
	import com.physics.movement;
	import com.interfaces.Program;
	public class StackSmoke extends movement implements Program {
private var originX:int;
private var originY:int;
		public function StackSmoke():void {
			globals.game_progThread.addProg(this);
			progRun=true;
			originX=x;
			originY=y;
			visible=false;
		}
		public function update():Object {
			if (! parent.parent||!parent||!parent.parent.parent) {
				progRun=false;
				globals.game_progThread.removeProg(this);
			} else {
				checkScreen();
				if (onScreen) {
					var scale:Number  = Math.random();
					x=originX+((Math.random()-Math.random())*10);
					y=originY+((Math.random()-Math.random())*10);
					scaleX=1+scale;
					scaleY=1+scale;
					globals.smoke.stackSmokeBM.drawObject(this);

				}
			}
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}

	}
}