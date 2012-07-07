package com.UI
{
	import com.UI.PromptBase;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;
import com.globals;
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
			remove();
		}
		private function onResume(e:MouseEvent):void
		{
			remove();
		}
		private function onEndLevel(e:MouseEvent):void
		{
			remove();
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