package com.UI{
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import com.GameComponent;
import com.globals;
	public class PromptBase extends GameComponent
	{
		private var fade:Tween;
		private var fadeLength:int;
		public function PromptBase(parent:DisplayObjectContainer,fadeLength:int=10, stopFade:Boolean=false):void 
		{
			super();
			globals.gameComponentList.splice(globals.gameComponentList.indexOf(this),1);
			parent.addChild(this);
			x=-parent.x;
			y=-parent.y;
			this.alpha=0;
			this.fadeLength=fadeLength;
			fade=new Tween(this,'alpha',ease,0,1,fadeLength);
			if(stopFade)
			{
				fade.stop();
				alpha=0;
			}
		}
		protected function fadeIn():void
		{
			fade=new Tween(this,'alpha',ease,0,1,fadeLength);
			fade.start();
		}
		private function ease(t:Number, b:Number, c:Number, d:Number):Number {
			var ts:Number=(t/=d)*t;
			var tc:Number=ts*t;
			return b+c*(tc + -3*ts + 3*t);
		}
		public function remove():void
		{
			fade.yoyo();
			fade.addEventListener(TweenEvent.MOTION_FINISH, removeAfterFade);
		}
		private function removeAfterFade(e:TweenEvent):void {
			fade.removeEventListener(TweenEvent.MOTION_FINISH, removeAfterFade);
			parent.removeChild(this);

		}
	}
}