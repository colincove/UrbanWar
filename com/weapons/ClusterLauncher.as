package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.weapons.SingleFireWeapon;
	import com.weapons.ClusterRocket;
	import com.globalFunctions;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class ClusterLauncher extends SingleFireWeapon implements WeaponInterface {
		private var interval:int;
		private var infoArray:Array;
		private var shootSpace:int;
		private var shootCheck:int;
		private var missileCount:int;
		private var heat:int;
		public function ClusterLauncher(attackList:Array):void {
			super(0, 500, 5, 50);
			//heat:int=0, heatCapacity:int=20, coolSpeed:int=2, heatSpeed:int =5
			this.attackList=attackList;
			infoArray=new Array();
			shootCheck=1;
			this.selfReference=this;
			setTimer();
			shootSpace=2;
			this.weaponType=WeaponsEnum.CLUSTER_LAUNCHER;
			this.weaponName='ClusterLauncher';
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void {
			infoArray[0]=Angle;
			infoArray[1]=origin;
			infoArray[2]=primaryHitCheck;
			for (var i:int =0; i<missileCount; i++) {
				heatUp();
				var miss:ClusterRocket=new ClusterRocket(infoArray[0]+((Math.random()-Math.random())*(20+missileCount*5)),infoArray[1],infoArray[2],attackList,strength, 5,300,1,40,pointWorth,isHeroWpn);
				if(isHeroWpn)
				{
					weaponControl.addHeroProjectile(miss);
				}
			}
			
			startFireTimer();
		}
		public function stopFiring():void {
		}
		public function getIcon():MovieClip {
			return new ClusterLauncherIcon();
		}
		private function firing():void {
			interval++;
			if (interval==shootCheck&&interval<6) {
				shootCheck+=shootSpace;
				heatUp();
				var miss:ClusterRocket=new ClusterRocket(infoArray[0]+((Math.random()-Math.random())*30),infoArray[1],infoArray[2],attackList);
			}
		}
		public function setVars(wpnUpVars:Object):void {
			missileCount=wpnUpVars.missileCount;

			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}
public override function destroy():void
{
	super.destroy();
	infoArray.slice(0);
}
	}
}