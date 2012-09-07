package com.database{
	import flash.display.MovieClip;
	public class ScoreResults extends MovieClip
	{
		private var resultsVector:Vector.<Result>;
		private var loading:LoadingBlackout;
		public function ScoreResults():void 
		{
			loading=new LoadingBlackout();
		}

		public function addResult():void {
		}
		public function createResults(results:Object):void {
			var i:int;
			
			if (resultsVector) {
				for (i=0; i<resultsVector.length; i++)
				{
					resultsVector[i].resetDisplay();
				}
				for (i=0; i<(results.length>10 ? 10:results.length); i++) {
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
		public function startLoading():void
		{
			if(loading.parent==null)
			{
			addChild(loading);
			}
			loading.Black.width=550;
			loading.Black.height=33*10;
		}
		public function finishLoading():void
		{
			loading.gotoAndStop(1);
			if(loading.parent!=null){
				loading.parent.removeChild(loading);
			}
		}
		public function onLoadFail():void{
		loading.gotoAndStop(2);
		}
	}
}