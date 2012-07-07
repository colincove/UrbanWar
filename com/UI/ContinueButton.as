package com.UI{
	import com.events.MenuEvent;
	import flash.display.SimpleButton;
	import com.UI.GameMenuPM;
	import com.globals;
	import flash.events.MouseEvent;
	public class ContinueButton extends SimpleButton
	{
		public function ContinueButton():void
		{
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
			this.addEventListener(MouseEvent.CLICK,onContinue);
		}
		private function update(e:MenuEvent=null):void 
		{
		}
		private function onContinue(e:MouseEvent):void
		{
			globals.main.getGame().continueCampaign();
			this.dispatchEvent(new MenuEvent(MenuEvent.SELECT_WEAPONS,true));
			///GameMenuPM.continueCampaign();
		}
	}
}