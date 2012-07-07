package com.worldObjects{
	import com.worldObjects.person;
	import flash.events.Event;
	import com.interfaces.dieable;
	public class Civilian extends person implements dieable {
		private var interval:Number;
		private var dead:Boolean=false;
		public function Civilian():void {
			super(this);
			addEventListener(Event.ENTER_FRAME, activeCiv, false,0, true);
		}
		private function activeCiv(e:Event):void {
			//I have this dead var for gay reasons. I remove active civ, but it seems it likes to run one more time before
			//actualling dieing. So I am removed from the display list when this goes through, when that should not happen. 
			//stupid. 
			if(!dead){
			active();
			}
		
			interval=Math.random()*100;
			if (interval>98&&! flying) {
				scaleX=dir;
				xSpeed=- xSpeed;
			}
		}
		public function die():void {
			dead=true;
			removeEventListener(Event.ENTER_FRAME, activeCiv, false);
			personRemove();
			
			
		}
	}

}