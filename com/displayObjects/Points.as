package com.displayObjects{
	import flash.display.MovieClip;
	import com.globals;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.interfaces.Program;

	public class Points extends Numbers implements Program {
		private var Speed:Number;
		private var major:Boolean;

		private var scaleSpeed:Number=0.07;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public static var currentPoint:Points;
		public static var spawnNewPoint:Boolean=true;
		public static var pointTimer:Timer=new Timer(100);
		public function Points(pointInt:int,xPos:int=0,yPos:int=0, major:Boolean=false):void
		{
			super(pointInt);
			initiatePoint(pointInt,xPos,yPos, major);
		}
		public function initiatePoint(pointInt:int,xPos:int=0,yPos:int=0, major:Boolean=false)
		{
			//this.pointInt=pointInt;
			x=xPos;
			y=yPos;
			this.major=major;
			globals.score.addPoints(pointInt, major);
			if (parent==null) {
				globals.overlayLayer.addChild(this);
				globals.game_progThread.addProg(this);
			}
			Speed=10;

			progRun=true;
			if (major) {
				scaleX=5;
				scaleY=5;
				scaleSpeed=0.1;
			} else {
				scaleX=1.5;
				scaleY=1.5;
			}
		}
		public function update():Object {
			y-=Speed;
			scaleX-=scaleSpeed;
			scaleY-=scaleSpeed;
			Speed=Speed/1.2;
			if (Speed<1) {
				globals.game_progThread.removeProg(this);
				parent.removeChild(this);
			}
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public static function displayPoint(pointInt:int,xPos:int=0,yPos:int=0, major:Boolean=false):void {
			if (spawnNewPoint)
			{
				currentPoint =  new Points(pointInt, xPos, yPos, major);
				pointTimer.addEventListener(TimerEvent.TIMER, timerComplete);
				pointTimer.start();
				spawnNewPoint=false;
			} else {
				currentPoint.initiatePoint(pointInt, xPos, yPos, major);
				//pointTimer.reset();
				//pointTimer.start();
			}
		}
		public static function timerComplete(e:TimerEvent):void 
		{
pointTimer.removeEventListener(TimerEvent.TIMER, timerComplete);
				pointTimer.reset();
				spawnNewPoint=true;
		}
	}
}