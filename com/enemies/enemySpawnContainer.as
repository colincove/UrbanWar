package com.enemies{
	import flash.display.MovieClip;
	import com.interfaces.pausable;
	import com.interfaces.Program;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import com.globals;
	import com.globalFunctions;
	public class enemySpawnContainer extends MovieClip implements Program {
		private var objArray:Array;
		private var childCount:int;
		private var box:MovieClip;
		private var checking:Boolean;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function enemySpawnContainer():void {
			box=hitSpot;
			objArray=new Array  ;
			childCount=numChildren;
			var nonObjCount:int=0;//when i run into the hitSpot, i need to not remove it, so always using getChildAt(0) will no longer work. 
			for (var i:int=0; i<childCount; i++) {
				var childObj:MovieClip=MovieClip(getChildAt(0+nonObjCount));
				if (childObj is pausable) {
					pausable(childObj).pauseSelf();
					objArray.push(childObj);
					this.removeChild(MovieClip(childObj));
				} else {
					nonObjCount++;
				}
			}
			hitSpot.visible=false;
		}
		public function update():Object {
			if (! checking) {
				if (globals.neutralContainer!=null) {
					box.x=box.x+box.parent.x;
					box.y=box.y+box.parent.y;
					this.removeChild(box);
					globals.neutralContainer.addChild(box);
					checking=true;
				}
			}else{
				checkHit();
			}
			return this;
		}
				public function isRunning():Boolean{
			return progRun;
		}
		private function checkHit():void {
			if (globals.levelObj.parent==null||globals.levelObj.parent) {
				removeEventListener(Event.ENTER_FRAME,checkHit,false);
			}

			if (hitSpot.hitTestPoint(globalFunctions.getMainX(globals.hero),globalFunctions.getMainY(globals.hero),true)) {
				for (var i:int=0; i<objArray.length; i++) {
					this.addChild(objArray[i]);
					if (objArray[i] is pausable) {
						pausable(objArray[i]).unpauseSelf();
					}

				}
			}
		}
	}
}