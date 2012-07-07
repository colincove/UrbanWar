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
	public class TankGun extends SingleFireWeapon implements WeaponInterface  {
		private var bullet:TankShell;
		private var heat:int;
		public function TankGun(arm:MovieClip,attackList:Array, strength:int=20):void {
			super();
			this.strength=strength;
			this.attackList=attackList;
			this.arm=arm;
			setTimer();
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void {
			if(this.isHeroWpn)
			{
			GlobalSounds.playSound('tankShot', 0);
			}
			bullet=new TankShell(Angle,origin,primaryHitCheck, arm, attackList, strength, pointWorth);
		}
		public function stopFiring():void {
			bullet.removeSelf();
		}
		public function getIcon():MovieClip {
			return new MiniGunIcon();
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
public function setVars(weaponUpVars:Object):void {
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}
	}
}