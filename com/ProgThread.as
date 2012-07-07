package com{
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.interfaces.Program;
	import com.globalFunctions;
	public class ProgThread extends MovieClip{
		private var programs:Array;
		private var programEnd:Boolean;
		public var isPaused:Boolean=false;
		public function ProgThread():void {
			programs=new Array();
			addEventListener(Event.ENTER_FRAME,runThread, false, 0, true);
		}
		public function runThread(e:Event):void {
			for(var i:int=0; i<programs.length;i++){
				if(programEnd){
					programEnd=false;
					programs=new Array();
					break;
				}
				if(((programs[i])).isRunning()){
					((programs[i])).update();
				}
			}
		}
		public function addProg(prog:Program):Array{
			if(programs.indexOf(prog)<0)
			{
			programs.push(prog);
			}
			return programs;
		}
		public function removeProg(prog:Program):Array{
			globalFunctions.removeFromList(programs, prog);
			return programs;
			
		}
		public function pauseProgram():void
		{
			isPaused=true;
			removeEventListener(Event.ENTER_FRAME,runThread, false);
		}
		public function resumeProgram():void
		{
			isPaused=false;
			addEventListener(Event.ENTER_FRAME,runThread, false, 0, true);
		}
		public function endProgram():Array
		{
			programEnd=true;
			while(programs.length>0)
			{
				programs.pop();
			}
			return programs;
		}
		
	}
}