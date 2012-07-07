package com.weapons{
	import com.globals;
	import com.globalFunctions;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import com.interfaces.activeWeaponInterface;
	import com.weapons.activeWeapon;
	import com.interfaces.Program;
	import com.GameComponent;
	public class pointOfDamage extends GameComponent implements Program {
		private var secondaryHitCheck:DisplayObject;
		private var primaryHitCheck:DisplayObject;
		private var parentObj:MovieClip;
		private var xVar:int;
				public var progRun:Boolean;//Program Run. True if running, false if not. 
		private var yVar:int;
		public function pointOfDamage(parentObj:MovieClip,primaryHitCheck:MovieClip):void {
			this.parentObj=parentObj;
			this.secondaryHitCheck=secondaryHitCheck;
			this.primaryHitCheck=primaryHitCheck;
			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public override function destroy():void{
			super.destroy();
			secondaryHitCheck=null;
			primaryHitCheck=null;
			parentObj=null;
			globals.game_progThread.removeProg(this);
		}
		private function checkForHit():void {
			if (parentObj.parent!=null) {
				xVar=globalFunctions.getMainX(parentObj);
				yVar=globalFunctions.getMainY(parentObj);
				if (primaryHitCheck.hitTestPoint(xVar,yVar,true))
				{
					
						(activeWeaponInterface(parentObj)).impact();
					
				}
			}
		}
		public function update():Object{
			checkForHit();
			return this;
		}
			public function isRunning():Boolean{
			return progRun;
		}
	}
}