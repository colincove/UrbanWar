package com.levels{
	import com.interfaces.Program;
	import com.globals;
	import com.globalFunctions;
	import com.levels.level;
	import flash.utils.getDefinitionByName;
	import flash.media.SoundChannel;
	import flash.events.Event;

	public class levelControl implements Program
	{
		protected var progRun:Boolean;
		private var levelObj:level;
		private var levelStopped:Boolean=false;
		protected var levelSongChannel:SoundChannel;
				protected var levelBackgroundChannel:SoundChannel;
		private var ID:int;//For level 1, ID would be 1.  For level 2, the ID would be 2. etc. 
		public function levelControl(ID:int=0):void 
		{
			this.ID=ID;
			globals.game_progThread.addProg(this);
			progRun=true;
			//globals.levelObj.addEventListener(Event.REMOVED_FROM_STAGE, removeSelf);
		}
		public function update():Object
		{
			if(globals.endLevelObject!=null)
			{
				
			var distanceUntilEnd:Number=(globals.enemyContainer.x+globals.endLevelObject.x)-globals.HUD.x;
			
			if(distanceUntilEnd<200 && !levelStopped)
			{
				levelStopped=true;
				globals.HUD.stopHorizontalMovement();
				}
				}
			return this;
		}
		public function isRunning():Boolean
		{
			return progRun;
		}
		public function destroy():void
		{
			globals.game_progThread.removeProg(this);
			if(levelSongChannel!=null)
			{
				levelSongChannel.stop();
			}
			if(levelBackgroundChannel!=null)
			{
				levelBackgroundChannel.stop();
			}
			levelBackgroundChannel=null;
			levelSongChannel=null;
			if(globals.groundControl!=null)
			{
				
			globals.groundControl.destroy();
			}
			levelObj=null;
		}
		public function endLevelObjDestroyed():void
		{
			globals.main.launchEndLevelScreen();
			//globals.main.getGame().beatCurrentLevel();
		}
	}
}