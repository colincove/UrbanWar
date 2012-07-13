package com.displayObjects {
	import com.physics.bounceObj;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import com.globals;
	import com.camera.ScreenGrabber;
	import com.interfaces.neutralObj;
		import com.interfaces.Program;
		
	public class debry extends bounceObj implements neutralObj, Program{
		private var deleteTimer:Timer = new Timer(6000);
private var interval:int=0;
private var randomRemove:int;
		public function debry():void
		{
			super();
			
			globals.debryList.push(this);
			bounce=.6;
			randomRemove = int(Math.random()*30);
			xSpeed=(Math.random()-Math.random())*10;
			ySpeed=(Math.random()-Math.random())*10-Math.random()*30;
			//deleteTimer.addEventListener(TimerEvent.TIMER, deleteSelf, false, 0, true);
			deleteTimer.start();
			this.gotoAndStop(int(Math.random()*totalFrames));
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public override function destroy():void
		{
			super.destroy();
			if(deleteTimer!=null)
			{
				
				deleteTimer.stop();
				deleteTimer.reset();
				deleteTimer.removeEventListener(TimerEvent.TIMER, deleteSelf);
			}
			
			globals.game_progThread.removeProg(this);
			deleteTimer=null;
		}
		private function deleteSelf(e:TimerEvent):void 
		{
			parent.removeChild(this);
			deleteTimer.stop();
			deleteTimer.removeEventListener(TimerEvent.TIMER, deleteSelf);
		}
		override public function update():Object 
		{
			rotation+=xSpeed;
			movementUpdate();
			moveObj();
			if(interval++>120+randomRemove)
			{
				destroy();
			}
			return this;
		}

	}
}