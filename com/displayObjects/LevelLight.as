package com.displayObjects{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObjectContainer;
	import com.globals;
	import com.globalFunctions;
	import com.physics.shakeObj;
	public class LevelLight extends MovieClip {
		protected var X:int;
		protected var Y:int;
		private var xShake:int;
		private var yShake:int;
		private var shakeParent:shakeObj;
		private var activeParent:activeObj;
		public function LevelLight():void {
			addEventListener(Event.ENTER_FRAME,checkForRoot);
		}


		protected function checkForRoot(e:Event):void 
		{
			if (Boolean(root))
			{
				X=globalFunctions.getMainX(this);
				Y=globalFunctions.getMainY(this);
				findShakeParent(parent);
				findActiveParent(parent);
				parent.addEventListener(shakeObj.SHAKE,shake); 
				parent.removeChild(this);
				
				globals.levelObj.addChild(this);
				x=X;
				y=Y;
				removeEventListener(Event.ENTER_FRAME,checkForRoot);
			}
		}
		private function shake(e:Event):void{
			x=X+shakeParent.x-xShake;
			y=Y+shakeParent.y-yShake;
		}
		private function findShakeParent(parentCheck:DisplayObjectContainer):void
		{
			if(parentCheck is shakeObj)
			{
				shakeParent=shakeObj(parentCheck);
				xShake=shakeParent.x;
				yShake=shakeParent.y;
			}else if(parentCheck !==globals.main)
			{
				findShakeParent(parentCheck.parent);
			}
		}
		private function findActiveParent(parentCheck:DisplayObjectContainer):void
		{
			if(parentCheck is activeObj)
			{
				activeParent=activeObj(parentCheck);
				activeParent.addEventListener(activeObj.DIE,activeParentRemoved);
			}else if(parentCheck !==globals.main)
			{
				findActiveParent(parentCheck.parent);
			}
		}
		private function activeParentRemoved(e:Event):void
		{
			if(Boolean(parent)){
			parent.removeChild(this);
			
			}
			activeParent.removeEventListener(activeObj.DIE,activeParentRemoved);
		}
	}
}