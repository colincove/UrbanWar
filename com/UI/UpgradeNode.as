package com.UI{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.interfaces.Program;
	import com.globals;
	import flash.text.TextField;
	import com.globalFunctions;
	import com.weapons.Weapon;
	import com.UI.weaponMenu;
	import flash.events.MouseEvent;
	public class UpgradeNode extends MovieClip {
		private var weapon:Weapon;
		private var parentMenu:weaponMenu;
		private var designation:int;
		private var cost:int;
		private var netCost:int=0;
		private var costText:TextField;
		private var listDesignation:int;
		public function UpgradeNode(weapon:Weapon, parentMenu:weaponMenu, designation:int, listDesignation:int=0):void {
			this.weapon=weapon;
			this.listDesignation=listDesignation;
			this.designation=designation;
			this.parentMenu=parentMenu;
			
			makeCost();
			addFunction();
		}
		private function over(e:MouseEvent):void {
			if (netCost>globals.main.getGame().gameVars.orbs) {
				gotoAndStop('overCost');
				parentMenu.overCost();
				parentMenu.nodeHover(listDesignation,false, netCost);
			} else {
				parentMenu.nodeHover(listDesignation,true, netCost);
				
				gotoAndStop('over');
			}

		}
		private function buy(e:MouseEvent):void 
		{
			if(netCost<=globals.main.getGame().gameVars.orbs-globals.memoryPadding){
			globals.main.getGame().gameVars.orbs-=netCost;
			weapon.currentUpgrade=designation;
			weapon.wpnVars.upgrade=designation;
			weapon.defineAsHeroWeapon();
			parentMenu.itemBought();
			
			}

		}
		private function up(e:MouseEvent):void {
			parentMenu.revert();
			gotoAndStop('up');
		}
		public function addFunction():void {
			
			if (weapon.currentUpgrade>=designation) {
				gotoAndStop('bought');
				
				removeEventListener(MouseEvent.MOUSE_OVER, over, false);
				removeEventListener(MouseEvent.MOUSE_OUT, up, false);
			} else {
				buttonMode=true;
				addEventListener(MouseEvent.CLICK, buy, false, 0, true);
				addEventListener(MouseEvent.MOUSE_OVER, over, false, 0, true);
				addEventListener(MouseEvent.MOUSE_OUT, up, false, 0, true);
			}
		}
		private function makeCost():void {
			for (var i:int=1+weapon.currentUpgrade; i<=designation; i++) {
				netCost+=int(weapon.wpnVars['upgrade'+(i)].cost);
			}
			costText = new TextField();
			costText.height=20;
			costText.width=40;
			costText.selectable=false;
			cost=weapon.wpnVars['upgrade'+designation].cost;
			costText.text=cost.toString();
			addChild(costText);
		}

	}
}