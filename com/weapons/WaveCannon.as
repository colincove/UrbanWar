package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.weapons.SingleFireWeapon;
	import com.globalFunctions;
	import com.weapons.Wave;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class WaveCannon extends SingleFireWeapon implements WeaponInterface {
		private var heat:int;
				private var density:int;
		private var degree:int;
		private var speed:int;
		private var waveArray:Vector.<Wave> = new Vector.<Wave>;
		public function WaveCannon(attackList:Array ,damage:int=20,heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5, radius:int=50, shotDelay:int=100):void {
			super(0, 500, 5, 150,0,0,damage);
			this.attackList=attackList;
			this.selfReference=this;
			setTimer();
			this.weaponName='WaveCannon';
			this.weaponType=WeaponsEnum.WAVE_CANNON;
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void 
		{
			GlobalSounds.playSound('WaveShot');
			if(waveArray==null){
				waveArray= new Vector.<Wave>;
			}
			waveArray.push(new Wave(Angle,origin,primaryHitCheck,attackList,strength, density, degree, pointWorth, speed));
			if(isHeroWpn)
			{
			weaponControl.addHeroProjectile(waveArray[waveArray.length-1]);
			waveArray[waveArray.length-1].makeHeroWave();
			}
			heatUp();
			startFireTimer();
		}
		public function stopFiring():void
		{
		}
		public function getIcon():MovieClip
		{
			return new WaveIcon();
		}
		public override function destroy():void
		{
			super.destroy();
			for each(var wave:Wave in waveArray)
			{
				wave.destroy();
			}
			waveArray.slice(0);
			waveArray=null;
		}
		public function setVars(weaponUpVars:Object):void
		{
			density=wpnUpVars.density;
			degree=wpnUpVars.degree;
			speed=wpnUpVars.speed;
			
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}
	}
}