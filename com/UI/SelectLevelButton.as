package com.UI{
	import flash.display.SimpleButton;
	import com.events.MenuEvent;
	import flash.events.MouseEvent;
	public class SelectLevelButton extends SimpleButton{
		public function SelectLevelButton():void{
			this.addEventListener(MouseEvent.CLICK,selectLevel);
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE, menuUpdate);
		}
		private function selectLevel(e:MouseEvent):void
		{
			//this.dispatchEvent(new MenuEvent(MenuEvent.SELECT_LEVEL,true));
			if(GameMenuPM.loadoutSelected)
			{
			GameMenuPM.continueCampaign();
			}
		}
		private function menuUpdate(e:MenuEvent=null)
		{
					if(GameMenuPM.loadoutSelected)
					{
					   alpha=1;
					   }else{
						  alpha=0.5; 
					   }
				
			
			
		}
	}
}