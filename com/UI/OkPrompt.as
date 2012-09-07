package com.UI{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import com.globals;
	public class OkPrompt extends Prompt
	{
		private var callback:Function;
		public function OkPrompt(parent:DisplayObjectContainer,msg:String, callback:Function=null, altOkButton:SimpleButton=null):void
		{
			super(parent, msg);
			this.callback=callback;
			okButton.addEventListener(MouseEvent.CLICK,onClick);
			if(msg!=null)
			{
			this.msgText2.text=msg;
			}
		}
		public static function  createPrompt(parent:DisplayObjectContainer, msg:String, callback:Function=null):Prompt
		{
			var prompt:Prompt = new OkPrompt(parent,msg, callback);
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