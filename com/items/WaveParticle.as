package com.weapons{
	import flash.display.MovieClip;
	public class WaveParticle extends projectile implements activeWeaponInterface {
		private var waveLink:WaveParticle;
		public function WaveParticle(Angle:int, originPoint:Point,primaryHitCheck:MovieClip,attackList:Array, strength:int=20):void {
			super(Angle, 5,originPoint,primaryHitCheck, strength);
			this.attackList=attackList;
			ground=primaryHitCheck;
			rotation=Angle;
			globals.game_progThread.addProg(this);
			progRun=true;
			particleArray=makeWave(originPoint,degree,density);
		}
		public function isLinked():Boolean {
			if (waveLink==null) {
				return false;
			} else {
				return true;
			}
		}
		public function linkParticle(particle:WaveParticle):void {
		}
		public function removeLink():void {
			waveLink=false;
		}
		public function update():void {
		}
		public function impact():void {
			GlobalSounds.playSound('explosion1');
			checkObjDmg(globalFunctions.getMainX(this),globalFunctions.getMainY(this));
			removeSelf();
		}
		public function removeSelf():void {
			globals.game_progThread.removeProg(this);
			parent.removeChild(this);
		}
	}
}