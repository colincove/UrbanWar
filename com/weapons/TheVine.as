package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.weapons.SingleFireWeapon;
	import com.globalFunctions;
	import com.weapons.Vine;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class TheVine extends SingleFireWeapon implements WeaponInterface {
		private var heat:int;
				private var density:int;
		private var degree:int;
		public function TheVine(attackList:Array ,damage:int=20,heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5, radius:int=50, shotDelay:int=100):void {
			super(0, 500, 5, 150,0,0,damage);
			this.attackList=attackList;
			this.selfReference=this;
			this.weaponType=WeaponsEnum.VINE;
			setTimer();
			this.weaponName='TheVine';
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void {
			GlobalSounds.playSound('VineShot');
			var vine:Vine=new Vine(Angle,origin,primaryHitCheck,attackList,strength, density, degree , pointWorth, shotDelay);
			heatUp();
			startFireTimer();

		}
		public function stopFiring():void {
		}
		public function getIcon():MovieClip {
			return new VineIcon();
		}
		public function setVars(weaponUpVars:Object):void {
			density=wpnUpVars.density;
			degree=wpnUpVars.degree;
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}
	}
}