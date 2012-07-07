package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.weapons.ExtendedFireWeapon;
	import com.globalFunctions;
	import com.weapons.MiniBullet;
	import flash.media.SoundChannel;
	import flash.geom.Point;
	import flash.events.Event;
	import com.Sound.GlobalSounds;
	import flash.display.MovieClip;
	public class LaserCannon extends ExtendedFireWeapon implements WeaponInterface {
		private var bullet:LaserBeam;
		private var soundChannel:SoundChannel;
		public function LaserCannon(arm:MovieClip,attackList:Array):void {
			super(0 ,500, 2, 8);
			this.selfReference=this;
			this.weaponName='LaserCannon';
			this.attackList=attackList;
			this.arm=arm;
			this.weaponType=WeaponsEnum.LASER;
			heavyWeapon=true;
		}
				public override function destroy():void
		{
			super.destroy();
			if(bullet!=null)
			{
				bullet.destroy();
			}
			soundChannel=null;
			bullet=null;
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void 
		{
			bullet=new LaserBeam(Angle,origin,globals.enemyContainer,arm,attackList, this, strength, pointWorth);
			//bullet=new LaserBeam(Angle,origin,primaryHitCheck,arm,attackList, this, strength);
			soundChannel=GlobalSounds.playSound('laser',10);
			GlobalSounds.playSound('laserStart');
		}
		public function stopFiring():void {
			if(soundChannel!=null){
			soundChannel.stop();
			soundChannel=null;
			}
			stopExtendedWeapon();
			if (bullet!=null) {
				bullet.removeSelf();
			}
		}
		public function getIcon():MovieClip {
			return new LaserIcon();
		}
		public function setVars(wpnUpVars:Object):void {
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
						heavyWpnWeight=wpnUpVars.weight;

		}
	}
}