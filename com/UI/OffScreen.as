package com.UI{
	import flash.display.MovieClip;
	import com.globals;
	import com.globalFunctions;
	import com.interfaces.Program;
	public class OffScreen extends MovieClip implements Program {
		private var CAM:MovieClip;
		private var xDist:int;
		private var yDist:int;
		private var xDiff:int;
		private var yDiff:int;
		private var xOut:int;
		private var yOut:int;
		private var padding:int;
		private var interval:int;
		private var heroScale:Number;
		private var outsideScreenTime:int;
		private var outsidePadDist:int;
		private var dist:int;
		private var margin:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function OffScreen(CAM:MovieClip):void {
			this.CAM=CAM;
			heroScale=.8;
			outsidePadDist=300;
			outsideScreenTime=globals.gameVars.outsideScreenTime;
			padding=50;//how far outside the stage the hero has to be to be considered out. 
			margin=100;//how far in the icon circles the screen;
			this.hero.scaleY=heroScale;
			globals.main.addChild(this);
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public function update():Object {
			if (! globals.letPlayerLive) {
				xDist=CAM.x-globalFunctions.getMainX(globals.hero);
				yDist=CAM.y-globalFunctions.getMainY(globals.hero);
				xOut=0;
				yOut=0;
				if (xDist>globals.gameWidth/2+padding) {
					xOut=-1;
				}
				if (xDist<globals.gameWidth/2*-1-padding) {
					xOut=1;
				}
				if (yDist>globals.gameHeight/2+padding) {
					yOut=-1;
				}
				if (yDist<globals.gameHeight/2*-1-padding) {
					yOut=1;
				}
				if (xOut!=0||yOut!=0) {
					visible=true;
					var angle:Number=Math.atan2(yDist,xDist);
					this.pointer.rotation=angle/(Math.PI/180);
					var h:int=100;
					//i change x and y dist for the use of the next conditonal. it is used differently each time. 
					xDist=Math.cos(angle)*h;
					yDist=Math.sin(angle)*h;
					//(globals.gameHeight/globals.gameWidth) is because the stage is not a perffect square.
					if (Math.abs(xDist)*(globals.gameHeight/globals.gameWidth)>Math.abs(yDist)) {
						xDiff=(globals.gameWidth/2-margin)*xOut;
						yDiff=Math.tan(angle)*xDiff;
					} else {
						yDiff=(globals.gameHeight/2-margin)*yOut;
						xDiff=yDiff/Math.tan(angle);
					}
					interval++;
					x=CAM.x+xDiff;
					y=CAM.y+yDiff;
					this.hero.scaleX=globals.hero.animation.scaleX*heroScale;
					if (this.hero.currentFrame!=globals.hero.animation.currentFrame) {
						this.hero.gotoAndStop(globals.hero.animation.currentFrame);
					}
					if (currentFrame==totalFrames) {
						progRun=false;
						globals.hero.die();
						this.hero.gotoAndStop('die');
					}
					///this code claculates how far away from being back in the scren the hero is. 
					xDist=x-globalFunctions.getMainX(globals.hero);
					yDist=y-globalFunctions.getMainY(globals.hero);
					dist=Math.sqrt(xDist*xDist+yDist*yDist)-margin-padding;
					if (dist<outsidePadDist) {
						var arrowScale:Number=dist/outsidePadDist;
						this.pointer.arrowHead.scaleX=arrowScale;
						this.pointer.arrowHead.scaleY=arrowScale;
					} else {
						this.pointer.arrowHead.scaleX=1;
						this.pointer.arrowHead.scaleY=1;
					}
					//
					gotoAndStop(Math.ceil(interval/outsideScreenTime*100));
				} else {
					interval=0;
					visible=false;
				}
			} else {
				visible=false;
			}
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}