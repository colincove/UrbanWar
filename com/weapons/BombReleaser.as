package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.weapons.SingleFireWeapon;
	import com.globalFunctions;
	import com.weapons.Bomb;
	import flash.geom.Point;
	import flash.events.Event;
	import com.Sound.GlobalSounds;

	import flash.display.MovieClip;
	public class BombReleaser extends SingleFireWeapon implements WeaponInterface {
		private var heat:int;
		public function BombReleaser(attackList:Array, radius:int=50, damage:int=50):void {
			super(0, 500, 5, 150, radius, damage);
			//heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5
			this.attackList=attackList;
			this.selfReference=this;
			this.weaponName='BombReleaser';
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null ):void {
			var miss:Bomb=new Bomb(origin,primaryHitCheck,attackList, radius,strength);
			GlobalSounds.playSound('bombFall');
			heatUp();
		}
		public function stopFiring():void {
		}
		public function getIcon():MovieClip {
			return new MissileLauncherIcon();
		}
		public function setVars(weaponUpVars:Object):void {
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}

	}
}