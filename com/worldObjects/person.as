package com.worldObjects{
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.interfaces.pausable;
	import com.physics.objMovement;
	import com.displayObjects.activeObj;
	import com.globalFunctions;
	import com.globals;
	import com.interfaces.People;
	import com.myMath.dist;
	import flash.geom.Point;
	public class person extends objMovement implements pausable,People {
		private var shootPoint:Point;
		private var parentClass:MovieClip;
		protected var flying:Boolean;
		public function person(parentClass:MovieClip):void {
			shootPoint = new Point();
			flying=false;
			this.parentClass=parentClass;
			globals.addPeople(this);
			right=true;
			ground=globals.neutralContainer;
			ySpeed=0;
			xSpeed=-2;
			addEventListener(Event.ENTER_FRAME,killSelf, false, 0, true);
		}
		public function pauseSelf():void {
			removeEventListener(Event.ENTER_FRAME, active, false);
		}
		public function unpauseSelf():void {
			addEventListener(Event.ENTER_FRAME, active, false, 0, true);
		}
		protected function active():void {
			movementUpdate();
			if (flying) {
				rotation+=xSpeed*2;
			}
		}
		public function explode():void {
			ySpeed=-20;
			bounce=.4;
			gotoAndStop('dead');
			flying=true;
			parentClass.die();
		}
		private function killSelf(e:Event):void {
			
			if(dist.getObjDist(this, globals.hero)>500){
				parentClass.die();
			}
		}
		protected function personRemove():void {
			globalFunctions.removeFromList(globals.people,this);
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,killSelf, false);
			stopMovement();
		}
	}
}