package com.enemies{
	import flash.events.Event;
	import com.interfaces.pausable;
	import com.interfaces.Program;
	import com.interfaces.removable;
	import com.interfaces.dieable;
	import com.displayObjects.activeObj;
	import flash.geom.Point;
	import com.globalFunctions;
	import com.globals;
	import flash.display.MovieClip;
	import com.displayObjects.tmpDisplayObj;
	import com.myMath.myAngle;
	import com.weapons.Weapon;
	import com.interfaces.WeaponInterface;
	import com.weapons.TankGun;
	import com.enemies.Enemy;
	public class Tank extends Enemy implements dieable,pausable,removable,Program {
		private var interval:int;
		private var arm:MovieClip;
		private var shootPoint:Point;
		private var weapon:Weapon;
		private var myX:Number;
		private var myY:Number;
		public function Tank():void {
			super("Tank");
			shootPoint = new Point();
			interval=Math.random()*enemyVars.fireDelay;
			healthBarObj.modPos(0,-80);
			ySpeed=0;
			bounce=1;
			size=2;
			arm = new TankArm();
			arm.y=-40;
			arm.x=-10;
			Speed=1;
			right=true;
			xSpeed=Speed;
			myX=x;
			myY=y;
			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
		}
		public override function destroy():void
		{
			super.destroy();
			arm=null;
			shootPoint=null;
			weapon=null;
			progRun=false;
			globals.game_progThread.removeProg(this);
			if(weapon!=null)
			{
				weapon.destroy();
			}
			
			weapon=null;
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function added(e:Event):void {
			this.addChild(arm);
			fire();
			globals.game_progThread.addProg(this);
			progRun=true;
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
		}
		public function removeSelf():void {
			
			destroy();
			pauseSelf();
			if (parent!=null) {
				parent.removeChild(this);
			}
		}
		public function pauseSelf():void 
		{
		}
		public function unpauseSelf():void 
		{
		}
		public function update():Object
		{
			movementUpdate();
			checkScreen();
			x=myX;
			y=myY;
			if (onScreen) 
			{
				interval++;
				shootPoint.x=globalFunctions.getMainX(arm);
				shootPoint.y=globalFunctions.getMainY(arm);
				if (interval<enemyVars.fireDelay-10&&interval>10) {
					arm.rotation+=myAngle.angleDiff(arm.rotation,myAngle.getObjAngle(this,globals.hero))/15;

				}
				if (interval>130) 
				{
					xSpeed=0;
				}
				if (interval==20)
				{
					xSpeed=Speed;
				}

				if (interval==enemyVars.fireDelay) 
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
		private function fire():void 
		{
			if (weapon==null) {
				weapon=new TankGun(arm,globals.heroList, globals.gameVars.enemyVars.Tank.damage);
			}
			arm.play();
			this.animation.play();
			WeaponInterface(weapon).fire(myAngle.getObjAngle(arm, globals.hero),shootPoint, globals.heroContainer);
		}
		public function die():void 
		{
			removeEnemy();
			globals.game_progThread.removeProg(this);

if(weapon!=null)
{
   WeaponInterface(weapon).stopFiring();
}
			globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if(parent!=null)
			{
			parent.removeChild(this);
			}
		}
	}
}