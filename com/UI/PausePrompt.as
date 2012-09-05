﻿package com.UI
{
	import com.UI.PromptBase;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;
import com.globals;
import com.database.User;

	public class PausePrompt extends PromptBase
	{
private var callback:Function;
		public function PausePrompt(parent:DisplayObjectContainer, callback:Function=null)
		{
			// constructor code
			super(parent);
			this.callback=callback;
			resumeGame.addEventListener(MouseEvent.CLICK, onResume);
			mainMenu.addEventListener(MouseEvent.CLICK, onMainMenu);
			endLevel.addEventListener(MouseEvent.CLICK, onEndLevel);
		}
		private function onMainMenu(e:MouseEvent):void
		{
			var msg:String;
			if(User.active){
				msg="Are you sure? You will lose the progress you have made on this current stage.";
			}else{
						msg="Are you sure? You will lose all progress. Register and Login to have data saved during gameplay.";
			}
			ChoicePrompt.createPrompt(globals.main, yes, no, msg);
			function yes():void
			{
				
				globals.main.getGame().endCurrentLevel(true);
			globals.main.launchTitleScreen();
				remove();
			}
			function no():void{
				remove();
			}
		}
		private function onResume(e:MouseEvent):void
		{
			remove();
		}
		private function onEndLevel(e:MouseEvent):void
		{
			remove();
			//globals.main.playGame();
			globals.main.getGame().endCurrentLevel();
		}
		public override function remove():void
		{
			if(callback!=null)
			{
				callback();
			}
			resumeGame.removeEventListener(MouseEvent.CLICK, onResume);
			mainMenu.removeEventListener(MouseEvent.CLICK, onMainMenu);
			endLevel.removeEventListener(MouseEvent.CLICK, onEndLevel);
			super.remove();
		}
		public static function  createPrompt(parent:DisplayObjectContainer, callback:Function=null):PausePrompt
		{
			var prompt:PausePrompt = new PausePrompt(parent, callback);
			return prompt;
		}
	}


}