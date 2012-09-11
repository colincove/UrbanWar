package com.UI{
	import com.events.MenuEvent;
	import flash.display.MovieClip;
	import com.UI.GameMenuPM;
	import com.globals;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import com.camera.ScreenGrabber;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.LoaderContext;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import com.GameComponent;
	public class ScreenGrabDisplay extends GameComponent {
		private var bm:Bitmap;
		public function ScreenGrabDisplay():void {
			super();
			//GameMenuPM.dispatcher.addEventListener(MenuEvent.UPDATE,update);
			bm=new Bitmap(new BitmapData(800,600,false,0x000000));
			this.addChild(bm);
			bm.scaleX=.4;
			bm.scaleY=.4;
		}
		public override function destroy():void {
			super.destroy();
			bm.bitmapData.dispose();
		}
		private function update(e:MenuEvent=null):void {
			bm.bitmapData=ScreenGrabber.currentGrab.bitmapData;
		}
		public function manualUpdate():void {
			update();
		}
		//given the ID of an img on the database from a playthrough, I can display it
		public function fetchImgData(imgId:String):void {
			var imageLoader:Loader = new Loader();
			var crsDomainLoader:LoaderContext;
crsDomainLoader= new LoaderContext();
crsDomainLoader.checkPolicyFile=true;
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			imageLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPFail);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOFail);
			var image:URLRequest=new URLRequest("http://www.covertstudios.ca/urbanWar/img/"+imgId+".jpg");
			imageLoader.load(image,crsDomainLoader);
			//ftp://cove9660@www.covertstudios.ca/urbanWar/img/504d10402e14e.jpg
			function loadComplete(e:Event):void {

				//trace("LoadComplete", e.target.content, e.target.data);
				bm.bitmapData=e.target.content.bitmapData;
			}
			function onHTTPFail(e:HTTPStatusEvent):void {
				if (e.status!=200) {
					OkPrompt.createPrompt(globals.main, "onHTTPFail: "+e.status);
				}
				//
			}
			function onIOFail(e:IOErrorEvent):void {
				OkPrompt.createPrompt(globals.main, "onIOFail: "+e.text);
			}
		}
	}
}