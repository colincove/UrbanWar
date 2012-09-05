package com.weapons{
	import com.globals;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import com.interfaces.Program;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.displayObjects.smallExplosion;

	public class Bomb extends projectile implements activeWeaponInterface,Program {
		public function Bomb( originPoint:Point,primaryHitCheck:MovieClip,attackList:Array, radius:int=5, strength:int=20, reverse:int=1):void {
			super(Angle,20,originPoint,primaryHitCheck);
			this.attackList=attackList;
			this.strength=strength;
			this.radius=radius;
			ground=primaryHitCheck;
			Speed=-5;
			xSpeed=Speed*reverse;
			selfReferance=this;
			startTrail(10);
			globals.game_progThread.addProg(this);
			progRun=true;

		}
		public function impact():void {
			globalFunctions.explosive(this);
			var targetObj:Object=checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			checkAreaDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			var Explosion:tmpDisplayObj;
			if(targetObj==null)
			{
				Explosion=new smallExplosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			}else{
				Explosion=new explosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			}	
			removeSelf();
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function update():Object {
			trail();
			checkScreen();
			moveObj();
			removeCheck();
			trailSize=ySpeed;
			rotation=Math.atan2(ySpeed, xSpeed)/(Math.PI/180);
			xSpeed/=1.1;
			x+=xSpeed;
			gravPull();
			return this;
		}
		public function removeSelf():void {
			removeProjectile();
			destroy();
			globals.game_progThread.removeProg(this);
		}
	}
}