package com.physics{
	import com.globals;
	import com.physics.objMovement;
	import flash.events.Event;
	import com.interfaces.Program;
	public class bounceObj extends objMovement implements Program {
		public var active:Boolean;
		public function bounceObj():void {
			super();
			ground=globals.groundContainer;
			Speed=1.1;
			radius=15;
			xSpeed=-5;
			ySpeed=0;
			addEventListener(Event.ADDED_TO_STAGE, loadSelf, false, 0, true);
		}
			public function update():Object{
			movementUpdate();
			return this;
		}
		private function loadSelf(e:Event):void {
			ground=globals.heroContainer;
			active=true;
			removeEventListener(Event.ADDED_TO_STAGE, loadSelf, false);
		}
				public function isRunning():Boolean{
			return progRun;
		}
	}
}