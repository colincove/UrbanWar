package com.Sound{
	import flash.media.SoundLoaderContext;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	public class MySound extends Sound {
		public function MySound(stream:URLRequest=null,context:SoundLoaderContext=null):void {
			super(stream,context);
		}
		public function playSound(loop:int=0):SoundChannel {
			return play(125, loop);
		}
	}
}