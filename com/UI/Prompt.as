package com.UI{
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;

	public class Prompt extends PromptBase
	{
		private var msgText:TextField = new TextField();
		private var fade:Tween;
		public function Prompt(parent:DisplayObjectContainer, msg:String=""):void 
		{
			super(parent);
			//msgText=  new TextField();
			//msgText.width=290;
			//msgText.height=200;
			//msgText.y=170;
			//msgText.x=this.width/2-msgText.width/2;
			//msgText.text=msg;
			//this.addChild(msgText);
		}
		public static function createPrompt(parent:DisplayObjectContainer, msg:String):Prompt {
			var prompt:Prompt=new Prompt(parent,msg);
			return prompt;
		}
	}
}