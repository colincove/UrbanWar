package com.Sound
{
	import flash.net.URLRequest;
	import flash.media.SoundChannel;
	import flash.utils.getDefinitionByName;
	import com.Sound.MySound;
	import com.globals;
	public class GlobalSounds
	{
		public static var soundObj:Object;
		public function GlobalSounds():void
		{
		}
		public static function defineSounds():void
		{
			if (GlobalSounds.soundObj == null)
			{
				GlobalSounds.soundObj=new Object();
			}
		}
		public static function playSound(sound:String, loop:int=0):SoundChannel
		{
			if (GlobalSounds.soundObj == null)
			{
				defineSounds();
			}
			if (globals.gameVars != null)
			{
				if (globals.gameVars.muteSounds == '1')
				{
					return new SoundChannel();
				}
			}
			/*if (GlobalSounds.soundObj[sound]==null) {
			var tmpString:String='Sound/'+sound+'.mp3';
			GlobalSounds.soundObj[sound]=new MySound(new URLRequest(tmpString));
			}*/
			//getDefinitionByName(objString) as Class
			if (GlobalSounds.soundObj[sound] == null)
			{
				GlobalSounds.soundObj[sound]=new (getDefinitionByName(sound) as Class)();
				trace(sound,GlobalSounds.soundObj[sound]);
			}
			try
			{

				var sc:SoundChannel = GlobalSounds.soundObj[sound].play(loop);
				if (sc==null)
				{
					return new SoundChannel();
				}
				else
				{
					return sc;
				}
			}
			catch (error:Error)
			{
				trace(error, error.message);
				return new SoundChannel();
			}
			return new SoundChannel();
		}
		public static function playRandom(sounds:Vector.<String>,loop:int=0)
		{
			var randomNum:int = int(Math.random() * sounds.length);
			playSound(sounds[randomNum],loop);
		}
	}
}