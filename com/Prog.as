package com{
	import com.ProgThread;
	public class Prog{
		private var threadList:Array;
		public function Prog():void {
			threadList=new Array();
		}
		public function newThread():ProgThread{
			var thread:ProgThread = new ProgThread();
			threadList.push(thread);
			return thread;
		}
	}
}