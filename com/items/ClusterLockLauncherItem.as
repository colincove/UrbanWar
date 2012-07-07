package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.WeaponItem;
	import com.weapons.ClusterLockLauncher;
	import com.globals;
	import com.weapons.WeaponsEnum;

	public class ClusterLockLauncherItem extends WeaponItem
	{
		public function ClusterLockLauncherItem():void
		{
			super(50,this,WeaponsEnum.CLUSTER_LAUNCHER, 'enemyList');
			
		}
	}
}