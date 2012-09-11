package com.database {
	import flash.display.BitmapData;
	
	public class PlaythroughMemory {

private var _playthroughList:Vector.<PlaythroughData>;
		public function PlaythroughMemory()
		{
			// constructor code
			_playthroughList = new Vector.<PlaythroughData>(9);
			//initialization for testing. 
			for(var i:int=1;i<=9;i++)
			{
				addPlaythrough(9999999,i,"0-0-1|1-0-1|4-0-1",false, 34, 54, 576,new BitmapData(200,200,true,0xffffff));
			}
		}
		public function addPlaythrough(score:int,levelID:int, loadOut:String,replay:Boolean, enemiesKilled:int, accuracy:int,gearsCollected:int, imgData:BitmapData):void{
			_playthroughList[levelID-1] = new PlaythroughData(score, levelID, loadOut, replay, enemiesKilled, accuracy, gearsCollected, imgData);
		}
		private function uploadPlaythroughs(callback:Function, failCallback:Function, levelID=1):void
		{
			if(levelID<10)
			{
				var playthroughData:PlaythroughData = _playthroughList[levelID-1];
				WebServices.addPlaythrough(conintueUpload,playthroughData.score, playthroughData.levelId, playthroughData.loadOut, playthroughData.replay, playthroughData.enemiesKilled,playthroughData.accuracy, playthroughData.gearsCollected , playthroughData.imgData,failCallback);
				function conintueUpload():void
				{
					 uploadPlaythroughs(callback,failCallback,++levelID);
				}
			}else{
				callback();
			}
		}
		public function upload(callback:Function, failCallback:Function):void
		{
			
			uploadPlaythroughs(callback,failCallback);
		}
	}
}
