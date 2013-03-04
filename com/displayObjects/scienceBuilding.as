package com.displayObjects
{
	import com.displayObjects.activeObj;
	import com.interfaces.dieable;
	import com.globalFunctions;
	import com.items.*;
	import com.weapons.*;
	import com.globals;

	public class scienceBuilding extends house implements dieable
	{
		public function scienceBuilding():void
		{
			super();
		}
		public override function die():void
		{
			var weaponDropChance:int = int(Math.random() * 10);
			//weaponDropChance=2;
			if (weaponDropChance==2)
			{
			var possibleList:Array = new Array();
			if (! hasAlready(WeaponsEnum.MISSILE_LAUNCHER))
			{
				possibleList.push(new MissileLauncherItem());
			}
			if (! hasAlready(WeaponsEnum.CLUSTER_LAUNCHER))
			{
				possibleList.push(new ClusterLauncherItem());
			}
			if (! hasAlready(WeaponsEnum.VINE))
			{
				possibleList.push(new TheVineItem());
			}
			if (! hasAlready(WeaponsEnum.LASER))
			{
				possibleList.push(new LaserCannonItem());
			}
			if (! hasAlready(WeaponsEnum.WAVE_CANNON))
			{
				possibleList.push(new WaveCannonItem());
			}
			if (! hasAlready(WeaponsEnum.GAUSSE_CANNON))
			{
				possibleList.push(new GausseCannonItem());
			}
			if(possibleList.length==0)
			{
							globalFunctions.spawnOrbs(20, globalFunctions.getMainX(this), globalFunctions.getMainY(this)+100);

			}else{
			var spawnedWeaponChance:int = int(Math.random() * possibleList.length);
			var spawnedItem:WeaponItem = possibleList[spawnedWeaponChance];
			if (spawnedItem!=null)
			{
				spawnedItem.x = x;
				spawnedItem.y = y+100;
				spawnedItem.yPos = y+100;
				globals.neutralContainer.addChild(spawnedItem);
			}
			for(var i:int=0;i<possibleList.length;i++)
			{
					if(possibleList[i]!=spawnedItem)
					{
						possibleList[i].destroy();
						
					}
					possibleList[i]=null;
				}
			}
			possibleList=null;
			}else{
			globalFunctions.spawnOrbs(20, globalFunctions.getMainX(this), globalFunctions.getMainY(this)+100);
			}
			super.die();
		}
		private function hasAlready(weaponType:String):Boolean
		{
			/*for (var i:int=0; i<globals.hero.armCannon.loadOut.length; i++)
			{
			if (getQualifiedClassName(globals.hero.armCannon.loadOut[i]) as Class == weapon)
			{
			return true;
			}
			}*/
			for (var i:int=0; i<WeaponList.weaponList.length; i++)
			{
				if (WeaponList.weaponList[i].weaponType == weaponType)
				{
					if (WeaponList.weaponList[i].purchased)
					{
						return true;
					}
				}
			}
			return false;
		}

	}

}
/*case MINI_GUN:
return MiniGun;
case MISSILE_LAUNCHER:
return MissileLauncher;
case CLUSTER_LAUNCHER:
return ClusterLauncher;
case VINE:
return TheVine;
case LASER:
return LaserCannon;
case WAVE_CANNON:
return WaveCannon;
case GAUSSE_CANNON:
return GausseCannon;*/