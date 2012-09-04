package com.weapons
{
	import com.interfaces.activeWeaponInterface;
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.weapons.Wave;
	import flash.geom.Point;
	import com.displayObjects.tmpDisplayObj;
	import com.displayObjects.whiteExplosion;
import com.displayObjects.smallExplosion;
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.displayObjects.activeObj;

	public class WaveParticle extends projectile implements activeWeaponInterface
	{
		private var waveParticleStrength:int;
		private var waveLink:WaveParticle;
		private var particleArray:Array;
		public var key:int;
		private var wave:Wave;
		public function WaveParticle(Angle:int, originPoint:Point,primaryHitCheck:MovieClip,attackList:Array, wave:Wave, strength:int=20, particleArray:Array=null, key:int=0,pointWorth:int=0, speed:int=10):void
		{
			super(Angle, 40,originPoint,primaryHitCheck, strength, pointWorth);
			this.attackList = attackList;
			this.wave=wave;
			waveParticleStrength=strength;
			ground = primaryHitCheck;
			this.key = key;
			this.particleArray = particleArray;
			rotation = Angle;
			startTrail(1);
			selfReferance = this;
			this.Speed = speed;
		}
		public override function destroy():void
		{
			super.destroy();
			waveLink = null;
			particleArray = null;
		}
		public function isLinked():Boolean
		{
			if (waveLink==null)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		public function linkParticle(particle:WaveParticle):void
		{
		}
		public function removeLink():void
		{
			waveLink = null;
		}
		public function update():void
		{
			if(wave!=null)
			{
			strength=waveParticleStrength*wave.waveAlpha;
			}
			moveObj();
			checkScreen();
			removeCheck();
		}
		public function impact():void
		{
			
			GlobalSounds.playSound('explosion1');
			var targetObj:activeObj = checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			if (targetObj!=null && targetObj!=globals.hero)
			{
				AccuracyStats.addHit();
			}else{
				AccuracyStats.addMiss();
			}
			var dontDmg:Boolean=false;
			if (isHeroWeapon) 
			{
				if (targetObj!=null)
				{
					if (targetObj==globals.hero) 
					{
						dontDmg=true;
					}
				}
			}
			if(!dontDmg)
			{
var Explosion:tmpDisplayObj;
			if(targetObj==null)
			{
				Explosion=new smallExplosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			}else{
				Explosion=new whiteExplosion(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
				Explosion.scaleX = .75;
			Explosion.scaleY = .75;
			}
			removeSelf();
			}
		}
		public function removeSelf():void
		{
			if (particleArray!=null)
			{

				var index:int = particleArray.indexOf(this);
				if (index!=-1)
				{
					particleArray[index] = null;
				}
			}

			//particleArray[key]=null;
			destroy();
		}
	}
}