package com.displayObjects
{
	import com.globals;
	import flash.events.Event;
	public class BackLevelLight extends LevelLight 
	{
		public function BackLevelLight():void 
		{
			super();
			super.removeEventListener(Event.ENTER_FRAME,checkForRoot);
			this.addEventListener(Event.ENTER_FRAME,checkForRoot);
		}
		protected override function checkForRoot(e:Event):void 
		{
			if (Boolean(root)) 
			{
			super.checkForRoot(e);
				parent.removeChild(this);
				globals.levelObj.lightContainer.addChild(this);
				removeEventListener(Event.ENTER_FRAME,checkForRoot);
			}
			
		}
	}
}