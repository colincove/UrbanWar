package com.weapons{
	import com.globals;
	import com.globalFunctions;
	import com.weapons.ExtendedFireWeapon;
	import com.weapons.activeWeapon;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import com.weapons.Bullet;
	import flash.geom.Point;
	import flash.display.MovieClip;
	public class MiniBullet extends Bullet implements activeWeaponInterface {
		public function MiniBullet(Angle:int, originPoint:Point,primaryHitCheck:MovieClip, arm:MovieClip, attackList:Array, fireDelay:int=100, weapon:ExtendedFireWeapon=null, strength:int=0,secondaryHitCheck:MovieClip=null,stager:int=7, pointWorth:int=0, isHeroWeapon:Boolean=false):void
		{
			super(Angle,originPoint,primaryHitCheck, arm,fireDelay, weapon, strength, secondaryHitCheck, stager, pointWorth);
			this.attackList=attackList;
			switch(weapon.currentUpgrade)
			{
				case 0:
				case 1:
				case 2:
				case 3:
				bulletArtwork=new MiniGun3Artwork();
				break;
				default:
				bulletArtwork=new MiniGunArtwork();
				
			}
			//bulletArtwork=new MiniGunArtwork();
			ground=primaryHitCheck;
			this.isHeroWeapon=isHeroWeapon;
			fireBullet();
		}
	}
}