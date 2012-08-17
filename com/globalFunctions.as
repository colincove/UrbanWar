package com{
	import flash.display.MovieClip;
	import com.levels.level;
	import com.globals;
	import com.displayObjects.debry;
	import com.physics.bounceObj;
	import com.myMath.dist;
	import com.interfaces.People;
	import com.items.OrbPoint;
	import com.worldObjects.person;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import com.camera.ScreenGrabber;

	public class globalFunctions {
		public function globalFunctions():void {
		}
		public static function getMainY(obj:Object):int {
			return getY(obj,globals.main);
		}
		public static function getMainX(obj:Object):int {
			return getX(obj,globals.main);
		}
		public static function getLevelY(obj:Object):int {
			return getY(obj,globals.main.parent);
		}
		public static function getLevelX(obj:Object):int {
			return getX(obj,globals.main.parent);
		}
		public static function getY(obj:Object,parentObjCheck:Object):int {
			if (obj.root==null||parentObjCheck.root==null) {
				return 0;
			}

			var yVar:int=obj.y;
			if (obj.parent==globals.main) {
				yVar-=obj.parent.y;
			}
			var parentObj:DisplayObject=obj.parent;
			while (parentObj!=parentObjCheck)
			{
				yVar+=parentObj.y;
				parentObj=parentObj.parent;
			}
			return yVar;
		}
		public static function getX(obj:Object,parentObjCheck:Object):int {
			if (obj.root==null||parentObjCheck.root==null) {
				return 0;
			}

			var xVar:int=obj.x;
			if (obj.parent==globals.main) {
				xVar-=obj.parent.x;
			}
			var parentObj:DisplayObject=obj.parent;
			while (parentObj!=parentObjCheck) {
				xVar+=parentObj.x;
				parentObj=parentObj.parent;
			}
			return xVar;
		}
		public static function makeY(obj:Object, desire:int):int {
			if (obj.parent==globals.main) {
				desire-=obj.parent.y;
			}
			var parentObj:DisplayObject=obj.parent;
			while (parentObj!=globals.main) {
				desire-=parentObj.y;
				parentObj=parentObj.parent;
			}
			return desire;
		}
		public static function makeX(obj:Object, desire:int):int {
			if (obj.parent==globals.main) {
				desire-=obj.parent.x;
			}//had to add this part for stuff that was in the main. Not sure why. But it works. Bit of a hack. 
			var parentObj:DisplayObject=obj.parent;
			while (parentObj!=globals.main) {
				desire-=parentObj.x;
				parentObj=parentObj.parent;
			}
			return desire;
		}
		public static function makeDebry(debryClassName:String,qty:int, xPos:int, yPos:int, screenGrab:Boolean=true):void {
			var debryClass:Class=getDefinitionByName(debryClassName) as Class;
			var debryObj:debry;
			for (var i:int=0; i<qty; i++) 
			{
				debryObj=new debryClass();
				globals.neutralContainer.addChild(debryObj);
				debryObj.x=globalFunctions.makeX(debryObj,xPos);
				debryObj.y=globalFunctions.makeY(debryObj,yPos);
				if(screenGrab)
				{
				ScreenGrabber.debryAdd(debryObj);
				}
			}
		}
		public static function explosive(weapon):void {
			var distance:int;
			if (globals.people!=null) {
				for (var i:int =0; i<globals.people.length; i++) {
					distance=dist.getObjDist(weapon,globals.people[i]);
					if (distance<50) {
						//People(globals.people[i]).explode();
					}
				}
			}
		}
		public static function removeFromList(list:Array, element:Object):void {
			for (var i:int=0; i<list.length; i++) {
				if (list[i]==element) {
					list.splice(i,1);
				}
			}
		}
		public static function getClosestObj(list:Array, obj:MovieClip):MovieClip {
			var distance:int;
			var closestDist:int;
			var target:MovieClip;
			for (var i:int =0; i<list.length; i++) {
				if (list[i].parent!=null) {
					distance=dist.getObjDist(globals.hero,list[i]);
					if (target==null) {
						target=list[i];
						closestDist=distance;

					} else {
						if (distance<closestDist) {
							closestDist=distance;
							target=list[i];
						}
					}
				}
			}
			return target;
		}
		public static function duplicateList(parentList:Array):Array
		{
			var newList:Array=new Array();
			for (var i:int=0; i<parentList.length; i++)
			{
				newList[i]=parentList[i];
			}
			return newList;
		}
		public static function spawnOrbs(numberOfPoints:int=3, xPoint:int=0,yPoint:int=0):void
		{
			for (var i:int=0; i<numberOfPoints; i++)
			{
				var pointOrb:OrbPoint=new OrbPoint((360/numberOfPoints)*i,xPoint,yPoint);

			}
		}
	}
}