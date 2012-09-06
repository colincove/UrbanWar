﻿package com.UI {
	import com.displayObjects.Numbers;
	import com.globals;
	import com.interfaces.Program;
	public class Score extends Numbers implements Program
	{
		public static var staticScore:int=0;
		public var score:int;
		private var progRun:Boolean;
		private var addScale:Number=1;
		public function Score():void  
		{
			super(0);
			score=globals.memoryPadding;
			scaleX=1.5;
			scaleY=1.5;
			globals.setScoreUI(this);
			globals.static_progThread.addProg(this);
			progRun=true;
			this.Bar.width=Math.abs(digitList.length*digitSpace)+1;
		}
		public function resetScore():void
		{
			trace("1RESET SCORE", score);
			score=globals.memoryPadding;
			addPoints(0);
			trace("2RESET SCORE", score);
		}
		public function addPoints(points:int, major:Boolean=false):void
		{
			trace("addTo SCORE", score);
			score+=points;
			Score.staticScore=score;
			globals.points=score;
			pointList=makeArray(score-globals.memoryPadding, new Array());
			makeNumbers();
			setNumbers();
			if(major)
			{
				addScale=4;
			}else{
				addScale=2.3;
			}
			
			this.Bar.width=Math.abs(digitList.length*digitSpace)+1;
			//this.Bar.width=500;
			//this.Bar.scaleX=.1;
		}
		public function update():Object
		{
			if(globals.hideUI)
			{
				visible=false;
			}else{
				visible=true;
			}
			scaleX=addScale;
			scaleY=addScale;
			addScale+=(2-addScale)/5;
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}