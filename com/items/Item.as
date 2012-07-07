package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.globalFunctions;
	import com.globals;
	import com.interfaces.Program;
	import com.physics.gravity;
	import com.myMath.dist;
	import com.GameComponent;
	public class Item extends GameComponent implements Program {
		private var radius:int;
		private var actionClip:MovieClip;
		private var distance:int;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function Item(radius:int, actionClip:MovieClip):void {
			this.radius=radius;
			this.actionClip=actionClip;
		}
		public override function destroy():void{
			super.destroy();
			actionClip=null;
		}
		protected function itemUpdate():void {
			if(globals.levelObj!=null){
			if (globals.levelObj.parent==null) {
				removeSelf();
			} else {
				var oldY:Number=y;
				y+=50;
				if (parent!=null) 
				{
					distance=dist.getObjDist(this,globals.hero);
				}
				if (distance<radius)
				{
					this.dispatchEvent(new Event('itemPickedUp'));
					if(actionClip!=null)
					{
					actionClip.action();
					}
				}
				y=oldY;
			}}
		}
		public function update():Object 
		{
			itemUpdate();
			return this;
		}
		public function isRunning():Boolean {
			return progRun;
		}
		public function removeSelf():void {
			globals.game_progThread.removeProg(this);
		}
	}
}