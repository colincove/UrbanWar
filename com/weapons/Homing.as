package com.weapons{
	import com.globals;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.myMath.*;
	public class Homing extends projectile 
	{
		protected var homingVar:Number;
		private var xDist:int;
		private var yDist:int;
		private var distance:int;
		private var followMultiplier:int;
		protected var homeRadius:int;
		public function Homing(Angle:int, Speed:Number, originPoint:Point,primaryHitCheck:MovieClip,strength:int=20,followMultiplier:int=5,homeRadius:int=300,homingVar:int=1, pointWorth:int=0):void {
			super(Angle,Speed,originPoint,primaryHitCheck, strength, pointWorth);
			this.followMultiplier=followMultiplier;
			this.homeRadius=homeRadius;
			this.homingVar=homingVar;
			
		}

		public function HomeIn():void {
			if (parent!=null) {
				for (var i:int =0; i<attackList.length; i++) {
					if (attackList[i].parent!=null&&attackList[i]!=globals.hero) {
						distance=dist.getObjDist(this,attackList[i]);
						if (distance<homeRadius) {
							homeRadius=distance;
							Angle=myAngle.getObjAngle(this,attackList[i]);
							//xSpeed+=Math.cos(Angle*(Math.PI/180))*followMultiplier;
							//ySpeed+=Math.sin(Angle*(Math.PI/180))*followMultiplier;
							xSpeed=Math.cos(Angle*(Math.PI/180))*Speed;
							ySpeed=Math.sin(Angle*(Math.PI/180))*Speed;
						}
					}
				}
			}

		}
		/*public function HomeIn(e:Event):void {
		for (var i:int =0; i<globals.enemyList.length; i++) {
		if (globals.enemyList[i].parent!=null) {
		distance=dist.getObjDist(this,globals.enemyList[i]);
		if (distance<homeRadius) {
		Angle=myAngle.getObjAngle(this,globals.enemyList[i]);
		xSpeed+=Math.cos(Angle*(Math.PI/180))*followMultiplier;
		ySpeed+=Math.sin(Angle*(Math.PI/180))*followMultiplier;
		}
		}
		}
		}*/
		protected function removeHoming():void {
			
		}
	}
}