package com.UI{
	import com.weapons.Weapon;
	import flash.display.MovieClip;
	import com.globalFunctions;
	import com.UI.weaponMenu;
	import flash.events.MouseEvent;
	public class WeaponContainer extends MovieClip {
		private var weapon:Weapon;
		private var wpnIcon:MovieClip;
		private var parentMenu:weaponMenu;
		public function WeaponContainer(weapon:Weapon,parentMenu:weaponMenu, wpnIcon:MovieClip):void {
			this.weapon=weapon;
			this.wpnIcon=wpnIcon;
			if (! weapon.isLoadOut()) {
				wpnIcon.alpha=.5;
			}
			this.parentMenu=parentMenu;
			wpnIcon.addEventListener(MouseEvent.CLICK, clickFunction, false, 0, true);
			//
		}
		private function clickFunction(e:MouseEvent):void {
			

			if (weapon.isLoadOut()) {
				globalFunctions.removeFromList(parentMenu.loadOut, weapon);
				weapon.setLoadOut(false);
				wpnIcon.alpha=.5;
			} else if (parentMenu.loadOut.length!=3) {
				weapon.setLoadOut(true);
				parentMenu.loadOut.push(weapon);
				wpnIcon.alpha=1;
			}
			parentMenu.updateForLoadout();

		}

	}
}