package com.UI{
	import com.UI.GameMenuPM;
	import flash.display.MovieClip;
	import com.events.MenuEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import fl.motion.Color;

	public class LoadoutStatus extends MovieClip
	{
		private var localMoney:int=0;
		private var loseMoneyText:TextField;
		private var format:TextFormat = new TextFormat();
		public function LoadoutStatus():void {
			
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
						
						
						update();
		}
		private function update(e:MenuEvent=null):void 
		{
			if(GameMenuPM.loadOut!=null){
			
			
			if(GameMenuPM.menuState==GameMenuPM.LOADOUT)
			{
				visible=true;
				GameMenuPM.numberOfPossibleWeapons=0;
				for (var i:int=0; i<WeaponList.weaponList.length; i++)
				{
					if (WeaponList.weaponList[i].purchased)
					{
						GameMenuPM.numberOfPossibleWeapons++;

					}
				}
				if (GameMenuPM.numberOfPossibleWeapons>3)
				{
					GameMenuPM.numberOfPossibleWeapons = 3;
				}
				this.loadoutValue.text=GameMenuPM.loadOut.length+"/"+GameMenuPM.numberOfPossibleWeapons;
				if(GameMenuPM.loadOut.length==GameMenuPM.numberOfPossibleWeapons)
				{
					gotoAndStop("green");
				}else{
					gotoAndStop("normal");
				}
				//GameMenuPM.numberOfPossibleWeapons=numberOfPossibleWeapons;
			}else{
				visible=false;
			}
			}
		}
	}
}