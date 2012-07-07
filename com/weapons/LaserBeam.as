package com.weapons{
	import com.globals;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import com.weapons.Laser;
	import com.weapons.ExtendedFireWeapon;
	import flash.geom.Point;
	import flash.display.MovieClip;
	public class LaserBeam extends Laser implements activeWeaponInterface 
	{
		public function LaserBeam(Angle:int, originPoint:Point,primaryHitCheck:MovieClip, arm:MovieClip, attackList:Array, weapon:ExtendedFireWeapon, strength:int=20, pointWorth:int=0):void {
			super(Angle,originPoint,primaryHitCheck, arm, weapon,strength, pointWorth);
			this.attackList=attackList;
			switch(weapon.currentUpgrade)
			{
				case 0:
				case 1:
				case 2:
				case 3:
				bulletArtwork=new LaserCannon3Artwork();
				break;
				default:
				bulletArtwork=new LaserCannonArtwork();
				
			}
			
			ground=primaryHitCheck;
			fireBullet();
		}
	}
}