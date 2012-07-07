package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.weapons.SingleFireWeapon;
		import com.globalFunctions;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class MissileLauncher extends SingleFireWeapon implements WeaponInterface  {
		private var heat:int;
		private var speed:int;
		public function MissileLauncher(attackList:Array ,damage:int=20,heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5, radius:int=50, shotDelay:int=100):void {
			super(0, 500, 5, 150,0,0,damage);
			this.attackList=attackList;
			this.selfReference=this;
			setTimer();
			this.weaponName='MissileLauncher';
			this.weaponType=WeaponsEnum.MISSILE_LAUNCHER;
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void {
			
			var miss:missile=new missile(Angle,origin,primaryHitCheck,attackList, strength, pointWorth,isHeroWpn);
			if(isHeroWpn)
			{
				weaponControl.addHeroProjectile(miss);
				GlobalSounds.playSound('missileLaunch');
			miss.Speed=speed;
			miss.defineSpeed();
			}
			heatUp();
						startFireTimer();
		}
		public function stopFiring():void {
		}
		public function getIcon():MovieClip {
			return new MissileLauncherIcon();
		}
public function setVars(weaponUpVars:Object):void {
	speed=wpnUpVars.speed;
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}
	}
}