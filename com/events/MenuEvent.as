package com.events {
	import flash.events.Event;
public class MenuEvent extends Event{
	public static const UPDATE:String="update";
	public static const PURCHASE:String="purchase";
	public static const UPDATE_MONEY:String ="updateMoney";
	public static const HOVER_UPDATE:String="hoverUpdate";
	public static const ROLL_OUT:String="menuRollOut";
	public static const SELECT_LEVEL:String="selectLevel";
	public static const UPDATE_LEVEL_STATUS:String="selectLevel";
	public static const SELECT_WEAPONS:String="selectWeapons";
	public static const WEAPON_SELECTED:String="weaponSelected";
	public static const CLEAR_WEAPONS:String="clearWeapons";
	public static const UPGRADE_BUY_OVER:String="upgradeBuyOver";
	public static const UPGRADE_BUY_OUT:String="upgradeBuyOut";
	public static const LAUNCH:String="launch";
	public function MenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false):void {
		super(type, bubbles, cancelable);
	}
}
}