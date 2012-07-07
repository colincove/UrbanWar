package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.weapons.SingleFireWeapon;
		import com.globalFunctions;
		import com.weapons.MiniBullet;
	import flash.geom.Point;
	import com.Sound.GlobalSounds;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class GausseCannon extends SingleFireWeapon implements WeaponInterface  {
		private var bullet:TankShell;
		
		public function GausseCannon(arm:MovieClip,attackList:Array, strength:int=20):void {
			super();
			this.strength=strength;
			this.attackList=attackList;
			this.arm=arm;
												this.selfReference=this;
			setTimer();
			this.weaponName='GausseCannon';
			this.weaponType=WeaponsEnum.GAUSSE_CANNON;
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void
		{
			GlobalSounds.playSound('GausseShot', 0);
			bullet=new TankShell(Angle,origin,primaryHitCheck, arm, attackList, strength, pointWorth, this.isHeroWpn);
			heatUp();
		}
		public function stopFiring():void 
		{
			if(bullet!=null){
			bullet.removeSelf();
			}
		}
		public function getIcon():MovieClip 
		{
			return new MiniGunIcon();
		}
public function setVars(weaponUpVars:Object):void
{
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}
		public override function destroy():void
		{
			super.destroy();
			if(bullet!=null)
			{
				bullet.destroy();
			}
			bullet=null;
		}
	}
}