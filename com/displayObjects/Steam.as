package com.displayObjects{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.globals;
	import com.displayObjects.DynamicBM;
	import com.globalFunctions;
	import com.interfaces.removable;
	import com.interfaces.Program;
	import flash.display.MovieClip;
	public class Steam extends MovieClip implements removable, Program {
		private var circle_smokeBMD:BitmapData;
		private var pt:Point;
		private var alpha_rect:Rectangle;
		private var cTransform:ColorTransform;
		private var filter:BlurFilter;
		private var mat:Matrix;
		private var smokeArray:Array;
		private var prevX:Number;
		private var prevY:Number;
		private var bmObject:Object;
		private var bmList:Array;
		private var trailsAdded:Boolean;
		private var smokeBM:DynamicBM;
		public var steamBM:DynamicBM;
				public var progRun:Boolean;//Program Run. True if running, false if not. 

		public function Steam(parentClip):void {
						steamBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.90,new BlurFilter(2,2),'laser',parentClip,2);

			globals.game_progThread.addProg(this);
			progRun=true;
		}
		public function addDynamicBm(bmd:BitmapData,pt:Point,alpha_rect:Rectangle,bm:Bitmap,alphaMult:Number,Filter:BlurFilter,Name:String,parentClip:MovieClip,drawDelay:uint=0):DynamicBM {
			if (bmList==null) {
				bmList=new Array();
			}
			var tmpObj2:DynamicBM=new DynamicBM(bmd,pt,alpha_rect,bm,alphaMult,Filter,parentClip,this,drawDelay);
			bmList.push(tmpObj2);
			return tmpObj2;
		}
		public function removeSelf():void {
					globals.game_progThread.removeProg(this);

		}
		public function update():Object {
			controlSmoke();
			addTrails();
			return this;
		}
		private function addTrails():void {
			if (globals.trails!=null&&!trailsAdded) {
				smokeBM.addDrawObj(globals.trails);
				trailsAdded=true;
				//laserBM.addDrawObj(globals.hero);
				//removeEventListener(Event.ENTER_FRAME,addTrails,false);
			}
		}
		private function controlSmoke():void {
			bmList[0].Update();
			bmList[1].Update();
			globals.trails.graphics.clear();
		}
		public function drawObject(obj:MovieClip,bmObj:Object):void {
			bmObj.mat.translate(globalFunctions.getLevelX(obj)-bmObj.mat.tx,globalFunctions.getLevelY(obj)-bmObj.mat.ty);
			bmObj.bmd.draw(obj,bmObj.mat,null,null,null,false);
		}
				public function isRunning():Boolean{
			return progRun;
		}
	}
}