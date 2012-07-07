﻿package com.UI{
	import flash.events.EventDispatcher;
	import com.events.MenuEvent;
	import com.globals;
	import com.globalFunctions;
	import com.weapons.Weapon;
	import flash.display.MovieClip;
	public class GameMenuPM {
		public static var currentLevel:int;
		public static var weaponList:Array;
		public static var _money:int=0;
		
		
		public static function get money():int
		{
			return _money;
		}
		public static function set money(value:int):void
		{
			
			_money=value;
			dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE_MONEY));
		}
		public static var launching:Boolean=false;
		public static var loadOut:Array;
		public static var selectedMoney:int=0;
		public static var gameWeaponMenu:weaponMenu;
		public static const dispatcher:EventDispatcher = new EventDispatcher();

		public function GameMenuPM():void 
		{
		}
		public static function update():void 
		{
			//selectedMoney=0;
			weaponList = WeaponList.weaponList;
			loadOut=WeaponList.loadOut;
			money=globals.gameVars.orbs;
			currentLevel=globals.levelProgress;
			
			dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE,true, true));
		}
		public static function reset():void
		{
		
		}
		public static function purchase(weaponID:int):void
		{
			var weapon:Weapon=weaponList[weaponID-1];
			var cost:int=weapon.wpnVars['upgrade'+(weapon.wpnVars.upgrade+1)].cost;
			if (cost<=money)
			{
				money-=cost;
				weapon.wpnVars.upgrade++;
				weapon.defineAsHeroWeapon();
				dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE,true, true));
			}
		}
		public static function selectWeapon(selectState:Boolean, weapon:Weapon):Boolean
		{if(!launching){
			
			if(selectState)
			{
				if(loadOut.length>=3)
				{
					globalFunctions.removeFromList(loadOut, weapon);
					OkPrompt.createPrompt(globals.main, "You may only select 3 weapons as your loadout");
					return false;
				}else{
					loadOut.push(weapon);
					return true;
				}
			}else{
				globalFunctions.removeFromList(loadOut, weapon);
				return false;
			}
			
		}
		return false;
		}
		public static function continueCampaign():void
		{
			
			dispatcher.dispatchEvent(new MenuEvent(MenuEvent.CLEAR_WEAPONS,true, true));
			globals.main.getWeaponMenu().parent.removeChild(globals.main.getWeaponMenu());
			globals.main.getGame().currentLevelID=globals.main.getGame().currentLevelID++;
			globals.main.getGame().startLevel();
		}
	}
}