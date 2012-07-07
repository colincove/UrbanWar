package com.worldObjects{
	import flash.events.Event;
	import com.interfaces.pausable;
	import com.physics.objMovement;
	import com.interfaces.Program;
	import com.interfaces.dieable;
	import com.displayObjects.activeObj;
	import com.weapons.missile;
	import flash.geom.Point;
	import com.items.FuelItem;
	import com.globalFunctions;
	import com.globals;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.enemy1Death;
	import com.myMath.myAngle;
	import com.items.ShieldItem;

	public class blimp extends objMovement implements dieable,pausable,Program {
		private var interval:int;
		private var shootPoint:Point;
		public function blimp():void {
			shootPoint = new Point();
			interval=0;
			ground=globals.groundContainer;
			ySpeed=0;
			grav=0;
			Speed=-globals.gameVars.blimpVars.speed;
			health=globals.gameVars.blimpVars.health;
			xSpeed=Speed;
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function pauseSelf():void {
			xSpeed=0;
		}
		public function unpauseSelf():void {
			xSpeed=Speed;
		}
		public function update():Object {
			checkScreen();
			if (onScreen) {
				xSpeed=Speed;
				moveObj();
				movementUpdate();
			} else {
				xSpeed=0;
			}
			return this;

		}
		public function die():void {
			var fuel:ShieldItem = new ShieldItem();
			parent.addChild(fuel);
			fuel.x=x;
			globals.game_progThread.removeProg(this);

			fuel.y=y;
			globalFunctions.makeDebry("houseDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			parent.removeChild(this);
		}
	}
}