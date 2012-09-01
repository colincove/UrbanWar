package com.UI
{
	import com.UI.GameMenuPM;
	import com.events.MenuEvent;
	import com.globals;
	import com.weapons.Weapon;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class MenuStatus extends MovieClip
	{
		private var numberOfPossibleWeapons:int = 0;
		private var playLevelButtonX:int;
		private var tabBarControl:TabBarControl;
		public function MenuStatus():void
		{
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
			GameMenuPM.dispatcher.addEventListener(MenuEvent.SELECT_WEAPONS,selectWeapons);
loadoutButton.addEventListener(MouseEvent.CLICK, onClickLoadout);
playLevelButtonX=playLevelButton.x;
tabBarControl  = new TabBarControl(tabBar.btn1, tabBar.btn2, tabBar);
tabBarControl.addEventListener(TabBarControl.BTN1, armoryClick);
tabBarControl.addEventListener(TabBarControl.BTN2, loadoutClick);
//tabBar.armoryButton.addEventListener(MouseEvent.CLICK, armoryClick);
//tabBar.loadoutButton.addEventListener(MouseEvent.CLICK, loadoutClick);
		}
		private function armoryClick(e:Event=null):void
		{
			GameMenuPM.menuState = GameMenuPM.ARMORY;
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE));
			//tabBar.gotoAndStop("armory");
		}
		private function selectWeapons(e:MenuEvent):void{
			
		}
		
		private function loadoutClick(e:Event=null):void
		{
			GameMenuPM.menuState = GameMenuPM.LOADOUT;
			//tabBar.gotoAndStop("loadout");
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE));
		}
		private function onClickLoadout(e:MouseEvent):void
		{
			GameMenuPM.menuState=GameMenuPM.LOADOUT;
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE));
		}
		private function update(e:MenuEvent=null):void
		{
			numberOfPossibleWeapons = 0;
			if(GameMenuPM.menuState==GameMenuPM.LOADOUT)
			{
				playLevelButton.x=playLevelButtonX;
				loadoutButton.visible=false;
				//playLevelButton.visible=true;
			}else{
				playLevelButton.x=10000;
				//playLevelButton.visible=false;
				loadoutButton.visible=true;
			}
			if (currentLabel=="choose" && GameMenuPM.menuState==GameMenuPM.LOADOUT)
			{
				gotoAndStop("select");
			}
			if (currentLabel=="select" && GameMenuPM.menuState==GameMenuPM.ARMORY)
			{
				gotoAndStop("choose");
			}

shineAnimation.visible=false;
			if (GameMenuPM.menuState == GameMenuPM.LOADOUT)
			{

				for (var i:int=0; i<WeaponList.weaponList.length; i++)
				{
					if (WeaponList.weaponList[i].purchased)
					{
						numberOfPossibleWeapons++;

					}
				}
				if (numberOfPossibleWeapons>3)
				{
					numberOfPossibleWeapons = 3;
				}
				GameMenuPM.numberOfPossibleWeapons=numberOfPossibleWeapons;
				if (GameMenuPM.loadOut.length == numberOfPossibleWeapons && currentLabel == "select")
				{
					shineAnimation.visible=true;
					GameMenuPM.loadoutSelected=true;
					//this.gotoAndStop("select");
				}
				else
				{
					shineAnimation.visible=false;
					GameMenuPM.loadoutSelected=false;
					//this.gotoAndStop("choose");
				}
			}
			/*if(GameMenuPM.weaponList.length==GameMenuPM.loadOut.length)
			{
			this.gotoAndStop("select");
			}else{
			if(GameMenuPM.loadOut.length==numberOfPossibleWeapons && currentLabel=="select")
			{
			this.gotoAndStop("select");
			}else{
			this.gotoAndStop("choose");
			}
			}*/
		}
	}
}