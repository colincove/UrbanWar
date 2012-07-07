package com.myMath{
	import flash.display.MovieClip;
	import com.globals;
	import com.globalFunctions;
	public class myAngle {
		public function myAngle():void {
		}
		public static function getAngle(xVar1:Number, xVar2:Number,yVar1:Number, yVar2:Number):Number {
			return Math.atan2(dist.getDiff(yVar1,yVar2),dist.getDiff(xVar1,xVar2))/(Math.PI/180);
		}
		public static function getDistAngle(xVar:Number,yVar:Number):Number {
			return Math.atan2(yVar,xVar)/(Math.PI/180);
		}
		public static function getObjAngle(obj1:MovieClip, obj2:MovieClip):Number {
			return getAngle(globalFunctions.getMainX(obj1), globalFunctions.getMainX(obj2), globalFunctions.getMainY(obj1), globalFunctions.getMainY(obj2));
		}
		public static function angleDiff(firstAngle:Number, secondAngle:Number) {
			var difference:Number=secondAngle-firstAngle;
			while (difference < 180*-1) {
				difference+=360;
			}
			while (difference > 180) {
				difference-=360;
			}
			return difference;
		}
	}
}