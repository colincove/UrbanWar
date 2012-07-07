package com.weapons{
	import com.interfaces.WeaponInterface;
	import com.globals;
	import com.weapons.ExtendedFireWeapon;
	import com.globalFunctions;
	import flash.geom.Point;
	import com.weapons.LockOn;
	import com.Sound.GlobalSounds;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.display.MovieClip;
	public class ClusterLockLauncher extends ExtendedFireWeapon implements WeaponInterface {
		private var interval:int;
		private var lockSpeed:int;
		private var maxTargets:int;
		private var targetList:Array;
		private var searchList:Array;
		private var origin:Point;
		private var soundChannel:SoundChannel;
		public function ClusterLockLauncher(arm:MovieClip,attackList:Array):void {
			super(0 ,100, 2, 3);
			lockSpeed=8;
			targetList=new Array();
						this.selfReference=this;
setTimer();
			this.weaponName='ClusterLockLauncher';
			this.attackList=attackList;
			maxTargets=5;
			this.arm=arm;
		}
		public function fire(Angle:int,origin:Point, primaryHitCheck:MovieClip, secondaryHitCheck:MovieClip=null):void {
			addEventListener(Event.ENTER_FRAME,lockingOn, false, 0, true);
			soundChannel=GlobalSounds.playSound('locking',10);
			this.origin=origin;
			shooting=true;
			this.primaryHitCheck=primaryHitCheck;
			searchList=globalFunctions.duplicateList(attackList);
		}
		public function stopFiring():void {
			for (var i:int=0; i<targetList.length; i++) {
				targetList[i].fire();
			}
			shooting=false;
			soundChannel.stop();
			soundChannel=null;
			targetList.splice(0);
			removeEventListener(Event.ENTER_FRAME,lockingOn, false);
		}
		public function getIcon():MovieClip {
			return new MiniGunIcon();
		}
		private function lockingOn(e:Event):void {
			interval++;
			if (interval>=lockSpeed) {
				interval=0;
				var target:MovieClip=globalFunctions.getClosestObj(searchList,arm);
				if (target!=null) {
					if (target.isOnScreen()) {
						if (target!=null) {
							GlobalSounds.playSound('lockOn');
							targetList.push(new LockOn(origin,primaryHitCheck,target));
							globalFunctions.removeFromList(searchList, target);
						}
					}
				}
			}
		}
		public function setVars(wpnUpVars:Object):void {
			lockSpeed=wpnUpVars.lockSpeed;
			//set special variables for the specific weapon, ie.clusterLockLauncher requiring a time variable
			//for the speed in which it locks on targets. 
			//will remain empty for weapons that require no extra variables. 
		}

	}
}