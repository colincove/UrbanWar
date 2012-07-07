package com.UI{
	import com.globals;
	import com.weapons.Weapon;
	import flash.utils.Timer;
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	public class JetpackRetrievedPrompt extends PromptBase
	{
		private var timer:Timer;
		public function JetpackRetrievedPrompt(parent:DisplayObjectContainer):void
		{
			super(parent);
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, promptComplete);
			timer.start();
			x=globals.HUD.x-width/2;
			y=globals.HUD.y-height/2;
			globals.game_progThread.pauseProgram();
			globals.static_progThread.pauseProgram();
			//this.iconAnimation.addChild(weapon.getIcon());
		}
		public static function createPrompt():PromptBase
		{
			return new JetpackRetrievedPrompt(globals.main);
		}
		private function promptComplete(e:TimerEvent):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, promptComplete);
			this.remove();
			globals.game_progThread.resumeProgram();
			globals.static_progThread.resumeProgram();
		}
	}
}