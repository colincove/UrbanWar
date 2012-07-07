package com.displayObjects{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import com.globals;
	import com.displayObjects.DynamicBM;
	import com.globalFunctions;
	import com.interfaces.removable;
	import com.GameComponent;
	import com.interfaces.Program;
	import flash.display.MovieClip;
	public class Smoke extends GameComponent implements removable,Program {
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
		public var smokeBM:DynamicBM;
		public var laserBM:DynamicBM;
		public var stackSmokeBM:DynamicBM;
		//
		public var fireRightBM:DynamicBM;
		public var fireLeftBM:DynamicBM;
		public var fireDownBM:DynamicBM;
		public var fireUpBM:DynamicBM;
		public var steamBM:DynamicBM;
		public var shadowBM:DynamicBM;
		var light:BitmapData=new LightMask(254,254);

		private var shadowSourceMap:BitmapData;
		private var alphaData:BitmapData;
		private var rect:Rectangle;
		public var progRun:Boolean;//Program Run. True if running, false if not. 
		public function Smoke(parentClip):void
		{

			smokeBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.95,new BlurFilter(2,2),'Smoke',parentClip);
			//laserBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.90,new BlurFilter(2,2),'laser',parentClip,2);
			steamBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.90,new BlurFilter(2,2),'laser',parentClip,2);
			//stackSmokeBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.99,new BlurFilter(1,1),'laser',parentClip,2);
			//fireLeftBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.80,new BlurFilter(2,2),'laser',parentClip,2);
			//fireRightBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.80,new BlurFilter(2,2),'laser',parentClip,2);

			//fireDownBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.80,new BlurFilter(2,2),'laser',parentClip,2);

			//fireUpBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,0.80,new BlurFilter(2,2),'laser',parentClip,2);
			//shadowBM=addDynamicBm(new BitmapData(800,600,true,0x00000000),new Point(0,0),new Rectangle(0,0,800,600),null,.5,new BlurFilter(2,2),'laser',parentClip,2);
			globals.game_progThread.addProg(this);
			progRun=true;
			rect=new Rectangle(0,0,3000,3000);
			shadowSourceMap=new BitmapData(800,600,false,0xFF0000);
			alphaData=new BitmapData(800,600,false,0x00000000);
		}
		public function addDynamicBm(bmd:BitmapData,pt:Point,alpha_rect:Rectangle,bm:Bitmap,alphaMult:Number,Filter:BlurFilter,Name:String,parentClip:MovieClip,drawDelay:uint=0):DynamicBM {
			if (bmList==null) {
				bmList=new Array  ;
			}
			var tmpObj2:DynamicBM=new DynamicBM(bmd,pt,alpha_rect,bm,alphaMult,Filter,parentClip,this,drawDelay);
			bmList.push(tmpObj2);
			return tmpObj2;
		}
		public override function destroy():void{
			globals.game_progThread.removeProg(this);
			rect=null;
			shadowSourceMap.dispose();
			alphaData.dispose();
			smokeBM.destroy();
			steamBM.destroy();
		}
		public function removeSelf():void
		{
			globals.game_progThread.removeProg(this);
		}
		public function update():Object 
		{
			controlSmoke();
			addTrails();
			return this;
		}
		private function addTrails():void {
			if (globals.trails!=null&&! trailsAdded) {
				smokeBM.addDrawObj(globals.trails);
				trailsAdded=true;
				//laserBM.addDrawObj(globals.hero);
				//removeEventListener(Event.ENTER_FRAME,addTrails,false);
			}
		}

		private function controlSmoke():void {

///steamBM.bmd.copyChannel(light,new Rectangle(0,0,254,254),new Point(0,400),BitmapDataChannel.ALPHA,BitmapDataChannel.ALPHA);
			steamBM.scrollBM(0, -5);
			for (var i:int=0; i<bmList.length; i++) {
				bmList[i].Update();
			}
			
			
			//stackSmokeBM.scrollBM(0, -2);
			//fireRightBM.scrollBM(-15, 0);
			//fireLeftBM.scrollBM(15, 0);
			//fireUpBM.scrollBM(0, -15);
			//fireDownBM.scrollBM(0, 15);
			globals.trails.graphics.clear();
		}
		public function drawObject(obj:MovieClip,bmObj:Object):void {
			bmObj.mat.translate(globalFunctions.getLevelX(obj)-bmObj.mat.tx,globalFunctions.getLevelY(obj)-bmObj.mat.ty);
			bmObj.bmd.draw(obj,bmObj.mat,null,null,null,false);
		}
		public function isRunning():Boolean {
			return progRun;
		}
	}
}