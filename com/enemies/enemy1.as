package com.enemies{
	import flash.events.Event;
	import com.interfaces.pausable;
	import com.physics.objMovement;
	import com.interfaces.dieable;
	import com.displayObjects.activeObj; 
	import com.weapons.missile;
	import flash.geom.Point;
	import com.globalFunctions;
	import com.globals;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.enemy1Death;
	import com.myMath.myAngle;
	import com.weapons.Weapon;
	import com.weapons.MissileLauncher;
	import com.interfaces.WeaponInterface;
	import com.enemies.Enemy;
	public class enemy1 extends Enemy implements dieable, pausable {
		private var interval:int;
		private var shootPoint:Point;
		private var weapon:Weapon;
		//private var
		public function enemy1():void {
			
			shootPoint = new Point();
			interval=0;
			ySpeed=0;
			addEventListener(Event.ENTER_FRAME, active, false, 0, true);
		}
		public function pauseSelf():void {
			removeEventListener(Event.ENTER_FRAME, active, false);
		}
		public function unpauseSelf():void {
			addEventListener(Event.ENTER_FRAME, active, false, 0, true);
		}
		private function active(e:Event):void {
			if(onScreen){
			interval++;
			if(interval==80){
				fire();
				interval=0;
			}}
		}
		private function fire():void {
			if(weapon==null){
				weapon = new MissileLauncher(globals.heroList);
			}
			shootPoint.x=globalFunctions.getMainX(this);
			shootPoint.y=globalFunctions.getMainY(this);
			//var shot:missile = new missile(myAngle.getObjAngle(this, globals.hero),shootPoint, globals.heroContainer);
			((WeaponInterface)(weapon)).fire(myAngle.getObjAngle(this, globals.hero),shootPoint, globals.heroContainer);
		}
		public function die():void {
			removeEnemy();
			globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			removeEventListener(Event.ENTER_FRAME, active, false);
			var death:tmpDisplayObj = new enemy1Death(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			globals.neutralContainer.addChild(death);
			death.x=globalFunctions.makeX(death,globalFunctions.getMainX(this));
			death.y=globalFunctions.makeY(death,globalFunctions.getMainY(this));
			parent.removeChild(this);
		}
	}
}