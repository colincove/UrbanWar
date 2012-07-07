package com.weapons{
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.physics.movement;
	import com.weapons.SlowMissile;
	import com.displayObjects.explosion;
	import com.interfaces.Program;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.events.Event;
	public class SlowMissileLauncher extends movement implements Program {
		private var interval:int=0;
		public function SlowMissileLauncher():void {
			globals.game_progThread.addProg(this);
			progRun=true;
			visible=false;

		}
		public function update():Object {
			checkScreen();
			if (onScreen) {
				interval++;
				if (interval>20) {
					interval=0;
					var spawn:int=Math.round(Math.random()*4);
					var _x:int=0;
					var _y:int=0;
					switch (spawn) {
						case 0 :
							_x=0;
							_y=Math.random()*1000;
							break;
						case 1 :
							_x=Math.random()*1000;
							_y=1000;
							break;
						case 2 :
							_x=1000;
							_y=Math.random()*1000;
							break;
						case 2 :
							_x=1000;
							_y=Math.random()*1000;
							break;
					}
					var missile:SlowMissile = new SlowMissile(globals.HUD.x+_x-globals.levelObj.x,globals.HUD.y+_y-globals.levelObj.y);
					globals.enemyContainer.addChild(missile);
				}
			}
			return this;
		}
		public function impact():void {
			removeSelf();
		}
		public function removeSelf():void {
			globals.game_progThread.removeProg(this);
			parent.removeChild(this);
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}