package com.displayObjects{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import com.globalFunctions;
	import flash.display.MovieClip;
	import com.globals;
	public class DynamicBM {
		private var prevX:Number;
		private var prevY:Number;
		public var bmd:BitmapData;
		private var pt:Point;
		private var alpha_rect:Rectangle;
		public var bm:Bitmap;
		private var mat:Matrix;
		private var alphaMult:Number;
		private var Filter:BlurFilter;
		private var cTransform:ColorTransform;
		public var parentClip:MovieClip;
		private var BmControl:MovieClip;
		private var drawDelay:uint;
		private var interval:int;
		private var drawList:Array;
		public function DynamicBM(bmd:BitmapData, pt:Point,alpha_rect:Rectangle, bm:Bitmap, alphaMult:Number, Filter:BlurFilter, parentClip:MovieClip, BmControl:MovieClip, drawDelay:uint=0):void {
			this.bmd=bmd;
			cTransform=new ColorTransform();
			cTransform.alphaMultiplier=alphaMult;
			this.pt=pt;
			interval=0;
			drawList=new Array();
			this.mat=new Matrix();
			this.alpha_rect=alpha_rect;
			this.bm=new Bitmap(bmd);
			this.alphaMult=alphaMult;
			this.Filter=Filter;
			this.drawDelay=drawDelay;
			this.parentClip=parentClip;
			this.BmControl=BmControl;
			parentClip.addChild(this.bm);
		}
		public function destroy():void{
			bm=null;
			bmd.dispose();
			pt=null;
			alpha_rect=null;
			mat=null;
			Filter=null;
			cTransform=null;
			parentClip=null;
			BmControl=null;
			drawList.slice();
		}
		public function Update():void {
			//bmd.applyFilter(bmd, alpha_rect, pt, Filter);
			bm.x=globalFunctions.makeX(bm,globals.HUD.x-400);
			bm.y=globalFunctions.makeY(bm,globals.HUD.y-300);
			bmd.scroll((prevX-globals.HUD.x),(prevY-globals.HUD.y));
			prevX=globals.HUD.x;
			prevY=globals.HUD.y;
			bmd.colorTransform(alpha_rect, cTransform);
			if (interval==drawDelay) {
				interval=-1;
				for (var i:int=0; i<drawList.length; i++) {
					drawObject(drawList[i]);
				}
			}
			interval++;

		}
		public function drawObject(obj:MovieClip):void {
			mat.translate((globalFunctions.getLevelX(obj))-mat.tx,(globalFunctions.getLevelY(obj))-mat.ty);
			bmd.draw(obj, mat,null,null,null,false);
		}
		public function scrollBM(xScroll:int, yScroll:int):void {
			bmd.scroll(xScroll, yScroll);
		}
		public function addDrawObj(obj:MovieClip):void {
			drawList.push(obj);
		}
		public function removeDrawObj(obj:MovieClip):void {
			globalFunctions.removeFromList(drawList, obj);
		}
	}
}