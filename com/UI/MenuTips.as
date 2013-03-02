package com.UI  {
	import flash.display.MovieClip;
	import com.events.MenuTipEvent;
	import com.globals;
	import flash.events.Event;
	
	public class MenuTips {
private var listenClip:MovieClip;
private var tipBox:MovieClip;
		public function MenuTips(listenClip:MovieClip) {
			// constructor code
			this.listenClip=listenClip;
			listenClip.addEventListener(MenuTipEvent.TIP, displayTip);
			listenClip.addEventListener(MenuTipEvent.CANCEL, cancelTip);
			globals.main.addEventListener(Event.ENTER_FRAME, moveBox);
			tipBox = new TipBox();
			globals.main.addChild(tipBox);
		}
	private function displayTip(e:MenuTipEvent):void{
		tipBox.visible=true;
		tipBox.tipText.text=e.tipText;
		if(e.color==MenuTipEvent.COLOR_WHITE){
			tipBox.gotoAndStop(1);
		}
		if(e.color==MenuTipEvent.COLOR_RED){
			tipBox.gotoAndStop(2);
		}
		
	}
	private function cancelTip(e:MenuTipEvent):void{
		if(tipBox.parent!=null){
			//tipBox.parent.removeChild(tipBox);
		}
		tipBox.visible=false;
	}
	private function moveBox(e:Event):void{
		tipBox.x=globals.main.stage.mouseX;
		tipBox.y=globals.main.stage.mouseY;
		tipBox.alpha=1.0;
	}

	}
	
	
}
