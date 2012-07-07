package com.items{
	import flash.display.MovieClip;
	import com.globalFunctions;
	import com.globals;
		import com.interfaces.Program;
	import com.weapons.Weapon;
	import com.UI.WeaponRetrievedPrompt;
	import com.interfaces.WeaponInterface;
		import com.Sound.GlobalSounds;
	public class WeaponItem extends FloatingItem
	{
		private var radius:int;
		private var actionClip:MovieClip;
		private var distance:int;
		private var weapon:Weapon;
		protected var attackList:String;
	private  var weaponType:String;
		public function WeaponItem(radius:int, actionClip:MovieClip, weaponType:String, attackList:String='enemyList'):void 
		{
			super(55,this);
			this.weaponType=weaponType;
			this.attackList=attackList;
			this.weapon=weapon;
		}
		public override function destroy():void
		{
			super.destroy();
			if(weapon)
			{
				//weapon.destroy();
				
			}
			if(attackList!=null)
			{
			attackList.slice(0);
			}
			attackList=null;
			weaponType=null;
			weapon=null;
			actionClip=null;
		}
		public function action():void 
		{
			var weapon:Weapon=WeaponList.getWeaponByType(weaponType);
WeaponList.weaponAcquired(weapon);
			GlobalSounds.playSound('weaponPickUp');
			removeSelf();
			parent.removeChild(this);
			WeaponRetrievedPrompt.createPrompt(WeaponInterface(weapon));
								globals.game_progThread.removeProg(this);

		}
	}
}