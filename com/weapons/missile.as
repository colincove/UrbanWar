package com.weapons{
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.displayObjects.smallExplosion;
	import com.interfaces.activeWeaponInterface;
	import com.interfaces.Program;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.displayObjects.activeObj;

	public class missile extends projectile implements activeWeaponInterface,Program {
		public function missile(Angle:int, originPoint:Point,primaryHitCheck:MovieClip,attackList:Array, strength:int=20, pointWorth:int=0, isHeroWeapon:Boolean=false):void {
			super(Angle,20,originPoint,primaryHitCheck, strength, pointWorth);
			this.attackList=attackList;
			ground=primaryHitCheck;
			rotation=Angle;
			globals.game_progThread.addProg(this);
			startTrail(20);
			selfReferance=this;
			progRun=true;
			this.isHeroWeapon=isHeroWeapon;
		}
		public function update():Object {
			trail();
			moveObj();
			checkScreen();
			removeCheck();
			return this;
		}
		public function impact():void {

			GlobalSounds.playSound('explosion1');
			globalFunctions.explosive(this);

			var targetObj:activeObj=checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if (isHeroWeapon) {
				if (targetObj!=null&&targetObj!=globals.hero) {
					AccuracyStats.addHit();
				} else {
					AccuracyStats.addMiss();
				}
			}
			var dontDmg:Boolean=false;
			if (isHeroWeapon) {
				if (targetObj!=null) {
					if (targetObj==globals.hero) {
						dontDmg=true;
					}
				}
			}
			if (! dontDmg) {
				var Explosion:tmpDisplayObj;
				if (targetObj==null) {
					Explosion=new smallExplosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
				} else {
					Explosion=new explosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
				}
				removeSelf();
			}
		}
		public function removeSelf():void {

			globals.game_progThread.removeProg(this);
			removeProjectile();
			parent.removeChild(this);
			destroy();
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}