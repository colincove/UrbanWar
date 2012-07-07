package com.weapons{
	import flash.events.Event;
	import flash.geom.Point;
	import com.globals;
	import com.myMath.myAngle;
	import com.globalFunctions;
	import com.Sound.GlobalSounds;
	import com.weapons.ClusterRocket;
	import flash.display.MovieClip;
	public class LockOn extends MovieClip{
		private var originPoint:Point;
		private var primaryHitCheck:MovieClip;
		private var lockTarget:MovieClip;
		private var lock:MovieClip;
		public function LockOn(originPoint:Point,primaryHitCheck:MovieClip,lockTarget:MovieClip):void {
			this.originPoint=originPoint;
			this.lockTarget=lockTarget;
			lock=new MissileLock();
			GlobalSounds.playSound('lockOn');
			this.primaryHitCheck=primaryHitCheck;
			globals.levelObj.addChild(lock);
			addEventListener(Event.ENTER_FRAME, lockedOn, false, 0, true);
		}
		private function lockedOn(e:Event):void {
			lock.x=globalFunctions.getMainX(lockTarget);
			lock.y=globalFunctions.getMainY(lockTarget);
		}
		public function fire():void {
			lock.parent.removeChild(lock);
			removeEventListener(Event.ENTER_FRAME, lockedOn, false);
			var rocket:ClusterRocket = new ClusterRocket(myAngle.getObjAngle(lockTarget, globals.hero)+180,originPoint,primaryHitCheck, new Array(lockTarget),2,2000,10,40);
		}
	}
}