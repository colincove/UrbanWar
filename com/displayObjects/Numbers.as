package com.displayObjects{
	import flash.display.MovieClip;
	import com.globals;
	public class Numbers extends MovieClip {
		protected var pointInt:int;
		protected var pointList:Array;
		protected var digitList:Array;
		protected var digitSpace:int;
		
		public function Numbers(pointInt:int):void {
			if(pointInt>=0){
			this.pointInt=pointInt;
			digitSpace=-8;
			digitList=new Array();
			pointList=makeArray(pointInt, new Array());
			makeNumbers();
			setNumbers();
			}
		}
		private function newDigit():MovieClip {
			var num:MovieClip = new Num();
			addChild(num);
			return num;
		}
		protected function setNumbers():void
		{
			for (var i:int=0; i<pointList.length; i++)
			{
				digitList[i].gotoAndStop(pointList[i]+1);
				digitList[i].x=i*digitSpace;
			}
			while(digitList.length>pointList.length)
			{
				removeChild(digitList.pop());
				
			}
		}
		protected function makeNumbers():void {
			for (var i:int=0; i<pointList.length; i++) {
				if(digitList[i]==null){
				digitList[i]=newDigit();
				
				}
			}
		}
		public function setPointArray(num:int):void
		{
			if(num>=0){
			pointList = makeArray(num,pointList);
			makeNumbers();
			setNumbers();
			}
		}
		protected function makeArray(pointInt:int, insertArray:Array):Array 
		{
			if(pointInt>=0)
			{
			var i:int=0;
			insertArray.splice(0,insertArray.length);
			do 
			{
				insertArray[i]=(pointInt%10);
				pointInt/=10;
				i++;
			}while (pointInt>=1);
			
			return insertArray;
			}
			return new Array();
		}
	}
}