package com.UI {
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
			score=0;
			scaleX=1.5;
			scaleY=1.5;
			globals.setScoreUI(this);
			globals.static_progThread.addProg(this);
			progRun=true;
			this.Bar.width=Math.abs(digitList.length*digitSpace)+1;
		}
		public function addPoints(points:int, major:Boolean=false):void
		{
			score+=points;
			Score.staticScore=score;
			globals.points=score;
			pointList=makeArray(score, new Array());
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