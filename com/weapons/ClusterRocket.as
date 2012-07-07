package com.weapons
{
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.interfaces.Program;
	import com.globalFunctions;
	import com.weapons.activeWeapon;
	import com.weapons.Homing;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.explosion;
	import com.interfaces.activeWeaponInterface;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.displayObjects.activeObj;

	public class ClusterRocket extends Homing implements activeWeaponInterface,Program
	{
		private var interval:int = 0;
		public function ClusterRocket(Angle:int, originPoint:Point,primaryHitCheck:MovieClip,attackList:Array,strength:int=20,followMultiplier:int=5,homeRadius:int=300,homingVar:int=1, Speed:int=40, pointWorth:int=0, isHeroWeapon:Boolean=false):void
		{
			super(Angle,Speed,originPoint,primaryHitCheck,strength,followMultiplier,homeRadius,homingVar, pointWorth);
			this.attackList = attackList;
			this.Speed = Speed;
			ground = primaryHitCheck;
			rotation = Angle;
			startTrail(4);
			selfReferance = this;
			globals.game_progThread.addProg(this);
			progRun = true;
			this.isHeroWeapon = isHeroWeapon;
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		public function update():Object
		{
			moveObj();
			trail();
			if (interval>2)
			{
				HomeIn();
			}
			else
			{
				interval++;
			}
			return this;
		}
		public function impact():void
		{
			GlobalSounds.playSound('explosion1');
			globalFunctions.explosive(this);
			var targetObj:activeObj = checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if (isHeroWeapon)
			{
				if (targetObj!=null && targetObj!=globals.hero)
				{
					AccuracyStats.addHit();
				}
				else
				{
					AccuracyStats.addMiss();
				}
			}
			var Explosion:tmpDisplayObj = new explosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			removeSelf();
		}
		public function removeSelf():void
		{

			removeHoming();
			globals.game_progThread.removeProg(this);
			removeProjectile();
			destroy();
		}

	}
}