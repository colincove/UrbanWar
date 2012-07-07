package com.levels
{
	import com.displayObjects.activeObj;
	import com.globals;
	import com.globalFunctions;
	import com.interfaces.Program;
	import com.enemies.Enemy;

	public class LevelEnd extends activeObj implements Program
	{
		protected var progRun:Boolean;
		public var yPos:int;
		private var ySpeed:Number;
		public var numberOfGears:int = 0;
		private var destroyInterval:int=0;
		private var dead:Boolean=false;
		public function LevelEnd():void
		{
			globals.endLevelObject = this;
			globals.game_progThread.addProg(this);
			progRun = true;
			yPos = y;
			ySpeed = -1;
		}

		public function update():Object
		{
			if(health>0)
			{
			y +=  ySpeed;
			if (y>yPos)
			{
				ySpeed -=  .05;
			}
			else
			{
				ySpeed +=  .05;
			}
			numberOfGears = int(Math.random() * 14)+1;
			//numberOfGears += int(Math.random()*5-Math.random()*5);
			//if(numberOfGears<0)
			//{
			//numberOfGears=0;
			//}
			//if(numberOfGears>20)
			//{
			///numberOfGears=20;
			//}
			artwork.gears.text = numberOfGears.toString();
			}else{
				scaleX+=(3-scaleX)/5;
				scaleY+=(3-scaleY)/5;
				if(destroyInterval++>50)
				{
					globals.main.getGame().currentLevelControl.endLevelObjDestroyed();
					destroy();
					
				}
			}
			return this;
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		public override function hit(xPos:int, yPos:int, strength:int=20):void
		{
			super.hit(xPos, yPos, strength);
			if (health<=0)
			{
				if(!dead)
				{
				for (var i:int=0; i<globals.enemyList.length; i++)
				{
					var enemy:Enemy = Enemy(globals.enemyList[i]);
					if (enemy.health > 0)
					{
						globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(enemy),globalFunctions.getMainY(enemy),false);
						enemy.destroy();
					}
				}
				globals.HUD.stopCAM();
				globalFunctions.makeDebry("enemyDebry",6,globalFunctions.getMainX(this),globalFunctions.getMainY(this));
				globalFunctions.spawnOrbs(numberOfGears, globalFunctions.getMainX(this), globalFunctions.getMainY(this));
				//destroy();
				health=0;
				artwork.gotoAndStop(2);
				
				dead=true;
				}

			}
		}
		public override function destroy():void
		{
			super.destroy();
			globals.game_progThread.removeProg(this);
				progRun = false;
		}
	}
}