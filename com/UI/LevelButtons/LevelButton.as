package com.UI.LevelButtons{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import com.globals;
	import com.events.MenuEvent;
	import com.UI.LevelStatus;

	public class LevelButton extends SimpleButton
	{
		protected var level:int=0;
		public function LevelButton():void 
		{
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void
		{
			globals.main.getGame().playSelectLevel(level);
			LevelStatus(parent).selectLevel(level);
		}
	}
}