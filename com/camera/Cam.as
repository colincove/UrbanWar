package com.camera{
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.globals;
	import com.interfaces.removable;
	import com.globalFunctions;
	import com.myMath.dist;
	//dsdsd
	import com.interfaces.Program;
	import flash.events.TimerEvent;
	public class Cam extends MovieClip implements Program {
		private var roof:MovieClip;
		public var progRun:Boolean;
		private var shake:Number;
		private var xPos:Number;
		private var yPos:Number;
		private var xShake:Number;
		private var yShake:Number;
		private var randomNum:int;
		private var stopHorizontal:Boolean=false;
		private var whiteFade:HUDWhiteFade;
		public var screenSpeedMod:Number=0.0;
		public function Cam():void {
			//roof=new camRoof ();
			shake=0;
			xShake=0;
			yShake=0;
			randomNum=Math.random()*100;
			globals.hero.addEventListener(Event.ADDED_TO_STAGE,spawnCam,false,0,true);

		}
		public function spawnCam(e:Event):void {
			x=globalFunctions.getMainX(globals.hero);
			y=globalFunctions.getMainY(globals.hero);
			xPos=x;
			yPos=y;
			stopHorizontal=false;
			globals.static_progThread.addProg(this);
			progRun=true;
			ScreenGrabber.timer.addEventListener(TimerEvent.TIMER,ScreenGrabber.endTimer);
		}
		public function removeSelf():void {
			parent.removeChild(this);
			removeEventListener(Event.ADDED_TO_STAGE,spawnCam,false);
		}
		/*public function update():Object {
		xPos+=Number(globals.gameVars['stage'+globals.gameVars.stageStart].screenSpeed);
		yPos-=(yPos-(globalFunctions.getMainY(globals.hero)-globals.levelObj.y)/5)/5;
		xShake=(Math.random()-Math.random())*shake;
		yShake=(Math.random()-Math.random())*shake;
		x=xPos+xShake;
		y=yPos+yShake;
		shake=shake/1.8;
		globals.main.y=- y+globals.gameHeight/2;
		globals.main.x=- x+globals.gameWidth/2;
		return this;
		}*/
		public function initFade():void
		{
			
			whiteFade= new HUDWhiteFade();
					addChild(whiteFade);
					globals.main.y=- y+globals.gameHeight/2;
			globals.main.x=- x+globals.gameWidth/2;
		}
		private var firstRunInterval:int=0;
		public function update():Object {
			if (gameStart.firstLevelPlay) {
				globals.hideUI=true;
				if (firstRunInterval<300) {
					globals.hideUI=true;
				} else {
					globals.hideUI=false;
					if (whiteFade!=null) {
						if (whiteFade.parent!=null) {
							stopHorizontal=false;
							whiteFade.parent.removeChild(whiteFade);
							whiteFade=null;
							x=globalFunctions.getMainX(globals.hero);
							y=globalFunctions.getMainY(globals.hero);
							xPos=x;
							yPos=y;
						}
					}
				}
				if (firstRunInterval==0) {
					
					stopHorizontal=true;
					x=globalFunctions.getMainX(globals.hero);
					y=globalFunctions.getMainY(globals.hero);
				}
				firstRunInterval++;
			} else {

				firstRunInterval=0;
				globals.hideUI=false;
			}
			if (! this.stopHorizontal) {
				xPos+=Number(globals.gameVars['stage'+globals.gameVars.stageStart].screenSpeed)+screenSpeedMod;
			}
			yPos-=(yPos-(globalFunctions.getMainY(globals.hero)-globals.levelObj.y)/5)/5;
			xShake=(Math.random()-Math.random())*shake;
			yShake=(Math.random()-Math.random())*shake;
			if (! this.stopHorizontal) {
				x=xPos+xShake;
			}

			y=yPos+yShake;
			shake=shake/1.8;
			var xDist:Number=globalFunctions.getMainX(globals.hero)-this.x;

			globals.main.y=- y+globals.gameHeight/2;
			globals.main.x=- x+globals.gameWidth/2;
			if (xDist<300) {
			} else {
				if (globals.gameVars['stage'+globals.gameVars.stageStart].screenSpeed!==0) {
					xPos+=xDist-300;
				}
			}
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function stopHorizontalMovement():void {
			stopHorizontal=true;
		}
		public function stopCAM():void {
			//this.fade.play();
			pauseCam();
		}
		public function pauseCam():void {
			progRun=false;
		}
		public function resetCAM():void {
			this.fade.gotoAndStop(1);
			progRun=true;
			stopHorizontal=false;
		}
		public function shakeFunction(strength:Number):void {
			shake+=strength;
		}
	}
}