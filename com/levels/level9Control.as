package com.levels{
	import flash.utils.getDefinitionByName;
	import com.Sound.GlobalSounds;
	import com.globals;
		import com.globalFunctions;
		import flash.display.MovieClip;
	public class level9Control extends levelControl
	{
		private var endPlayed:Boolean=false;
		public function level9Control(ID:int=0):void 
		{
			super(9);
			globals.darkLevel=true;
			levelSongChannel=GlobalSounds.playSound('song6');
			var xComp:Number=globalFunctions.getMainX(globals.levelObj.gameEndGradient);
			var yComp:Number=globalFunctions.getMainY(globals.levelObj.gameEndGradient);
			var gradient:MovieClip = globals.levelObj.gameEndGradient;
			globals.levelObj.gameEndGradient.parent.removeChild(globals.levelObj.gameEndGradient);
			globals.main.addChild(gradient);
			gradient.x=xComp;
			gradient.y=yComp;
		}
		private function buildLevel():void
		{
		}
		public function build()
		{
		}
		public override function update():Object
		{
			if(globals.hero.x>13595.2)
			{
				globals.HUD.screenSpeedMod+=0.005;
				if(globals.hero.x>17844.4)
				{
					if(!endPlayed)
					{
						
					globals.main.playEndGameScene();
					endPlayed=true;
					}
					
					globals.HUD.alpha-=0.00005;
					if(globals.hero.x>20392.8)
					{
										//

						//globals.endOfGame=true;
					//globals.main.getGame().beatCurrentLevel();
				}
				}
				
			}
			return super.update();
		}
	}
}