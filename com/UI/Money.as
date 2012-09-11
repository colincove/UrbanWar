package com.UI{
	import com.UI.GameMenuPM;
	import flash.display.MovieClip;
	import com.events.MenuEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.motion.Color;
	import com.globals;

	public class Money extends MovieClip{
		private var localMoney:int=0;
		private var loseMoneyText:TextField;
		private var format:TextFormat = new TextFormat();
		public function Money():void {
			GameMenuPM.dispatcher.addEventListener(MenuEvent.HOVER_UPDATE,update);
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
						GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE_MONEY,updateMoney);
						loseMoneyText = new TextField();
						format.size=30;
						format.color=0xff0000;
						
						update();
		}
		private function update(e:MenuEvent=null):void 
		{
			
			this.gearValue.text=String(GameMenuPM.money-globals.memoryPadding)
			if(GameMenuPM.money-globals.memoryPadding>=GameMenuPM.selectedMoney)
			{
				gotoAndStop("Active");
			}else{
				gotoAndStop("Inactive");
			}
			if(GameMenuPM.menuState==GameMenuPM.ARMORY)
			{
				visible=true;
			}else{
				visible=false;
			}
		}
		private function updateMoney(e:MenuEvent):void
		{
			if(localMoney>GameMenuPM.money){
				loseMoney();
			}
			localMoney=GameMenuPM.money;
		}
		private function loseMoney():void
		{
			loseMoneyText.text="-".concat(String(localMoney-GameMenuPM.money));
			loseMoneyText.y=0;
			floatInterval=0;
			floatMoveSpeed=10;
			this.addChild(loseMoneyText);
			loseMoneyText.setTextFormat(format);
			addEventListener(Event.ENTER_FRAME, updateMoneyFloat);
		}
		private var floatInterval:int=0;
		private var floatMoveSpeed:Number;
		private function updateMoneyFloat(e:Event):void
		{
			if(++floatInterval>40)
			{
				removeEventListener(Event.ENTER_FRAME, updateMoneyFloat);
				this.removeChild(loseMoneyText);
			}else{
				loseMoneyText.y+=floatMoveSpeed;
				floatMoveSpeed=floatMoveSpeed/1.3;
				
				
			}
		}
	}
}