package com.database{
	import flash.display.MovieClip;
	import com.weapons.WeaponsEnum;
	public class Result extends MovieClip {
		private var _name:String;
		private var _loadOut:String;
		private var _score:String;
		private var _date:String;
		private var _place:int;
		public function Result():void {
		
		}
public function setData(result:Object):void{
	if(result.name==null){
		result.name="";
	}
	if(result.user==User.uid)
	{
		gotoAndStop(2);
	}else{
		gotoAndStop(1);
	}
		name=result.name;
			loadOut=result.loadOut;
			score=result.score;
			date=result.date;
			place=result.place;
}
		public override function set name(value:String):void {
			super.name=value;
			nameDisplay.text=value;
			_name=value;
		}
		public function set place(value:int):void {
			_place=value;
			placeDisplay.text=value.toString();
		}
		public function set loadOut(value:String):void {
			_loadOut=value;
			loadOutDisplay.text=value;
			var enums:Vector.<String> = WeaponsEnum.getEnum(value);
			for(var i:int=0;i<3;i++)
			{
				var frame:int=1;
				if(i>=enums.length)
				{
					frame=1;
					
				}else{
					frame=Result.findFrame(enums[i]);
					
				}
				switch(i)
				{
					case 0:
					wpn1.gotoAndStop(frame);
					continue;
					case 1:
					wpn2.gotoAndStop(frame);
					continue;
					case 2:
					wpn3.gotoAndStop(frame);
					continue;
				}
			}
		}
		public function set score(value:String):void {
			_score=value;
			scoreDisplay.text=value;
		}
		public function set date(value:String):void {
			_date=value;
		}
		public static function findFrame(enum:String):int{
			
				switch(enum){
					case WeaponsEnum.MINI_GUN:
					return 2;
					case WeaponsEnum.MISSILE_LAUNCHER:
					return 3;
					case WeaponsEnum.CLUSTER_LAUNCHER:
					return 7;
					case WeaponsEnum.VINE:
					return 4;
					case WeaponsEnum.LASER:
					return 5;
					case WeaponsEnum.WAVE_CANNON:
					return 6;
					default:
					return 1;
				}
			
			return 1;
		}
	}

}