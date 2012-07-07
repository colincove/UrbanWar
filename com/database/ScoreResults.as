package com.database{
	import flash.display.MovieClip;
	public class ScoreResults extends MovieClip
	{
		private var resultsVector:Vector.<Result>;
		public function ScoreResults():void {
		}

		public function addResult():void {
		}
		public function createResults(results:Object):void {
			var i:int;
			if (resultsVector) {
				
				for (i=0; i<(results.length>10 ? 10:results.length); i++) {
					trace(results[i].name, results[i].place);
					resultsVector[i].setData(results[i]);
				}
			} else {
				resultsVector=new Vector.<Result>;
				for (i=0; i<10; i++) 
				{
					var newResult:Result=new Result();
					this.addChild(newResult);
					if(i<results.length)
					{
					newResult.setData(results[i]);
					
					}
					newResult.y=i*newResult.height;
										resultsVector.push(newResult);
				}
			}
		}
	}
}