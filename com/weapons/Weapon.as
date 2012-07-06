package com.weapons
{
	import com.globals;
	import com.globalFunctions;
	import com.interfaces.Program;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.weapons.ExtendedFireWeapon;
	import com.Sound.GlobalSounds;
	import com.GameComponent;
	public class Weapon extends GameComponent implements Program
	{
		private var hitCheck:pointOfDamage;
		public var strength:int;
		protected var loadOut:Boolean;
		protected var selfReference:MovieClip;
		protected var attackList:Array;
		protected var primaryHitCheck:MovieClip;
		public var weaponName:String;
		private var heat:int;
		private var intervalTimer:Timer;
		protected var shotDelay:int;
		protected var shooting:Boolean;
		protected var heavyWeapon:Boolean;
		private var heatCapacity:int;
		protected var overheated:Boolean;
		private var coolSpeed:int;
		private var heatInterval:int;
		public var pointWorth:int = 0;
		private var heatSpeed:int;
		public var currentUpgrade:int;
		protected var radius:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public var wpnVars:Object;//weaponVars
		public var wpnUpVars:Object;//weaponUpgradeVars
		protected var arm:MovieClip;
		private var interval:int;
		private var isHeroWeapon:Boolean = false;
		public var heavyWpnWeight:int = 1;
		public var isHeroWpn:Boolean = false;
		private var _purchased:Boolean = true;
		public var isNew:Boolean = false;
		public function get purchased():Boolean
		{
			return _purchased;
		}
		public function set purchased(value:Boolean)
		{
			if (value)
			{
				isNew = true;
			}
			_purchased = value;
		}

		public var weaponType:String = '-1';
		protected var heatIntervalThing:int = 0;
		public function Weapon(heat:int=0, heatCapacity:int=1000000, coolSpeed:int=2, heatSpeed:int =5, strength:int=5, shotDelay:int=100, radius:int=50):void
		{
			setHeat(heat);
			shooting = false;//the hole 'isShooting()' thing is onlt useful for constant shoot weapons like miniGun. 
			//It needs to be always true for single shot weapon like the missile launcher. 
			//So i will default it to true. 
			overheated = false;
			setShotDelay(shotDelay);
			setStrength(strength);
			setHeatCapacity(500);
			setCoolSpeed(coolSpeed);
			setHeatSpeed(heatSpeed);
			setRadius(radius);
			weaponName = 'default';
			heatInterval = 20;
			interval = 0;
			globals.game_progThread.addProg(this);
			progRun = true;
		}
		public function isLoadOut():Boolean
		{
			return loadOut;
		}
		public function setLoadOut(make:Boolean=false):void
		{
			loadOut = make;
		}
		public function reloadWeapon():void
		{
			progRun = true;
			if (hitCheck==null)
			{
			}
			//globals.game_progThread.addProg(this);
			attackList = globals.enemyList;
			arm = globals.hero.armCannon;
		}
		public function isHeavy():Boolean
		{
			return heavyWeapon;
		}
		protected function startFireTimer():void
		{
			shooting = true;
			intervalTimer.addEventListener(TimerEvent.TIMER, fireTimer, false, 0, true);
			intervalTimer.start();
		}
		protected function setTimer():void
		{
			intervalTimer = new Timer(shotDelay,0);
			intervalTimer.addEventListener(TimerEvent.TIMER, fireTimer, false, 0, true);
			intervalTimer.start();
		}
		private function fireTimer(e:TimerEvent):void
		{
			if (intervalTimer!=null)
			{
				intervalTimer.stop();
				intervalTimer.reset();
				intervalTimer.removeEventListener(TimerEvent.TIMER, fireTimer, false);
			}
			shooting = false;


		}
		public function setArm(arm:MovieClip):void
		{
			this.arm = arm;
		}
		public function setAttackList(list:Array):void
		{
			this.attackList = list;
		}
		public function setRadius(radius:int):void
		{
			this.radius = radius;
		}
		public function getName():String
		{
			return weaponName;
		}
		public function getHeat():int
		{
			return heat;
		}
		public function getHeatCapacity():int
		{
			return heatCapacity;
		}
		public function getCoolSpeed():int
		{
			return coolSpeed;
		}
		public function getHeatSpeed():int
		{
			return heatSpeed;
		}
		public function setHeatSpeed(heatSpeed:int):void
		{
			this.heatSpeed = heatSpeed;
		}
		public function setHeat(heat:int):void
		{
			this.heat = heat;
		}
		public function setHeatCapacity(heatCapacity:int):void
		{
			this.heatCapacity = heatCapacity;
		}
		public function setStrength(strength:int):void
		{
			this.strength = strength;
		}
		public function setShotDelay(shotDelay:int):void
		{
			this.shotDelay = shotDelay;
		}
		public function setCoolSpeed(coolSpeed:int):void
		{
			this.coolSpeed = coolSpeed;
		}
		public function update():Object
		{
			heatControl();
			return this;
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		private function overheat():void
		{
			GlobalSounds.playSound('steamOverload');
			overheated = true;
			setHeat(getHeatCapacity());
		}
		private function heatControl():void
		{
			if(isHeroWpn && weaponName=="MiniGun"){
			}

			if (getHeat()>0)
			{
				if (getHeat()>=getHeatCapacity())
				{
					if (! (this is ExtendedFireWeapon))
					{
						if (interval==0)
						{
							interval = getHeat();
						}
						if (getHeat()>=interval)
						{
							overheat();
						}
						interval -=  getCoolSpeed();
					}
					else
					{
						interval++;
						if (interval>heatInterval)
						{
							overheat();
						}
						else
						{
							if (isShooting())
							{
								//setHeat(getHeatCapacity()+getCoolSpeed());
							}
							else
							{
								//setHeat(getHeatCapacity());
							}
						}
					}
				}
				else
				{
					interval = 0;
				}
				if (overheated)
				{
					setHeat(getHeat()-getCoolSpeed()/2);
					//needs to cool down slower when it is overheated;
				}
				else
				{
					setHeat(getHeat()-getCoolSpeed());
				}
			}
			else
			{
				overheated = false;
			}
			if(isHeroWpn && weaponName=="MiniGun")
			{
			}
		}
		public function isOverheated():Boolean
		{
			return overheated;
		}
		public function isShooting():Boolean
		{
			return shooting;
		}
		public function defineAsHeroWeapon():void
		{
			//which requires special variables. 
			wpnVars = globals.gameVars.weaponVars[weaponName];//weaponVars
			isHeroWpn = true;
			wpnUpVars = wpnVars['upgrade' + wpnVars.upgrade];//weaponUpgradeVars
			shotDelay = wpnUpVars.fireDelay;
			pointWorth = wpnUpVars.pointWorth;
			currentUpgrade = int(wpnVars.upgrade);
			selfReference.setVars(wpnUpVars);
			//call a defineAsHeroWeapon method on the specific weapon type such as clusterLockLauncher;
			setHeat(0);
			setStrength(wpnUpVars.damage);
			setShotDelay(wpnUpVars.fireDelay);
			setHeatCapacity(500);
			setCoolSpeed(wpnUpVars.coolDown);
			setHeatSpeed(wpnUpVars.heatUp);
			setTimer();

			globals.game_progThread.removeProg(this);
			globals.static_progThread.addProg(this);
		}
		public override function destroy():void
		{
			if (hitCheck!=null)
			{
				hitCheck.destroy();
			}
			primaryHitCheck = null;
			arm = null;
			if (! isHeroWpn)
			{
				super.destroy();

				hitCheck = null;

				selfReference = null;
				attackList = null;

				weaponName = null;
				if (intervalTimer!=null)
				{
					intervalTimer.removeEventListener(TimerEvent.TIMER, fireTimer, false);
					intervalTimer.reset();
					intervalTimer.stop();
				}
				intervalTimer = null;
				wpnVars = null;
				wpnUpVars = null;

			}
			else
			{
				//trace('DESTROYING HERO WEAPON', this, weaponName);
			}


		}
		public override function semiDestroy():void
		{
			super.semiDestroy();
			primaryHitCheck = null;
			//secondaryHitCheck=null;
		}
	}
}