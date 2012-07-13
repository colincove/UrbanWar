package com.enemies{
	import flash.events.Event;
	import com.interfaces.Program;
	import com.interfaces.pausable;
	import com.interfaces.removable;
	import com.interfaces.dieable;
	import com.displayObjects.activeObj;
	import flash.geom.Point;
	import com.globalFunctions;
	import com.globals;
		import com.Sound.GlobalSounds;
	import flash.display.MovieClip;
	import com.displayObjects.tmpDisplayObj;
	import com.myMath.myAngle;
	import com.weapons.Weapon;
	import com.interfaces.WeaponInterface;
	import com.weapons.MissileLauncher;
	import com.enemies.Enemy;
	public class SpinBot extends Enemy implements dieable,pausable, removable, Program {
		private var interval:int;
		private var arm:MovieClip;
		private var shootPoint:Point;
		private var weapon:Weapon;
		private var airFric:Number=1.1;
		public function SpinBot():void 
		{
			super("Spinbot");
			shootPoint = new Point();
			interval=Math.random()*100;
			healthBarObj.modPos(0,-80);
			ySpeed=0;
			bounce=0;
			arm = new MovieClip();
			Speed=enemyVars.movePow;
			this.grav=0;
			right=true;
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
				public function isRunning():Boolean
				{
			return progRun;
		}

		public function removeSelf():void {
			
		}
		public function added(e:Event):void {
			this.addChild(arm);
			globals.game_progThread.addProg(this);
			progRun=true;
			removeEventListener(Event.ADDED_TO_STAGE, added, false);
		}
		public function pauseSelf():void {
		}
		public function unpauseSelf():void {
		}
		public function update():Object{
			movementUpdate();
			moveObj();
			checkScreen();
			xSpeed/=airFric;
			ySpeed/=airFric;
			rotation+=Math.abs(xSpeed)+Math.abs(ySpeed);
			if (onScreen) {
				interval++;
				arm.rotation+=myAngle.angleDiff(arm.rotation,myAngle.getObjAngle(this,globals.hero) )/15;
				shootPoint.x=globalFunctions.getMainX(arm);
				shootPoint.y=globalFunctions.getMainY(arm);
				if (interval==enemyVars.fireDelay) {
					spinMove();
					for(var i:int=0;i<360;i+=45){
						arm.rotation=i+rotation;
						fire();
					}
					interval=0;
					xSpeed=- xSpeed;
				}
			}
			return this;
		}
		private function spinMove():void {
			GlobalSounds.playSound('spinMove');
			ySpeed=(Math.random()-Math.random())*Speed;
			xSpeed=(Math.random()-Math.random())*Speed;
		}
		private function fire():void {
			if (weapon==null) {
				trace("SPIN BOT",enemyVars.damage);
				weapon=new MissileLauncher(globals.heroList, enemyVars.damage);
			}
			WeaponInterface(weapon).fire(arm.rotation,shootPoint, globals.heroContainer);
		}
		public function die():void 
		{
			removeEnemy();
			globals.game_progThread.removeProg(this);
			globalFunctions.makeDebry("enemyDebry",2,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if(parent!=null){
			parent.removeChild(this);
			}
		}
	}
}