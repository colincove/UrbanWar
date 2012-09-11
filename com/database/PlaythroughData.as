package com.database
{
	import flash.display.BitmapData;

	public class PlaythroughData
	{

		private var _score:int;
		private var _levelId:int;
				private var _loadOut:String;
		private var _replay:Boolean;
		private var _imgData:BitmapData;
		private var _enemiesKilled:int;
		private var _accuracy:int;
		private var _gearsCollected:int;
		private var _photoId:String;
		public function PlaythroughData(_score:int,_levelId:int, _loadOut:String,_replay:Boolean, _enemiesKilled:int, _accuracy:int,_gearsCollected:int, _imgData:BitmapData=null, _photoId:String="")
		{
			// constructor code
			this._score=_score;
			this._levelId=_levelId;
			this._loadOut = _loadOut;
			if(_imgData==null)
			{
				_imgData = new BitmapData(1,1);
			}
			this._photoId=_photoId
			this._imgData=_imgData;
			this._enemiesKilled =  _enemiesKilled;
			this._accuracy = _accuracy;
			this._gearsCollected =  _gearsCollected;
			this._replay=_replay;
		}
		public function get score():int
		{
			return _score;
		}
		public function get loadOut():String
		{
			return _loadOut;
		}
		public function get levelId():int
		{
			return _levelId;
		}
		public function get replay():Boolean
		{
			return _replay;
		}
		public function get photoId():String
		{
			return _photoId;
		}
		public function get enemiesKilled():int
		{
			return _enemiesKilled;
		}
		public function get accuracy():int
		{
			return _accuracy;
		}
		public function get gearsCollected():int
		{
			return _gearsCollected;
		}
		public function get imgData():BitmapData
		{
			return _imgData;
		}
	}

}