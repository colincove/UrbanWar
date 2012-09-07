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
		public function PlaythroughData(_score:int,_levelId:int, _loadOut:String,_replay:Boolean, _imgData:BitmapData)
		{
			// constructor code
			this._score=_score;
			this._levelId=_levelId;
			this._loadOut = _loadOut;
			this._imgData=_imgData;
			this._replay=_replay;
		}
		public function get score():int
		{
			return _score;
		}
		public function get loadOut():String{
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
		public function get imgData():BitmapData
		{
			return _imgData;
		}
	}

}