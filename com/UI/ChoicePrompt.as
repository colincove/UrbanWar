package com.UI{
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;

	public class ChoicePrompt extends Prompt
	{
		private var yes:Function;
		private var no:Function;
		public function ChoicePrompt(parent:DisplayObjectContainer, yes:Function, no:Function, msg:String=""):void 
		{
			super(parent, msg);
			this.yes=yes;
			this.no=no;
			this.yesButton.addEventListener(MouseEvent.CLICK, yesClick);
						this.noButton.addEventListener(MouseEvent.CLICK, noClick);
						msgText.text=msg;
		}
		public static function createPrompt(parent:DisplayObjectContainer, yes:Function, no:Function, msg:String=""):ChoicePrompt {
			var prompt:ChoicePrompt=new ChoicePrompt(parent, yes, no,msg);
			return prompt;
		}
		private function yesClick(e:MouseEvent):void{
			yes();
			destroy();
		}
		private function noClick(e:MouseEvent):void{
			no();
			destroy();
		}
	}
}