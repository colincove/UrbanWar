package com.UI{
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.globals;
	import com.weapons.Weapon;
	import com.interfaces.Program;
	public class WeaponHeatUI extends MovieClip implements Program {
		private var weapon:Weapon;
		private var frame:int;
		private var ratio:Number;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function WeaponHeatUI():void {
			frame=0;
			overheat.visible=false;
			globals.game_progThread.addProg(this);
			progRun=true;
			
		}
		public function update():Object {
			weapon=globals.hero.armCannon.selectedWeapon;
			if (weapon!=null) {
				if (weapon.isOverheated()) {
					overheat.visible=true;
				} else {
					overheat.visible=false;
				}
				ratio=weapon.getHeat()/weapon.getHeatCapacity();
				frame-=(currentFrame-ratio*totalFrames)/3;
				gotoAndStop(frame);
			} else { 
				gotoAndStop(1);
			}
			return this;
		}
				public function isRunning():Boolean{
			return progRun;
		}
		
	}
}