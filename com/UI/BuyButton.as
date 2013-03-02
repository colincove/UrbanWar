package com.UI{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import com.events.MenuEvent;
	import com.events.MenuTipEvent;
	import com.globals;

	public class BuyButton extends SimpleButton
	{
		public var cost:int=0;
		public function BuyButton():void 
		{
			addEventListener(MouseEvent.CLICK,click);
			addEventListener(MouseEvent.ROLL_OUT,out);
			addEventListener(MouseEvent.ROLL_OVER,over);
		}
		private function click(e:MouseEvent):void
		{
			dispatchEvent(new MenuEvent(MenuEvent.PURCHASE,true, false));
		}
		private function over(e:MouseEvent):void
		{
			
			GameMenuPM.selectedMoney=cost;
			dispatchEvent(new MenuEvent(MenuEvent.UPGRADE_BUY_OVER,true,false));
			if(cost<GameMenuPM.money-globals.memoryPadding){
				dispatchEvent(new MenuTipEvent(MenuTipEvent.TIP,"Upgrade Weapon", MenuTipEvent.COLOR_WHITE,true,false));
			}else{
				dispatchEvent(new MenuTipEvent(MenuTipEvent.TIP,"Upgrade Weapon", MenuTipEvent.COLOR_RED,true,false));
			}
			
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.HOVER_UPDATE,true,false));
		}
		private function out(e:MouseEvent):void 
		{
			GameMenuPM.selectedMoney=0;
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.HOVER_UPDATE,true,false));
						dispatchEvent(new MenuEvent(MenuEvent.UPGRADE_BUY_OUT,true,false));
						dispatchEvent(new MenuTipEvent(MenuTipEvent.CANCEL,"",MenuTipEvent.COLOR_RED,true,false));
			dispatchEvent(new MenuEvent(MenuEvent.ROLL_OUT,true,false));
		}
	}
}