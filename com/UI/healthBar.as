package com.UI{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import com.globals;
	import com.globalFunctions;
	import com.interfaces.dieable;
	import com.interfaces.Program;
	import com.GameComponent;
	public class healthBar extends GameComponent implements Program {
		public var parentObj:MovieClip;
		private var displayTimer:Timer;
		private var totWidth:int;
		private var modifyHealthX:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		private var modifyHealthY:int;
		public function healthBar(parentObj:MovieClip):void 
		{
			initialize(parentObj);
			
		}
		public function initialize(parentObj:MovieClip):void{
			displayTimer=new Timer(1000);
			this.parentObj=parentObj;
			modPos(0,0);
			
			//this.back.width=(parentObj.getHealth()/parentObj.getHealthTot())*150+25;
			totWidth=(parentObj.getHealthTot()/5)+25;
			this.back.width=totWidth;
			x=- width/2;
			y=- height/2;
			displayTimer.addEventListener(TimerEvent.TIMER,displayEnd, false, 0, true);
			visible=false;
			globals.game_progThread.addProg(this);
		}
		public override  function destroy():void
		{
			super.destroy();
			if(displayTimer!=null)
			{
			displayTimer.removeEventListener(TimerEvent.TIMER,displayEnd, false);
			}
			displayTimer=null;
			parentObj=null;
			progRun=false;
			globals.game_progThread.removeProg(this);
		}
		public function modPos(modifyHealthX:int, modifyHealthY:int):void {
			this.modifyHealthX=modifyHealthX;
			this.modifyHealthY=modifyHealthY;
		}
		public function update():Object {
			active();
			return this;
		}
		public function isRunning():Boolean{
			return progRun;
		}
		public function active():void {
			if (parentObj.root!=null) {
				x=globalFunctions.getMainX(parentObj)-globals.neutralContainer.x+modifyHealthX;
				y=globalFunctions.getMainY(parentObj)-globals.neutralContainer.y+modifyHealthY;
			}
		}
		public function activateBar():void
		{
			progRun=true;
			if (parent==null) {
				globals.overlayLayer.addChild(this);
			}

			displayTimer.reset();
			displayTimer.start();
			if (parentObj.getHealth()>0) {
				bar.width=(parentObj.getHealth()/parentObj.getHealthTot())*totWidth;
			} else {
				if (parentObj is dieable) {
					parentObj.die();
				}
				bar.width=0;
			}
			visible=true;
		}
		private function displayEnd(e:TimerEvent):void {
			displayTimer.stop();
					

			progRun=false;
			visible=false;
		}
	}
}