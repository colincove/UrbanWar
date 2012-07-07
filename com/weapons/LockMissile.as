package com.weapons{
	import com.globals;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.weapons.Homing;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	public class LockMissile extends Homing implements activeWeaponInterface {
		private var lock:MovieClip;
		private var lockTarget:MovieClip;
		public function LockMissile(originPoint:Point,primaryHitCheck:MovieClip,attackList:Array):void {
			super(Angle,40,originPoint,primaryHitCheck);
			this.attackList=attackList;
			strength=15;
			lock=new MissileLock();
			ground=primaryHitCheck;
			rotation=Angle;
			globals.levelObj.addChild(lock);
			startTrail(5);
			addEventListener(Event.ENTER_FRAME, lockedOn, false, 0, true);
		}
		public function impact():void {
			removeProjectile();
			removeHoming();
			globalFunctions.explosive(this);
			checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			var Explosion:tmpDisplayObj=new explosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			parent.removeChild(this);
		}
	
	}
}