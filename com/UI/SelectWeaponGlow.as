package com.UI  {
	import flash.display.MovieClip;
	import com.UI.GameMenuPM;
	import com.events.MenuEvent;
	public class SelectWeaponGlow extends MovieClip 
	{

		public function SelectWeaponGlow() 
		{
			// constructor code
			GameMenuPM.dispatcher.addEventListener(MenuEvent.WEAPON_SELECTED,onWeaponSelected);
		}
		private function onWeaponSelected(e:MenuEvent):void
		{
			gotoAndPlay(2);
		}
	}
	
}
