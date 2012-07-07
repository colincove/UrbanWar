package com.events {
	import com.events.MenuEvent;
	import com.weapons.Weapon;
	public class PurchaseWeaponEvent extends MenuEvent 
	{
public static var PURCHASE_WEAPON:String="purchaseWeapon";
public var purchasedWeapon:Weapon;
		public function PurchaseWeaponEvent(weapon:Weapon,type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			// constructor code
			purchasedWeapon=weapon;
		}

	}
	
}
