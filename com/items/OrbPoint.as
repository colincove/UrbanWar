package com.items{
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.physics.movement;
	import com.myMath.dist;
	import com.myMath.myAngle;
	import com.interfaces.Program;
	import com.globals;
	import com.Sound.GlobalSounds;
	import com.globalFunctions;
	import com.displayObjects.Points;
	public class OrbPoint extends movement implements Program {
		private var distance:Number;
		private var angle:Number;
		private var interval:Number;
		private var moveOut:Boolean;
		private var removing:Boolean;
		function OrbPoint(a:int,xPoint:int=0,yPoint:int=0) {
			angle=a;
			moveOut=true;
			x=xPoint;
			y=yPoint-50;
			globals.levelObj.addChild(this);
			Speed=30;
			interval=0;
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function update():Object {
			if (removing) {
				dieing();
			} else {
				//globals.smoke.smokeBM.drawObject(this.point.green);
				moveObj();
				rotation+=Speed;
				scaleX=1+2/Speed;
				scaleY=1+2/Speed;
				if (moveOut) {
					xSpeed=Math.cos(angle*Math.PI/180)*Speed;
					ySpeed=Math.sin(angle*Math.PI/180)*Speed;
					Speed=Speed/1.2;
					if (Speed<1.3) {
						moveOut=false;
					}
				} else {
					distance=dist.getObjDist(this,globals.heroArm);
					angle=myAngle.getObjAngle(this,globals.heroArm);
					xSpeed=Math.cos(angle*Math.PI/180)*Speed;
					ySpeed=Math.sin(angle*Math.PI/180)*Speed;
					Speed=Speed*1.2;
					if (distance<75) 
					{
						removing=true;
						globals.gameVars.orbs+=10;
						Points.displayPoint(50,x - globals.neutralContainer.x,y - globals.neutralContainer.y);
						//Points.displayPoint(50,x,y );
						GlobalSounds.playSound('getOrb');
						xSpeed=0;
						ySpeed=0;
						Speed=0;
						gotoAndStop("out");
					}
				}
			}
			return this;
		}
		function dieing():void {
			interval++;
			if (interval>20) {
				globals.game_progThread.removeProg(this);

				parent.removeChild(this);
			}
		}
	}
}