package com.enemies{
	import flash.events.Event;
	import com.interfaces.pausable;
	import com.interfaces.Program;
	import com.physics.objMovement;
	import com.interfaces.dieable;
	import com.displayObjects.activeObj;
	import flash.geom.Point;
	import com.globalFunctions;
	import com.globals;
	import com.interfaces.removable;
	import flash.display.MovieClip;
	import com.displayObjects.tmpDisplayObj;
	import com.myMath.myAngle;
	import com.weapons.Weapon;
	import com.interfaces.WeaponInterface;
	import com.weapons.MissileLauncher;
	import com.weapons.MiniGun;
	import com.enemies.Enemy;
	public class Droid extends Enemy implements dieable,pausable, removable, Program {
		private var interval:int;
		private var arm:MovieClip;
		private var shootPoint:Point;
		private var weapon:Weapon;
		//private var
		public function Droid():void {
			super('Droid');
			shootPoint = new Point();
			interval=81;
			healthBarObj.modPos(0,-80);
			ySpeed=0;
			bounce=0;
			size=2;
			arm = new DroidArm();
			arm.y=-50;
			arm.x=15;
			
			Speed=2;
			right=true;
			xSpeed=Speed;
			weapon=new MiniGun(arm,globals.heroList,enemyVars.damage,enemyVars.fireDelay);
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}
		public override function destroy():void
		{
			super.destroy();
			arm=null;
			shootPoint=null;
			
			progRun=false;
			globals.game_progThread.removeProg(this);
			if(weapon!=null)
			{
				weapon.destroy();
			}
			
			weapon=null;
		}
				public function isRunning():Boolean{
			return progRun;
		}
		public function removeSelf():void 
		{
			pauseSelf();
			
			destroy();
		}
		public function added(e:Event):void {
			this.addChild(arm);
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public function pauseSelf():void 
		{
		}
		public function unpauseSelf():void 
		{
		}
		
		public function update():Object
		{
			
			checkScreen();
			if (onScreen)
			{
				moveObj();
				interval++;
				arm.rotation+=myAngle.angleDiff(arm.rotation,myAngle.getObjAngle(this,globals.hero))/15;
				shootPoint.x=globalFunctions.getMainX(arm);
				shootPoint.y=globalFunctions.getMainY(arm);
				movementUpdate();
				if (interval==80) {
					
					WeaponInterface(weapon).stopFiring();
					xSpeed=- xSpeed;
				}
				//81 should be 150
				if (interval==150) 
				{
					fire();
					interval=0;
					xSpeed=- xSpeed;
				}
			} else {
				xSpeed=0;
			}
			return this;
		}
		private function fire():void {
			if (weapon!=null)
			{
				
			
			WeaponInterface(weapon).fire(myAngle.getObjAngle(arm, globals.hero),shootPoint, globals.groundContainer,globals.heroContainer);
			}
		}
		public function die():void 
		{
			removeEnemy();
			removeSelf();
			if (weapon!=null) 
			{
				WeaponInterface(weapon).stopFiring();
			}
			globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if (parent!=null) {
				parent.removeChild(this);
			}
					globals.game_progThread.removeProg(this);

		}
	}
}