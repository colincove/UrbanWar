package com.UI{
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.transitions.TweenEvent;
	import com.globals;
	public class RegistrationInfoPrompt extends PromptBase
	{
		private var callback:Function;
		public function RegistrationInfoPrompt(parent:DisplayObjectContainer, callback:Function=null):void
		{
			super(parent);
			this.callback=callback;
			okButton.addEventListener(MouseEvent.CLICK,onClick);
		}
		public static function  createPrompt(parent:DisplayObjectContainer, callback:Function=null):PromptBase
		{
			var prompt:PromptBase = new RegistrationInfoPrompt(parent, callback);
			return prompt;
		}
		private function onClick(e:MouseEvent):void
		{
			remove();
			if(Boolean(callback))
			{
				callback();
			}
		}
		public override function remove():void
		{
			okButton.removeEventListener(MouseEvent.CLICK,onClick);
			super.remove();
		}
	}
}