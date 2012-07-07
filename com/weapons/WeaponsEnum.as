package com.weapons
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import com.globals;
	public class WeaponsEnum
	{
		public static const MINI_GUN:String = "0";
		public static const MISSILE_LAUNCHER:String = "1";
		public static const CLUSTER_LAUNCHER:String = "2";
		public static const VINE:String = "3";
		public static const LASER:String = "4";
		public static const WAVE_CANNON:String = "5";
		public static const GAUSSE_CANNON:String = "6";

		public static function getWeaponClass(enum:String):Class
		{
			switch (enum)
			{
				case MINI_GUN :
					return MiniGun;
				case MISSILE_LAUNCHER :
					return MissileLauncher;
				case CLUSTER_LAUNCHER :
					return ClusterLauncher;
				case VINE :
					return TheVine;
				case LASER :
					return LaserCannon;
				case WAVE_CANNON :
					return WaveCannon;
				case GAUSSE_CANNON :
					return GausseCannon;
			}
			return Weapon;
		}
		public static function createWeapon(weaponClass:Class):Weapon
		{
			var weapon:Weapon;

			if (weaponClass==MiniGun||weaponClass==LaserCannon||weaponClass==GausseCannon)
			{
				weapon=new (weaponClass)(globals.hero.armCannon,globals.enemyList);

			}
			else
			{
				weapon=new (weaponClass)(globals.enemyList);
			}
			return weapon;
		}
		public static function getWeaponEnum(weapon:Weapon):String
		{
			switch (getDefinitionByName(getQualifiedClassName(weapon)) as Class)
			{
				case MiniGun :
					return MINI_GUN;
				case MissileLauncher :
					return MISSILE_LAUNCHER;
				case ClusterLauncher :
					return CLUSTER_LAUNCHER;
				case TheVine :
					return VINE;
				case LaserCannon :
					return LASER;
				case WaveCannon :
					return WAVE_CANNON;
				case GausseCannon :
					return GAUSSE_CANNON;
			}
			return "";
		}
		public static function getEnum(enumGroup:String):Vector.<String > 
		{
			var result:Vector.<String >  = new Vector.<String >   ;
			for (var i:int=0; i<enumGroup.length; i++)
			{
				//will need more login in the future to account for 1a, 2a, , 4b
				result.push(String(enumGroup.charAt(i)));
			}
			return result;
		}
		public static function composeWeaponString(weapons:Vector.<Weapon>):String
		{
			var exitString:String = "";
			for (var i:int=0; i<weapons.length; i++)
			{
				exitString=exitString.concat(
				 getWeaponEnum(weapons[i])+
				 "-"+
				 weapons[i].currentUpgrade+
				 "-"+
				 ((String)(int(weapons[i].purchased)))
				 );
				if (i!=weapons.length-1)
				{
					exitString = exitString.concat("|");
				}
			}
			return exitString;
		}
			/*0-2-1|1-3-1|3-2-1|4-1-1|5-0-1|6-3-0
		in this compositioin: first value is weapon, second is the upgrade that it is at, the third value is whether is has been purchased or not (1 for yes, 0 for no)*/
		public static function parseWeaponString(sourceString:String):Vector.<Weapon > 
		{
			var exitList:Vector.<Weapon >  = new Vector.<Weapon >;
			var weaponStrings:Vector.<String >  = Vector.<String >(sourceString.split("|"));
			for (var i:int=0; i<weaponStrings.length; i++)
			{
				var weaponInfo:Array = weaponStrings[i].split("-");
				var newWeapon:Weapon =  createWeapon(getWeaponClass(weaponInfo[0]));
				newWeapon.defineAsHeroWeapon();
				//'1' means it has been purchsed already, 0 means it has not. 
				if(weaponInfo[2]=='0')
				{
					newWeapon.purchased=false;
				}
				newWeapon.wpnVars.upgrade=(int)(weaponInfo[1]);

				newWeapon.defineAsHeroWeapon();
				exitList.push(newWeapon);
			}
			return exitList;
		}
		public static function fillVectorWeaponList(source:Vector.<Weapon>,output:Vector.<Weapon>):void
		{
			for(var i:int=0;i<source.length;i++)
			{
			output.push(source[i]);
			}
		}
		public static function fillArrayWeaponList(source:Vector.<Weapon>,output:Array):void
		{
			for(var i:int=0;i<source.length;i++)
			{
			output.push(source[i]);
			}
		}
		public static function composeWeaponStringFromArray(weapons:Array):String
		{
			var weaponVector:Vector.<Weapon >  = new Vector.<Weapon >   ;
			for (var i:int=0; i<weapons.length; i++)
			{
				if (weapons[i] is Weapon)
				{
					weaponVector.push(Weapon(weapons[i]));
				}
			}
			return composeWeaponString(weaponVector);
		}
	}
}