package com.items{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.items.Item;
	import com.weapons.ClusterLauncher;
	import com.globals;
	import com.weapons.WeaponsEnum;
	
	public class ClusterLauncherItem extends WeaponItem {
		public function ClusterLauncherItem():void {
			//super(50,this,new ClusterLauncher(globals.enemyList));
			super(50,this,WeaponsEnum.CLUSTER_LAUNCHER);
		}
	}
}