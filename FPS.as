package {
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.system.System;
	import com.globals;
	public class FPS extends MovieClip {
		//////////FPS/memory Vars
		// vars
		private var mem_txt:TextField;
		private var time:int;
		private var prevTime:int=0;
		private var fps:int;
		private var fps_txt:TextField;
		private var fps_avg_txt:TextField;
		private var fps_avg:int;
		private var prevAvg:Number=0;
		private var totalAvgSteps:int=0;
		private var totalAngFPS:int=0;
		private var fpsAvgTimer:Timer=new Timer(2500,1);
		public function FPS():void {
			///////////////////END //--
			//
			mem_txt=new TextField();
			mem_txt.y=250;
			mem_txt.x=-390;
			fps_txt=new TextField  ;
			fps_txt.textColor=0x0303AF;
			fps_avg_txt=new TextField  ;
			fps_avg_txt.textColor=0x0303AF;
			fps_avg_txt.y=280;
			fps_avg_txt.x=-390;
			fps_txt.y=265;
			fps_txt.x=-390;
			//globals.HUD.addChild(fps_avg_txt);
			//globals.HUD.addChild(fps_txt);
			//globals.HUD.addChild(mem_txt);
			fpsAvgTimer.start();
			fpsAvgTimer.addEventListener(TimerEvent.TIMER,fpsAvgHandler, false, 0, true);
			addEventListener(Event.ENTER_FRAME,getFps, false, 0, true);
			MemoryTracker.stage=globals.main.stage;
			MemoryTracker.debugTextField=mem_txt;
			MemoryTracker.track(globals.main, "Main");
			
		}
		private function fpsAvgHandler(e:TimerEvent):void {
			fps_avg=totalAngFPS/totalAvgSteps;
			fps_avg_txt.text="fps avg: "+fps_avg.toString();
			totalAvgSteps=0;
			totalAngFPS=0;
		}
		private function getFps(e:Event):void {
			//
			//MemoryTracker.gcAndCheck();
			//var mem:String=Number(System.totalMemory/1024/1024).toFixed(2)+'Mb';
			//mem_txt.text="Memory: "+mem;
			time=getTimer();
			fps=1000/(time-prevTime);
			//
			fps_txt.text="fps: "+fps;
			totalAngFPS+=fps;
			totalAvgSteps++;
			//
			prevTime=getTimer();
		}
	}
}