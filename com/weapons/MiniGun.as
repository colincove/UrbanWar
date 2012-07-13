package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import flash.media.SoundChannel;
	import com.weapons.ExtendedFireWeapon;
	import com.globalFunctions;
	import com.weapons.MiniBullet;
	import com.Sound.GlobalSounds;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class MiniGun extends ExtendedFireWeapon implements WeaponInterface {
		private var bullet:MiniBullet;
		private var stager:int;
		private var soundChannel:SoundChannel;
		public function MiniGun(arm:MovieClip,attackList:Array, damage:int=5, shotDelay:int=100, stager:int=7):void {
			super(0 ,100, 2, 3, damage, shotDelay);
			this.selfReference=this;
			this.weaponName='MiniGun';
			this.attackList=attackList;
			this.arm=arm;
			this.stager=stager;
			this.weaponType=WeaponsEnum.MINI_GUN;
		}
				public override function destroy():void
		{
			super.destroy();
			if(bullet!=null)
			{
				stopFiring();
				bullet.destroy();
			}
			bullet=null;
			soundChannel=null;
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void {
			bullet=new MiniBullet(Angle,origin,primaryHitCheck,arm,attackList,shotDelay,this,strength,secondaryHitCheck, stager, pointWorth,this.isHeroWpn);
			shooting=true;
			if(this.isHeroWpn)
			{
				bullet.isHeroWeapon=true;
				soundChannel=GlobalSounds.playSound('miniGun',10);
			}
		}
		public function stopFiring():void
		{
			if (bullet!=null) 
			{
				bullet.removeSelf();
			}
			stopExtendedWeapon();
			if (soundChannel!=null)
			{
				soundChannel.stop();
				soundChannel=null;
			}
		}
		public function getIcon():MovieClip {
			return new MiniGunIcon();
		}
		private function setStager(stager:int=20):void {
			this.stager=stager;
		}
		
		public function setVars(wpnUpVars:Object):void {
			setStager(wpnUpVars.stager);
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}
	}
}