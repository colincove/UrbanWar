package com.database{
	import flash.display.MovieClip;
	import com.weapons.WeaponsEnum;
	import com.globals;
	import com.UI.EndLevelScreen;
	import flash.events.MouseEvent;
	public class Result extends MovieClip {
		private var _name:String;
		private var _loadOut:String;
		private var _score:String;
		private var _date:String;
		private var _place:int;
		private var _photoId:String;
		private var _enemiesKilled:int;
		private var _accuracy:int;
		private var _gearsCollected:int;
public var playthroughData:PlaythroughData;
		public function Result():void
		{
gotoAndStop(1);
rollOverColor.visible=false;
addEventListener(MouseEvent.CLICK, onClick);
addEventListener(MouseEvent.ROLL_OVER, rollOver);
addEventListener(MouseEvent.ROLL_OUT, rollOut);
		}
		private function rollOver(e:MouseEvent):void
		{
			if(playthroughData!=null){
				rollOverColor.visible=true;
			}
		}
		private function rollOut(e:MouseEvent):void
		{
			if(playthroughData!=null){
				rollOverColor.visible=false;
			}
		}
		private function onClick(e:MouseEvent):void
		{
			trace("CLICK",playthroughData);
			if(playthroughData!=null)
			{
							var display:EndLevelScreen = new EndLevelScreen(false,playthroughData);
							trace(display.parent);
							
							//display.x=0;
							//display.y=0;
if(display.parent==null)
{
	globals.main.addChild(display);
}
display.launch();
			}
		}
		public function setData(result:Object):void 
		{
			if (result.name==null)
			{
				result.name="";
			}
			if (result.user==User.uid) 
			{
				gotoAndStop(2);
			} else {
				gotoAndStop(1);
			}
			name=result.name;
			loadOut=result.loadOut;
			score=result.score;
			date=result.date;
			place=result.place;
			enemiesKilled = result.enemiesKilled;
			accuracy= result.accuracy;
			gearsCollected = result.gearsCollected;
			photoId = result.photoId;
			playthroughData = new PlaythroughData(int(_score), 1,_loadOut,false,enemiesKilled,accuracy,gearsCollected,null, photoId);
		}
		public override function set name(value:String):void {
			super.name=value;
			nameDisplay.text=value;
			_name=value;
		}
		public function set place(value:int):void
		{
			_place=value;
			placeDisplay.text=(value+1).toString();
		}
		public function set loadOut(value:String):void
		{
			_loadOut=value;
			loadOutDisplay.text=value;
			var enums:Vector.<String>=WeaponsEnum.getEnum(value);
			wpn1.gotoAndStop(1);
			wpn2.gotoAndStop(1);
			wpn3.gotoAndStop(1);
			var frame:int=0;
			for (var i:int=0; i<enums.length; i++) {
				frame=0;
				frame=Result.findFrame((int(enums[i])).toString());
				switch (i) {
					case 0 :
						wpn1.gotoAndStop(frame);
						continue;
					case 1 :
						wpn2.gotoAndStop(frame);
						continue;
					case 2 :
						wpn3.gotoAndStop(frame);
						continue;
				}
			}
		}
		public function set score(value:String):void {
			if (value!=null) {
				_score=value;
				scoreDisplay.text=value;
			}
		}
		public function set date(value:String):void {
			_date=value;
		}
		public function resetDisplay():void {
			playthroughData=null;
			nameDisplay.text="";
			rollOverColor.visible=false;
			placeDisplay.text="";
			scoreDisplay.text="";
			wpn1.gotoAndStop(1);
			wpn2.gotoAndStop(1);
			wpn3.gotoAndStop(1);
			gotoAndStop(1);
		}
		public static function findFrame(enum:String):int {
			switch (enum) {
				case WeaponsEnum.MINI_GUN :
					return 2;
				case WeaponsEnum.MISSILE_LAUNCHER :
					return 3;
				case WeaponsEnum.CLUSTER_LAUNCHER :
					return 7;
				case WeaponsEnum.VINE :
					return 4;
				case WeaponsEnum.LASER :
					return 5;
				case WeaponsEnum.WAVE_CANNON :
					return 6;
				case WeaponsEnum.GAUSSE_CANNON :
					return 7;
				case "8" :
					return 7;
				case "9" :
					return 7;
				case "10" :
					return 7;
				default :
					return 1;
			}

			return 1;
		}
		public function set enemiesKilled(value:int):void {
			_enemiesKilled=value;
		}
		public function set photoId(value:String):void {
			_photoId=value;
		}
		public function set accuracy(value:int):void {
			_accuracy=value;
		}
		public function set gearsCollected(value:int):void {
			_gearsCollected=value;
		}
		public function get enemiesKilled():int {
			return _enemiesKilled;
		}
		public function get photoId():String {
			return _photoId;
		}
		public function get accuracy():int {
			return _accuracy;
		}
		public function get gearsCollected():int {
			return _gearsCollected;
		}
	}

}