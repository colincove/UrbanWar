package com.UI
{
	import com.events.MenuEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.display.SimpleButton;
	import com.UI.GameMenuPM;
	import com.interfaces.WeaponInterface;
	import com.events.PurchaseWeaponEvent;
	import com.weapons.Weapon;
	import flash.display.MovieClip;
	import flash.events.Event;

	import com.globals;
	public class WeaponPurchaseUI extends MovieClip
	{
		private var id:int;
		private var selected:Boolean;
		private var weapon:Weapon;
		private var icon:MovieClip;
		public var colorTransform:ColorTransform;
		public var cost:int;
		private var removeButton:MovieClip;
		private var addButtonButton:MovieClip;
		private var addButton:MovieClip;
		private var buyButton:MovieClip;

		private var glowAmount:int;
		private var glowTransform:ColorTransform;

		private var colorWhite:uint = 0xFFFFFF;
		private var alphaChannel:uint = 255;
		private var compositeClr:uint = (alphaChannel << 24) + colorWhite;

		public function WeaponPurchaseUI():void
		{
			GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
			GameMenuPM.dispatcher.addEventListener(MenuEvent.CLEAR_WEAPONS,clearWeapon);
			addEventListener(MenuEvent.PURCHASE,purchase);
			addEventListener(MenuEvent.HOVER_UPDATE,hoverUpdate);
			addEventListener(MenuEvent.ROLL_OUT,onRollOut);
			purchaseUI.gotoAndStop(1);
			colorTransform=new ColorTransform();
			colorTransform.color = 0xFF0000;
			glowTransform=new ColorTransform();
			glowTransform.alphaMultiplier = 0.5;
			glowTransform.color = 0xffffff;
			selected = true;
			NewAnimation.visible = false;
			GameMenuPM.dispatcher.addEventListener(MenuEvent.WEAPON_SELECTED, onWeaponSelect);
			addEventListener(MenuEvent.UPGRADE_BUY_OVER, upgradeOver);
			addEventListener(MenuEvent.UPGRADE_BUY_OUT, upgradeOut);
			update();
			upgradeTextDisplay.visible = false;
			purchaseUI.addEventListener(Event.ADDED_TO_STAGE, purchaseUIAdded);
		}
		private function purchaseUIAdded(e:Event):void
		{
			if (purchaseUI.price1 != null)
			{
				purchaseUI.price1.visible = false;
				purchaseUI.price2.visible = false;
				purchaseUI.price3.visible = false;
			}
			purchaseUI.removeEventListener(Event.ADDED_TO_STAGE, purchaseUIAdded);

		}
		private function upgradeOver(e:MenuEvent):void
		{
			purchaseUI.price1.visible = true;
			purchaseUI.price2.visible = true;
			purchaseUI.price3.visible = true;
			upgradeTextDisplay.visible = true;
		}
		private function upgradeOut(e:MenuEvent):void
		{
			purchaseUI.price1.visible = false;
			purchaseUI.price2.visible = false;
			purchaseUI.price3.visible = false;
			upgradeTextDisplay.visible = false;
		}
		private function update(e:MenuEvent=null):void
		{

			id = int(this.name.charAt(1));
			if (id==8)
			{
				gotoAndStop("Null");
				purchaseUI.gotoAndStop("Null");
				weaponName.text = "";
			}
			else
			{
				gotoAndStop("Null");
				purchaseUI.gotoAndStop("Null");
				if (GameMenuPM.weaponList)
				{
					if (GameMenuPM.weaponList.length >= id)
					{
						if (weapon!=GameMenuPM.weaponList[id-1])
						{
							defineWeapon(GameMenuPM.weaponList[id-1]);
							weapon = Weapon(GameMenuPM.weaponList[id - 1]);
							fromSelection();
						}
						if (selected)
						{
							gotoAndStop("Selected");
						}
						else
						{
							gotoAndStop("Unselected");
						}
						if (GameMenuPM.menuState == GameMenuPM.ARMORY)
						{
							upgradeGlow.visible = true;
						}
						else
						{
							upgradeGlow.visible = false;
						}
						if (weapon.purchased)
						{
							if (GameMenuPM.menuState == GameMenuPM.ARMORY)
							{
								purchaseUI.visible = true;
							}
							else
							{
								purchaseUI.visible = false;
							}
							icon.alpha = 1;
							if (weapon.isNew)
							{
								NewAnimation.visible = true;
							}
							else
							{
								NewAnimation.visible = false;
							}
						}
						else
						{
							purchaseUI.visible = false;
							NewAnimation.visible = false;
							icon.alpha = 0.20;
							defineButton(buyButton);
							buyButton.cost.text = weapon.wpnUpVars.cost;
						}
						updatePurchaseUI();
					}
					else
					{

					}
				}
			}
		}
		private function clearWeapon(e:MenuEvent=null):void
		{
			deselect();
			gotoAndStop("Null");
			purchaseUI.gotoAndStop("Null");
			weapon = null;

			if (icon!=null)
			{
				if (icon.parent != null)
				{
					icon.parent.removeChild(icon);
					icon = null;
				}
			}
		}
		private function updatePurchaseUI():void
		{
			//
			if (weapon.currentUpgrade <= 3)
			{
				purchaseUI.gotoAndStop(weapon.currentUpgrade+1);

				purchaseUI.price1.text = "";
				purchaseUI.price2.text = "";
				purchaseUI.price3.text = "";
				if (weapon.currentUpgrade < 3)
				{
					cost=weapon.wpnVars['upgrade'+(weapon.currentUpgrade+1)].cost;
					purchaseUI.buyButton.cost = cost;
					purchaseUI["price"+(weapon.currentUpgrade+1)].text=cost;
					upgradeTextDisplay.text = "Upgrade to Level " + String(weapon.currentUpgrade + 1);
				}
				else
				{
					upgradeTextDisplay.text = "Upgrades MAXED";
				}
			}
		}
		private function defineWeapon(weapon:WeaponInterface):void
		{
			icon = WeaponInterface(weapon).getIcon();
			icon.buttonMode = true;
			this.iconContainer.addChild(icon);
			icon.x =  -  icon.width / 2;
			icon.y =  -  icon.height / 2;
			icon.addEventListener(MouseEvent.CLICK, selectWeapon, false, 0, true);
			this.weaponName.text = Weapon(weapon).weaponName;
			removeButton = new RemoveButton();
			addButtonButton=new AddWeapon();

			buyButton=new BuyWeapon();
			defineButton(addButtonButton);
			//purchaseUI.price1.visible=false;
			//purchaseUI.price2.visible=false;
			//purchaseUI.price3.visible=false;
			icon.addEventListener(MouseEvent.ROLL_OUT, rollOut, false, 0, true);
			icon.addEventListener(MouseEvent.ROLL_OVER, rollOver, false, 0, true);

		}
		private function rollOver(e:MouseEvent):void
		{
			rolled = true;
			if (! weapon.purchased)
			{
				if (weapon.wpnUpVars.cost > globals.main.getGame().gameVars.orbs)
				{
					/*if(!weapon.purchased)
					{
					GameMenuPM.selectedMoney=cost;
					GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.HOVER_UPDATE,true,false));
					}*/
				}
				//if(!weapon.purchased)
				//{
				GameMenuPM.selectedMoney = cost;
				GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.HOVER_UPDATE,true,false));
				//};
				if (GameMenuPM.menuState == GameMenuPM.ARMORY)
				{
					addButton.visible = true;
				}
			}
			else
			{
				if (GameMenuPM.menuState == GameMenuPM.LOADOUT)
				{
					addButton.visible = true;
					addButton.gotoAndStop(2);
				}
			}
		}
		private var rolled:Boolean = false;
		private function rollOut(e:MouseEvent):void
		{
			rolled = false;
			GameMenuPM.selectedMoney = 0;
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.HOVER_UPDATE,true,false));
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.ROLL_OUT,true,false));
			addButton.gotoAndStop(1);
		}
		//addButton.visible=false;

		private function purchase(e:MenuEvent):void
		{
			GameMenuPM.purchase(id);
		}
		private function onRollOut(e:MenuEvent):void
		{
			GameMenuPM.selectedMoney = 0;
			//dispatchEvent(new MenuEvent(MenuEvent.ROLL_OUT,true));
		}
		private function hoverUpdate(e:MenuEvent):void
		{
			checkCost();
			GameMenuPM.selectedMoney = cost;
			//dispatchEvent(new MenuEvent(MenuEvent.HOVER_UPDATE,true));
		}
		private function selectWeapon(e:MouseEvent=null):void
		{
			if (! weapon.purchased)
			{

				if (GameMenuPM.money >= weapon.wpnUpVars.cost && GameMenuPM.menuState == GameMenuPM.ARMORY)
				{
					weapon.purchased = true;
					GameMenuPM.money -=  weapon.wpnUpVars.cost;
					GameMenuPM.dispatcher.dispatchEvent(new PurchaseWeaponEvent(weapon, PurchaseWeaponEvent.PURCHASE_WEAPON));
					GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE,true));
					defineButton(addButtonButton);
				}
				else
				{

				}
			}
			else
			{
				if (GameMenuPM.menuState == GameMenuPM.LOADOUT)
				{
					fromSelection();
				}
			}


		}
		private function fromSelection():void
		{
			selected = ! GameMenuPM.selectWeapon(! selected,weapon);
			if (selected)
			{
				deselect();
			}
			else
			{
				selected = true;
				defineButton(removeButton);
				GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.WEAPON_SELECTED,true));
				icon.transform.colorTransform=new ColorTransform();
				//weaponName.transform.colorTransform=new ColorTransform();

			}
			GameMenuPM.dispatcher.dispatchEvent(new MenuEvent(MenuEvent.UPDATE,true));
		}
		private function deselect():void
		{
			selected = false;
			if (icon!=null)
			{
				icon.transform.colorTransform = colorTransform;
			}
			if (weaponName!=null)
			{
				//weaponName.transform.colorTransform = colorTransform;
			}
			defineButton(addButtonButton);
		}
		private function defineButton(button:MovieClip):void
		{
			if (button!=null)
			{
				if (addButton!==button)
				{
					if (! Boolean(addButton))
					{
						addButton = button;
					}
					else
					{
						addButton.removeEventListener(MouseEvent.CLICK, selectWeapon, false);
						addButton.removeEventListener(MouseEvent.ROLL_OVER, rollOver, false);
						addButton.removeEventListener(MouseEvent.ROLL_OUT, rollOver, false);
						this.iconContainer.removeChild(addButton);
						addButton = button;
					}
					addButton.addEventListener(MouseEvent.CLICK, selectWeapon, false, 0, true);
					addButton.addEventListener(MouseEvent.ROLL_OVER, rollOver, false, 0, true);
					addButton.addEventListener(MouseEvent.ROLL_OUT, rollOut, false, 0, true);
					this.iconContainer.addChild(addButton);
				}

				if (rolled)
				{
					//addButton.visible=true;
				}
				else
				{
					//addButton.visible=false;
				}
			}
			if (weapon!=null && addButton!=null)
			{


				if (weapon.purchased)
				{
					if (GameMenuPM.menuState == GameMenuPM.ARMORY)
					{
						addButton.visible = false;
					}
					else
					{
						addButton.visible = true;
					}
				}
				else
				{
					if (GameMenuPM.menuState == GameMenuPM.ARMORY)
					{
						addButton.visible = false;
					}
					else
					{
						addButton.visible = true;
					}

				}
			}
		}
		private function updateGlow(e:Event):void
		{
			if (glowAmount<=0)
			{
				removeEventListener(Event.ENTER_FRAME, updateGlow);
				//icon.transform.colorTransform=new ColorTransform();
			}
			else
			{
				glowAmount = glowAmount / 1.5;
				compositeClr = (glowAmount << 24) + colorWhite;
			}
			//glowTransform.color=compositeClr;
			//icon.transform.colorTransform=new ColorTransform();
			//icon.transform.colorTransform=glowTransform;
		}
		private function onWeaponSelect(e:MenuEvent):void
		{
			if (selected)
			{
				if (icon!=null)
				{
					glowAmount = 255;

					//icon.transform.colorTransform=glowTransform;
					addEventListener(Event.ENTER_FRAME, updateGlow);
				}
			}
		}
		private function checkCost():void
		{
			if (! weapon.purchased)
			{
				/*if (weapon.wpnVars.upgrade0.cost>globals.main.getGame().gameVars.orbs) {
				//gotoAndStop('overCost');
				parentMenu.overCost();
				parentMenu.nodeHover(listDesignation,false, netCost);
				} else {
				parentMenu.nodeHover(listDesignation,true, netCost);
				
				//gotoAndStop('over');
				}*/
			}
		}
	}

}