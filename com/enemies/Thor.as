package com.enemies{
	import flash.events.Event;
	import com.interfaces.pausable;
	import com.interfaces.removable;
	import com.physics.objMovement;
	import com.interfaces.dieable;
	import com.interfaces.Program;
	import com.displayObjects.activeObj;
	import flash.geom.Point;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.globals;
	import flash.display.MovieClip;
	import com.displayObjects.tmpDisplayObj;
	import com.myMath.myAngle;
	import com.weapons.Weapon;
	import com.interfaces.WeaponInterface;
	import com.weapons.TankGun;
	import com.weapons.ClusterLauncher;
	import com.enemies.Enemy;
	import com.weapons.EMP;
	import com.weapons.MissileLauncher;

	public class Thor extends Enemy implements dieable,pausable, removable, Program {
		private var interval:int;
		public var arm:MovieClip;
		private var shootPoint:Point;
		private var weapon:Weapon;
		private var groundWeapon:Weapon;
		private var airWeapon:Weapon;
		private var emp:EMP;
		private var attackMode:Boolean;
		//private var
		public function Thor():void {
		super("Thor");
			shootPoint = new Point();
			interval=Math.random()*25;
			healthBarObj.modPos(0,-80);
			ySpeed=0;
			size=3;
			arm=new MovieClip();
			this.addChild(arm);
			bounce=0;
			attackMode=false;
			grav=0;
			Speed=-2;
			xSpeed=0;
			right=true;
			emp = new EMP(globals.heroList);
			
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public override function destroy():void
		{
			super.destroy();
			arm=null;
			shootPoint=null;
			weapon=null;
			progRun=false;
			globals.game_progThread.removeProg(this);
			if(groundWeapon!=null)
			{
				groundWeapon.destroy();
			}
			if(airWeapon!=null)
			{
				airWeapon.destroy();
				
			}
			if(emp!=null)
			{
				emp.destroy();
			}
			emp=null;
			airWeapon=null;
			groundWeapon=null;
		}
				public function isRunning():Boolean
				{
			return progRun;
		}
				public function removeSelf():void 
				{
			pauseSelf();
			if(parent!=null){
			parent.removeChild(this);
			}
		}
		public function pauseSelf():void {
		}
		public function unpauseSelf():void {
		}
			public function update():Object{
				checkScreen();
			if (onScreen) {
				
				xSpeed=Speed;
				
				if (attackMode) 
				{
					interval++;
					arm.rotation=myAngle.getObjAngle(animation.body,globals.hero);
					if (globals.hero.getHaveAir()) 
					{
						animation.body.rotation=arm.rotation+180;
						animation.gun.rotation=0;
						weapon=airWeapon;
					} 
					else 
					{
						weapon=groundWeapon;
						animation.gun.rotation=arm.rotation+180;
						animation.body.rotation=0;
					}
					if (interval>15)
					{
						if(globals.hero.getHaveAir()){
							shootPoint.x=globalFunctions.getMainX(animation.body);
						shootPoint.y=globalFunctions.getMainY(animation.body);
						animation.body.gotoAndPlay('shoot');
						}else{
							animation.gun.gotoAndPlay('shoot');
							var modX1:int= Math.cos((arm.rotation-90)*(Math.PI/180))*65;
							var modY1:int= Math.sin((arm.rotation-90)*(Math.PI/180))*65;
							var modX2:int= Math.cos((arm.rotation)*(Math.PI/180))*50;
							var modY2:int= Math.sin((arm.rotation)*(Math.PI/180))*50;
							arm.x=animation.gun.x+modX1+modX2;
							arm.y=animation.gun.y+modY1+modY2;
						arm.rotation=myAngle.getObjAngle(arm,globals.hero);
						}
						
						fire();
						interval=0;
					}
				} else {
					movementUpdate();
					moveObj();
					if (Math.abs(globalFunctions.getMainX(this)-globals.HUD.x)<350)
					{
					attackMode=true;
					emp.fire(arm.rotation,shootPoint, globals.heroContainer);
					animation.gotoAndStop('Shooting');
					xSpeed=0;
				}
				}
			} else {
			}
			return this;
		}
		private function fire():void 
		{
			if (weapon==null) 
			{
				groundWeapon=new TankGun(arm,globals.heroList);
				//airWeapon=new ClusterLauncher(globals.heroList);
				airWeapon=new MissileLauncher(globals.heroList);
				weapon=groundWeapon;
			}
			WeaponInterface(weapon).fire(arm.rotation,shootPoint, globals.heroContainer);
		}
		public function thorStep():void {
			GlobalSounds.playSound('thorStep');
		}
		public function die():void {
			removeEnemy();
			if (weapon!=null) {
				WeaponInterface(weapon).stopFiring();
			}
			globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if (parent!=null) {
				parent.removeChild(this);
			}
		}
	}
}