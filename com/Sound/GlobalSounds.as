package com.Sound{
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import com.Sound.MySound;
	import com.globals;
	public class GlobalSounds {
		public static var soundObj:Object;
		public function GlobalSounds():void {
		}
		public static function defineSounds():void {
			GlobalSounds.soundObj=new Object();
		}
		public static function playSound(sound:String, loop:int=0):SoundChannel {
			if (globals.gameVars.muteSounds=='1') {
				return new SoundChannel();
			}
			if (GlobalSounds.soundObj[sound]==null) {
				var tmpString:String='Sound/'+sound+'.mp3';
				GlobalSounds.soundObj[sound]=new MySound(new URLRequest(tmpString));
			}
			try {
				return GlobalSounds.soundObj[sound].playSound(loop);
			} catch (error:Error) {
				
				return new SoundChannel();
			}
			return new SoundChannel();
		}
		public static function playRandom(sounds:Vector.<String>,loop:int=0)
		{
			var randomNum:int = int(Math.random()*sounds.length);
			playSound(sounds[randomNum],loop);
		}
	}
}