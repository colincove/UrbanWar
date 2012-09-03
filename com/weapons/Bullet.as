package com.weapons
{
	import com.weapons.activeWeapon;
	import com.weapons.ExtendedFireWeapon;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.interfaces.Program;
	import com.myMath.hitTestLine;
	import com.globals;
	import com.globalFunctions;
	import com.displayObjects.activeObj;

	public class Bullet extends activeWeapon implements Program
	{
		private var weapon:ExtendedFireWeapon;
		protected var originPoint:Point;
		protected var originObj:MovieClip;
		private var interval:int = 0;

		private var stager:int;
		private var shootAngle:int;
		protected var bulletArtwork:MovieClip;
		public function Bullet(Angle:int, originPoint:Point,primaryHitCheck:MovieClip, arm:MovieClip,fireDelay:int=100,weapon:ExtendedFireWeapon=null, strength:int=0, secondaryHitCheck:MovieClip=null, stager:int=7, pointWorth:int=0):void
		{
			super(originPoint,primaryHitCheck,strength,secondaryHitCheck, pointWorth);
			this.weapon = weapon;
			this.stager = stager;
			this.originPoint = originPoint;
			this.originObj = arm;
			this.strength = strength;
			this.fireDelay = fireDelay;
			globals.game_progThread.addProg(this);
			progRun = true;
		}
		public function update():Object
		{
			if (interval>fireDelay)
			{
				fireBullet();
				interval = 0;
			}
			interval++;
			return this;
		}
		public override function destroy():void
		{
			super.destroy();
			weapon = null;
			originPoint = null;
			originObj = null;
			globals.game_progThread.removeProg(this);
			progRun = false;
		}
		public function impact():void
		{
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		protected function fireBullet():void
		{
			try
			{
				weapon.heatUp();
				if (bulletArtwork.parent == null)
				{ 
					globals.levelObj.addChild(bulletArtwork);
				}
				shootAngle=originObj.rotation+(Math.random()-Math.random())*stager;
				originObj.rotation = shootAngle;
				var xChange:int=Math.cos(shootAngle*(Math.PI/180))*50;
				var yChange:int=Math.sin(shootAngle*(Math.PI/180))*50;
				bulletArtwork.hitSpot.gotoAndPlay('fire');
				bulletArtwork.trail.gotoAndPlay('fire');
				bulletArtwork.x = globalFunctions.makeX(bulletArtwork,originPoint.x + xChange);
				bulletArtwork.y = globalFunctions.makeY(bulletArtwork,originPoint.y + yChange);
				x = originPoint.x + xChange;
				y = originPoint.y + yChange;
				var dist:int = hitTestLine.getAngledLine(globalFunctions.getMainX(this),globalFunctions.getMainY(this),shootAngle,primaryHitCheck,800,40,true,secondaryHitCheck);
				bulletArtwork.trail.rotation = shootAngle;
				bulletArtwork.hitSpot.rotation = shootAngle;
				bulletArtwork.StreakMask.MaskArtwork.x =  -  dist;
				bulletArtwork.StreakMask.rotation = shootAngle + 180;
				var xPos:int = Math.cos(shootAngle*(Math.PI/180))*dist;
				var yPos:int = Math.sin(shootAngle*(Math.PI/180))*dist;
				bulletArtwork.hitSpot.x = xPos;
				bulletArtwork.hitSpot.y = yPos;
				if (globals.HUD.hitTestPoint(globalFunctions.getMainX(this) + xPos,globalFunctions.getMainY(this) + yPos,true))
				{

					var targetObj:activeObj = checkObjDmg(globalFunctions.getMainX(this) + xPos,globalFunctions.getMainY(this) + yPos);
					if (weapon!=null)
					{
						if (weapon.isHeroWpn)
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
					}
				}

			}
			catch (e:Error)
			{
//trace("ERROR");
			}
		}
		public function removeSelf():void
		{

			globals.game_progThread.removeProg(this);
			if (bulletArtwork.parent != null)
			{
				bulletArtwork.parent.removeChild(bulletArtwork);
			}
			destroy();
		}
	}
}