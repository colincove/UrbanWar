package com.UI
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import com.interfaces.Program;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import com.globals;
	import com.globalFunctions;
	import com.weapons.Weapon;
	import com.interfaces.WeaponInterface;
	public class WeaponUI extends MovieClip implements Program
	{
		private var weaponSelect:MovieClip;
		private var fireIcon0:OverheatSymbol = new OverheatSymbol();
		private var fireIcon1:OverheatSymbol = new OverheatSymbol();
		private var fireIcon2:OverheatSymbol = new OverheatSymbol();
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		private var frameNum:Number;
		public function WeaponUI(weaponSelect:MovieClip):void
		{
			///x=-380;
			y = -240;
			frameNum = 1;
			this.weaponSelect = weaponSelect;
			globals.static_progThread.addProg(this);
			progRun = true;
			globals.hero.addEventListener(Event.ADDED_TO_STAGE,heroAddedToStage);
		}
		private function heroAddedToStage(e:Event):void
		{
		resetIcons();
progRun = true;
		}
		public function update():Object
		{
			
			checkDisplay();
			checkIcons();
			if (weaponSelect.selectedWeapon != null)
			{
				frameNum -=  (frameNum - weaponSelect.weaponNum * 20) / 10;
				gotoAndStop(Math.ceil(frameNum));
			}
			for (var i:int=0; i<WeaponList.loadOut.length; i++)
			{
				if (Weapon(WeaponList.loadOut[i]).isOverheated())
				{
					if (this["fireIcon" + i].parent == null)
					{
						this["Icon" + (i + 1)].addChild(this["fireIcon"+i]);
						if (this["Icon" + (i + 1)].numChildren!=0)
				{
					this["Icon" + (i + 1)].getChildAt(0).gotoAndStop(2);
				}
						
					}
				}
				else
				{
					if (this["fireIcon" + i].parent != null)
					{
						if (this["Icon" + (i + 1)].numChildren!=0)
				{
					this["Icon" + (i + 1)].getChildAt(0).gotoAndPlay(3);
				}
						this["Icon" + (i + 1)].removeChild(this["fireIcon"+i]);
					}
				}
			}
			return this;
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		private function checkIcons():void
		{
			for (var i:int=0; i<WeaponList.loadOut.length; i++)
			{
				var iconContainer:MovieClip=(MovieClip(this["Icon" + (i + 1)]));
				if (iconContainer.numChildren==0)
				{
					iconContainer.addChild((WeaponInterface(WeaponList.loadOut[i])).getIcon());
				}
				
			}
		}
		private function checkDisplay():void
		{
			if (! parent)
			{

				if (globals.HUD != null)
				{
					globals.HUD.addChild(this);
				}
			}
		}
		private function resetIcons()
		{
			for (var i:int=1; i<4; i++)
			{
				var iconContainer:MovieClip=(MovieClip(this["Icon" + (i)]));
				if(iconContainer.numChildren>0){
					iconContainer.removeChild(iconContainer.getChildAt(0));
				}
			}
		}
	}
}