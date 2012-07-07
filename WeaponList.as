package 
{
	import com.weapons.*;
	import com.globalFunctions;
	import com.globals;
	import flash.utils.getQualifiedClassName;

	public class WeaponList
	{
		public static const weaponList:Array = new Array();
		public static const loadOut:Array = new Array();
		public static var oldInventory:String="";

		public static var miniGun:MiniGun;
		public static var missileLauncher:MissileLauncher;
		public static var clusterLauncher:ClusterLauncher;
		public static var laserCannon:LaserCannon;
		public static var waveCannon:WaveCannon;
		public static var theVine:TheVine;
		public static var gausseCannon:GausseCannon;
		public function WeaponList()
		{
			// constructor code
		}
		public static function addWeapon(weapon:Weapon)
		{
			weaponList.push(weapon);
			weapon.defineAsHeroWeapon();
		}
		public static function weaponAcquired(weapon:Weapon)
		{
		weapon.purchased=true;
		if(loadOut.length<3)
		{
			loadOut.push(weapon);
			globals.hero.armCannon.addLoadoutWeapon(weapon);
		}
		}
		public static function addToLoadout(weapon:Weapon)
		{
			if (loadOut.length < 3)
			{
				loadOut.push(weapon);
				weapon.setLoadOut(true);
				//if (weaponUI!=null)
				//{
				//weaponUI["Icon" + loadOut.length].addChild(WeaponInterface(weapon).getIcon());
				//}

			}
		}
		public static function weaponNotAlreadyIn(weapon:Weapon):Boolean
		{

			for (var i:int=0; i<weaponList.length; i++)
			{
				if (weaponList[i] == weapon)
				{
					return false;
				}
			}
			return true;
		}
		public static function loadWeapons(weaponString:String):void
		{
			var weaponInventoryList:Vector.<Weapon >  = WeaponsEnum.parseWeaponString(weaponString);
			weaponList.splice(0);
			loadOut.splice(0);
			WeaponsEnum.fillArrayWeaponList(weaponInventoryList,weaponList);
			for(var i:int=0;i<weaponList.length;i++)
			{
				weaponList[i].defineAsHeroWeapon();
				if(weaponList[i].purchased && loadOut.length<3)
				{
					loadOut.push(weaponList[i]);
				}
			}
			//loadOut.push(weaponList[0],weaponList[1],weaponList[2]);
			oldInventory = WeaponsEnum.composeWeaponStringFromArray(weaponList);
			setStaticWeapons();
		}
		public static function loadDefaultWeapons(gameVars:Object):void
		{
			loadWeapons(gameVars.weaponVars.inventoryAndUpgrades);
		}
		public static function emptyLoadout():void
		{
			while (loadOut.length!=0)
			{
				loadOut.pop();
			}
		}
		public static function makeAllWeaponsNotNew():void
		{
		for(var i:int=0;i<weaponList.length;i++)
			{
				if(weaponList[i].purchased)
				{
					weaponList[i].isNew=false;
				}
			}
		}
		public static function setStaticWeapons():void
		{
			for (var i:int=0; i<weaponList.length; i++)
			{
				var weaponType:String = weaponList[i].weaponType;
				if ( weaponType== WeaponsEnum.MINI_GUN)
				{
					miniGun = weaponList[i];
				}
				if ( weaponType== WeaponsEnum.MISSILE_LAUNCHER)
				{
					missileLauncher = weaponList[i];
				}
				if ( weaponType== WeaponsEnum.CLUSTER_LAUNCHER)
				{
					clusterLauncher = weaponList[i];
				}
				if ( weaponType== WeaponsEnum.LASER)
				{
					laserCannon = weaponList[i];
				}
				if ( weaponType== WeaponsEnum.WAVE_CANNON)
				{
					waveCannon = weaponList[i];
				}
				if ( weaponType== WeaponsEnum.VINE)
				{
					theVine = weaponList[i];
				}
				if ( weaponType== WeaponsEnum.GAUSSE_CANNON)
				{
					gausseCannon = weaponList[i];
				}
			}
		}
		public static function getWeaponByType(weaponType:String):Weapon
		{
			
			if ( weaponType== WeaponsEnum.MINI_GUN)
				{
					return miniGun;
				}
				if ( weaponType== WeaponsEnum.MISSILE_LAUNCHER)
				{
					return missileLauncher;
				}
				if ( weaponType== WeaponsEnum.CLUSTER_LAUNCHER)
				{
					return clusterLauncher;
				}
				if ( weaponType== WeaponsEnum.LASER)
				{
					return laserCannon;
				}
				if ( weaponType== WeaponsEnum.WAVE_CANNON)
				{
					return waveCannon ;
				}
				if ( weaponType== WeaponsEnum.VINE)
				{
					return theVine;
				}
				if ( weaponType== WeaponsEnum.GAUSSE_CANNON)
				{
					return gausseCannon;
				}
				return null;
		}
	}
}