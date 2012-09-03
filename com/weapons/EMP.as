package com.weapons
{
	import com.interfaces.WeaponInterface;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import com.globals;

	public class EMP extends Weapon implements WeaponInterface
	{

		public function EMP(attackList:Array ,damage:int=20,heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5, radius:int=50, shotDelay:int=100)
		{
			// constructor code
			this.attackList = attackList;
			this.selfReference = this;

			this.weaponName = 'EMP';
			//this.weaponType=WeaponsEnum.MISSILE_LAUNCHER;
			super();
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void
		{
			trace("FIRE EMP");
			var wave:EMPWave = new EMPWave(Angle, origin, primaryHitCheck, attackList);
			globals.levelObj.addChild(wave);
		}
		public function stopFiring():void 
		{
		}
		public function getIcon():MovieClip 
		{
			return new MovieClip();
		}
		public function setVars(weaponUpVars:Object):void
		{
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}

	}

}