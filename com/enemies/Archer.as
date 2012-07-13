package com.enemies{
	import flash.events.Event;
	import com.interfaces.pausable;
	import com.interfaces.removable;
	import com.physics.objMovement;
	import com.interfaces.Program;

	import com.interfaces.dieable;
	import com.interfaces.jetPackInterface;
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
	import com.weapons.MissileLauncher;
	import com.enemies.Enemy;
	import com.weapons.jetPack;
	public class Archer extends Enemy implements dieable,pausable,jetPackInterface,removable,Program {
		private var interval:int;
		public var arm:MovieClip;
		private var shootPoint:Point;
		private var weapon:Weapon;

		private var attackMode:Boolean;
		private var jetpack:jetPack;
		public function Archer():void {
			super("Archer");
			shootPoint=new Point  ;
			jetpack=new jetPack(this,-1);
			interval=Math.random()*50;
			healthBarObj.modPos(0,-80);
			ySpeed=0;
			speedMax=5;
			arm=new MovieClip  ;
			this.addChild(arm);
			bounce=0;
			attackMode=false;
			Speed=-2;
			xSpeed=0;
			right=true;
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public override function destroy():void
		{
			super.destroy();
			arm=null;
			progRun=false;
			shootPoint=null;
			weapon=null;
			globals.game_progThread.removeProg(this);
			if(weapon!=null)
			{
				weapon.destroy();
			}
			if(jetpack!=null){
				jetpack.destroy();
			}
			jetpack=null;
			weapon=null;
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function noFuel():void {
		}
		public function removeSelf():void {
			globals.game_progThread.removeProg(this);
			progRun=false;
			if (parent!=null) {
				parent.removeChild(this);
			}
		}
		public function pauseSelf():void {
		}
		public function unpauseSelf():void {
		}
		public function update():Object {
			checkScreen();
			if (onScreen) {
				moveObj();
				if (xSpeed>speedMax) {
					xSpeed/=1.05;
				}

				interval++;
				var xDist:int=globalFunctions.getMainX(this)-globalFunctions.getMainX(globals.hero);
				var yDist:int=globalFunctions.getMainY(this)-globalFunctions.getMainY(globals.hero)-100;
				if (xDist>300) {
					modifySpeedX(-.5);
				}
				if (xDist<200) {
					modifySpeedX(.5);
				}
				if (yDist>0) {
					jetpack.jetPackIgnite();
				} else {
					if (ground!=null) {
						if (ground.hitTestPoint(globalFunctions.getMainX(this),globalFunctions.getMainY(this)+50,true)) {
							jetpack.jetPackIgnite();
						} else {
							if (ySpeed>4) {
								jetpack.jetPackIgnite();
							}
						}
					}
				}
				movementUpdate();
				if (interval==75) {
					xSpeed+=20;
					artwork.animation.gotoAndPlay('shoot');
					shootPoint.x=globalFunctions.getMainX(this);
					shootPoint.y=globalFunctions.getMainY(this);
					fire();
					interval=0;


				}
			}
			return this;
		}
		private function fire():void {
			if (weapon==null) {
				weapon=new MissileLauncher(globals.heroList,50);
			}
			weapon.strength=30;
			WeaponInterface(weapon).fire(180,shootPoint,globals.heroContainer);
		}
		public function die():void {
			globalFunctions.makeDebry("enemyDebry",2,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			removeEnemy();
			removeSelf();
			if (weapon!=null) {
				WeaponInterface(weapon).stopFiring();
			}
			
		}
	}
}