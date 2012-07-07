package com.myMath{
		import flash.display.MovieClip;
		import com.globalFunctions;
	public class dist {
		public function dist():void {
		}
		public static function getDiff(xVar:Number, yVar:Number):Number{
			return yVar-xVar;
		}
		public static function getObjDistX(obj1:MovieClip, obj2:MovieClip):Number{
		
			return getDiff(globalFunctions.getMainX(obj1), globalFunctions.getMainX(obj2));
			
		}
		public static function getObjDistY(obj1:MovieClip, obj2:MovieClip):Number{
		
			return getDiff( globalFunctions.getMainY(obj1), globalFunctions.getMainY(obj2));
			
		}
		public static function getObjDist(obj1:MovieClip, obj2:MovieClip):Number{
		
			return getDist(globalFunctions.getMainX(obj1), globalFunctions.getMainX(obj2), globalFunctions.getMainY(obj1), globalFunctions.getMainY(obj2));
			
		}
		public static function getDist(x1:Number, x2:Number, y1:Number, y2:Number):Number{
			var xDist=getDiff(x1, x2)
			var yDist=getDiff(y1, y2)
			return Math.sqrt(xDist*xDist+yDist*yDist);
		}
	}
}