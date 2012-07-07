package com.UI{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.interfaces.Program;
	import com.globals;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.globalFunctions;
	import com.UI.UpgradeNode;
	public class weaponMenu extends MovieClip {
		public var weaponList:Array;
		public var loadOut:Array;
		public var list:Array;
		private var nodeList:Array;
		private var weaponContainer:MovieClip;
		private var menuMade:Boolean;
		private var orbContainer:MovieClip;
		private var orbSymbol:MovieClip;
		private var orbText:TextField;
		private var leaveMenu:MovieClip;
		private var netCostText:TextField;
		public function weaponMenu():void 
		{
			GameMenuPM.gameWeaponMenu=this;
			//
		}
		private function removeMenu():void {
			parent.removeChild(this);
		}
		public function updateForLoadout():void {
			if (loadOut.length==weaponList.length||loadOut.length==3) {
				leaveMenu.addEventListener(MouseEvent.CLICK, leaveMenuFunction, false, 0, true);
				leaveMenu.alpha=1;

			} else {
				leaveMenu.alpha=.5;
				leaveMenu.removeEventListener(MouseEvent.CLICK, leaveMenuFunction, false);

			}
		}
		private function checkWeapons():void {
			list=globals.hero.getWeaponList();
			loadOut=globals.hero.getLoadOut();
			for (var i:int=weaponList.length; i<list.length; i++) {
				var wpnIcon:MovieClip=list[i].getIcon();
				var container:WeaponContainer=new WeaponContainer(list[i],this,wpnIcon);
				for (var j:int=1; j<4; j++) {
					var upgradeNode:UpgradeNode=new UpgradeNode(list[i],this,j,i);
					nodeList.push(upgradeNode);
					upgradeNode.x=(j-1)*45+150;
					container.addChild(upgradeNode);
				}
				container.y=i*100;
				weaponList.push(container);

				if (! list[i].isLoadOut) {
					wpnIcon.alpha=.5;
				}
				container.addChild(wpnIcon);
				weaponContainer.addChild(container);
			}
		}
		private function makeMenu():void {
			weaponList=new Array();
			nodeList=new Array();
			weaponContainer=new MovieClip();
			checkWeapons();
			/////////////////////////
			////make orb count
			orbContainer = new MovieClip();
			//
			orbSymbol= new OrbSymbol();
			orbSymbol.scaleX=4;
			orbSymbol.scaleY=4;
			//
			var orbTextFormat:TextFormat = new TextFormat();
			orbText=new TextField();
			orbTextFormat.size=30;
			orbText.defaultTextFormat=orbTextFormat;
			orbText.text=globals.main.getGame().gameVars.orbs;
			orbContainer.addChild(orbText);
			orbContainer.addChild(orbSymbol);
			orbContainer.x=600;
			orbContainer.y=500;
			weaponContainer.addChild(orbContainer);
			//
			leaveMenu=new LeaveWeaponMenu();
			weaponContainer.addChild(leaveMenu);
			leaveMenu.addEventListener(MouseEvent.CLICK, leaveMenuFunction, false, 0, true);
			leaveMenu.x=600;
			//
			var netCostTF:TextFormat = new TextFormat();
			netCostText=new TextField();
			netCostTF.size=30;
			netCostText.defaultTextFormat=netCostTF;
			netCostText.text=globals.main.getGame().gameVars.orbs;
			netCostText.x=500;
			//
			/////
			////
			addChild(weaponContainer);
		}
		private function leaveMenuFunction(e:MouseEvent):void {
			parent.removeChild(this);
			//globals.weaponList=
			globals.main.launchLevelMenu();
		}
		public function launch():void {
			if (! menuMade) {
				menuMade=true;
				makeMenu();
			} else {
				checkWeapons();
			}
		}
		public function itemBought():void {
			orbText.text=globals.main.getGame().gameVars.orbs;
			for (var i:int=0; i<nodeList.length; i++) {
				nodeList[i].addFunction();
			}
		}
		public function revert():void {
			removeChild(netCostText);
			orbText.textColor=0x000000;
		}
		public function overCost():void {
			orbText.textColor=0xFF0000;
		}
		public function nodeHover(designation:int, afford:Boolean, netCost:int):void {
			addChild(netCostText);
			netCostText.text=netCost.toString();
			if (afford) {
				netCostText.textColor=0x000000;
			} else {
				netCostText.textColor=0xFF0000;
			}
			netCostText.y=weaponContainer.y+designation*100;
		}
	}
}