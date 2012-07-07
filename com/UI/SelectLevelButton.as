package com.UI{
	import flash.display.SimpleButton;
	import com.events.MenuEvent;
	import flash.events.MouseEvent;
	public class SelectLevelButton extends SimpleButton{
		public function SelectLevelButton():void{
			this.addEventListener(MouseEvent.CLICK,selectLevel);
		}
		private function selectLevel(e:MouseEvent):void
		{
			//this.dispatchEvent(new MenuEvent(MenuEvent.SELECT_LEVEL,true));
			GameMenuPM.continueCampaign();
		}
	}
}