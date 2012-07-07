package com.enemies{
	import flash.events.Event;
	import com.interfaces.pausable;
	import com.interfaces.removable;
	import com.physics.objMovement;
	import com.interfaces.dieable;
	import com.interfaces.Program;
	import com.displayObjects.activeObj;
	import flash.geom.Point;
	import com.globalFunctions;
	import com.globals;
	import flash.display.MovieClip;
	import com.displayObjects.tmpDisplayObj;
	import com.myMath.myAngle;
	import com.weapons.Weapon;
	import com.interfaces.WeaponInterface;
	import com.weapons.BombReleaser;
	import com.enemies.Enemy;
	public class Bomber extends Enemy implements dieable,pausable,removable,Program {
		private var interval:int;
		private var arm:MovieClip;
		private var shootPoint:Point;
		private var weapon:Weapon;
		private var parentObj:MovieClip;
		//private var
		public function Bomber():void {
			super("Bomber");
			ghost=true;
			shootPoint = new Point();
			interval=Math.random()*25;
			healthBarObj.modPos(0,-80);
			ySpeed=0;
			size=2;
			Speed=-5;
			bounce=0;
			xSpeed=0;
			grav=0;
			right=true;
			globals.game_progThread.addProg(this);
			progRun=true;
			gotoAndStop('out');
			globalFunctions.removeFromList(globals.activeObjectList, this);
			globalFunctions.removeFromList(globals.enemyList, this);
		}
		public override function destroy():void
		{
			super.destroy();
			arm=null;
			shootPoint=null;
			weapon=null;
			if(weapon!=null)
			{
				weapon.destroy();
			}
			globals.game_progThread.removeProg(this);
			progRun=false;
			parentObj=null;
			weapon=null;
		}
		public function pauseSelf():void {

		}
		public function unpauseSelf():void {

		}
		public function removeSelf():void {
			
		}
		public function update():Object {
				checkScreen();
				if (spawnScreen&&!spawned) 
				{
					spawned=true;
					gotoAndStop('in');
					globals.enemyList.push(this);
					globals.activeObjectList.push(this);
					
				}
				
				if (spawned)
				{
					moveObj();
					xSpeed=Speed;
					interval++;
					movementUpdate();
					if (interval>enemyVars.fireDelay) 
					{
						shootPoint.x=globalFunctions.getMainX(this);
						shootPoint.y=globalFunctions.getMainY(this);
						fire();
						interval=0;
					}

				} else {
					
				}
			
			return this;
		}
		private function fire():void {

			if (weapon==null) {

				weapon=new BombReleaser(globals.heroList,enemyVars.bombRadius,enemyVars.damage);
			}
			WeaponInterface(weapon).fire(0,shootPoint, globals.heroContainer);
		}
		public function die():void {
			removeEnemy();
			if (weapon!=null) {
				WeaponInterface(weapon).stopFiring();
			}
						globals.game_progThread.removeProg(this);

			globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if (parent!=null) {
				parent.removeChild(this);
			}
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}