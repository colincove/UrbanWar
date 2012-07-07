package com.UI{
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	public class InfoModal extends Prompt
	{

		public function InfoModal(parent:DisplayObjectContainer,msg:String):void
		{
		super(parent, msg);
		}
		public static function  createPrompt(parent:DisplayObjectContainer, msg:String):Prompt
		{
			var prompt:Prompt = new InfoModal(parent,msg);
			return prompt;
		}
	}
}