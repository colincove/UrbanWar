package com.weapons{
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.myMath.dist;
	import com.myMath.myAngle;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import com.interfaces.Program;
	import com.interfaces.dieable;
	import com.enemies.Enemy;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.displayObjects.smallExplosion;

	public class SlowMissile extends Enemy implements Program, dieable {
		public function SlowMissile(xd:int, yd:int):void {
			super();
			globals.game_progThread.addProg(this);
			x=xd;
			y=yd;
			progRun=true;
			health=3;
		}
		public function update():Object 
		{
			moveObj();
			var angle:Number = myAngle.getObjAngle(this, globals.hero);
			xSpeed=Math.cos(angle*(Math.PI/180))*7;
			ySpeed=Math.sin(angle*(Math.PI/180))*7;
			rotation=angle+90;
			var distance:int=dist.getObjDist(this, globals.hero);
			if(distance<50){
				impact();
				globals.hero.hit(x,y,20);
				var Explosion:tmpDisplayObj;
				Explosion=new explosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			}
			checkScreen();
			return this;
		}
		public function impact():void 
		{
			var Explosion:tmpDisplayObj=new explosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			GlobalSounds.playSound('explosion1');
			globalFunctions.explosive(this);
			removeEnemy(false);
				
			removeSelf();
		}
		public override function destroy():void
		{
			super.destroy();
		}
		public function removeSelf():void
		{
			globals.game_progThread.removeProg(this);
			super.destroy();
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		public function die():void 
		{
			removeEnemy();
			globalFunctions.makeDebry("enemyDebry",2,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			super.destroy();
					globals.game_progThread.removeProg(this);

		}
	}
}