package com.weapons{
	import com.globals;
	import flash.net.URLRequest;
	import com.globalFunctions;
	import com.physics.gravity;
	import com.Sound.GlobalSounds;
	import com.weapons.activeWeapon;
	import flash.events.Event;
	import com.Sound.MySound;
	import flash.geom.Point;
	import com.myMath.myAngle;
	import flash.display.MovieClip;
	public class projectile extends activeWeapon {
		public var Angle:int;
		public var prevX:int;
		public var prevY:int;
		protected var selfReferance:MovieClip;
		//protected var impactSound:MySound;
		private var posDefined:Boolean=false;
		protected var trailSize:int;
		protected var colour:int;
		protected var transparency:Number;
		public function projectile(Angle:int, Speed:Number, originPoint:Point,primaryHitCheck:MovieClip,strength:int=20, pointWorth:int=0):void {
			super(originPoint,primaryHitCheck, strength, null, pointWorth);
			this.Speed=Speed;
			this.Angle=Angle;
			x=globalFunctions.makeX(this,originPoint.x);
			y=globalFunctions.makeY(this,originPoint.y);
			defineSpeed();
		}
		public function styleLine(clip:MovieClip):void{
			globals.trails.graphics.lineStyle(trailSize,colour,transparency);
		}
		public function defineSpeed():void 
		{
			ySpeed=Math.sin(this.Angle*(Math.PI/180))*this.Speed;
			xSpeed=Math.cos(this.Angle*(Math.PI/180))*this.Speed;
		}
		protected function startTrail(trailSize:int=1, colour:int=0xFFFFFF, transparency:Number=1.0):void {
			this.trailSize=trailSize;
			this.colour=colour;
			this.transparency=transparency;
		}
		protected function stopTrail():void
		{

		}
		protected function trail():void {
			rotation=myAngle.getDistAngle(xSpeed,ySpeed);
			if(parent!=null){
				if(!posDefined){
					posDefined=true;
					prevX=x;
					prevY=y;
				}
				globals.trails.graphics.lineStyle(trailSize,colour,transparency);
				globals.trails.graphics.moveTo(prevX, prevY);
				globals.trails.graphics.lineTo(x, y);
				prevX=x;
				prevY=y;
			}
		}
		protected function removeCheck():void {
			if(!onScreen && selfReferance!=null){
				
				selfReferance.removeSelf();
			}
		}
		public override function destroy():void
		{
			super.destroy();
			selfReferance=null;
			removeEventListener(Event.ENTER_FRAME, removeCheck, false);
			removeEventListener(Event.ENTER_FRAME, moveObj, false);
			weaponControl.removeHeroProjectile(this);
			stopTrail();
		}
		protected function removeProjectile():void 
		{
			weaponControl.removeHeroProjectile(this);
			removeEventListener(Event.ENTER_FRAME, removeCheck, false);
			removeEventListener(Event.ENTER_FRAME, moveObj, false);
			stopTrail();
		}
	}
}