package com.enemies
{
	import com.physics.objMovement;
	import com.globals;
	import com.displayObjects.Points;
	import com.globalFunctions;
	import com.items.ShieldItem;
	import flash.events.Event;
	import com.Sound.GlobalSounds;

	public class Enemy extends objMovement
	{
		protected var size:int;
		protected var enemyVars:Object;
		public function Enemy(enemyName:String = 'Droid'):void
		{
			super();
			size = 1;
			defineVars(enemyName);
			checkIntervalLimit = 10;
			globals.addEnemy(this);
		}
		public override function destroy():void
		{
			super.destroy();
			
			enemyVars=null;
		}
		private function defineVars(enemyName:String):void
		{
			enemyVars=new Object();
			var vars:Object = globals.gameVars.enemyVars[enemyName];
			if (enemyName=='Bomber')
			{
				enemyVars.bombRadius = vars.bombRadius;
				enemyVars.fireDelay=vars.fireDelay;
			}
			if (enemyName=='Spinbot')
			{
				enemyVars.movePow = vars.movePow;
			}
			pointWorth = vars.pointWorth;
			enemyVars.name = vars.name;
			enemyVars.health = int(vars.health);
			this.health=enemyVars.health;
			healthTot=health;
			enemyVars.fireDelay = vars.fireDelay;
			enemyVars.damage = vars.damage;
		}
		protected function removeEnemy(withOrbs:Boolean=true):void
		{
			globals.enemiesKilled++;
			GlobalSounds.playRandom(Vector.<String>(["EnemyDie1","EnemyDie2"]), 0);
			if (withOrbs)
			{
				var points:Points = new Points(pointWorth,x,y,true);
				globalFunctions.spawnOrbs(size*2, globalFunctions.getMainX(this), globalFunctions.getMainY(this));
				var shieldInterval:int = (int)(Math.random() * 3);
				if (shieldInterval==1)
				{
var shield:ShieldItem = new ShieldItem();
			globals.neutralContainer.addChild(shield);
			shield.x=x;
			shield.y=y-40;
				}
			}
			globalFunctions.removeFromList(globals.enemyList,this );
			destroy();
		}
		public function isOnScreen():Boolean
		{
			return onScreen;
		}
	}
}