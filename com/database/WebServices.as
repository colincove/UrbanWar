package com.database{
	import com.adobe.serialization.json.*;
	import flash.events.Event;
	import com.foxarc.util.Base64;
	import com.adobe.images.JPGEncoder;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	import flash.display.BitmapData;
	import flash.events.IOErrorEvent;
	import flash.events.ErrorEvent;
	
	import com.adobe.crypto.MD5;

	public class WebServices {
		public static const PING:String="ping";
		public static const GET_USER_BY_ID:String="get-user-by-id";
		public static const GET_USER_BY_EMAIL:String="get-user-by-email";
		public static const CREATE_USER:String="create-user";
		public static const GET_RECENT_USERS:String="get-recent-users";
		public static const ADD_PLAYTHROUGH:String="add-playthrough";
		public static const UPDATE_USER:String="update-user";
		public static const LOGIN:String="login";
		public static const GET_HIGH_SCORE:String="get-high-score";
		public static const GET_USER_HIGH_SCORE:String="get-user-high-score";
				public static const WEBSERVICE:String="http://covertstudios.ca/urbanWar/webservices/";
				//break the link for testing. 
		//public static const WEBSERVICE:String="http://XXXcovertstudios.ca/urbanWar/webservices/";

;
public static const DATABASE_AVAILABLE:int=1;
public static const DATABASE_UNAVAILABLE:int=0;
public static var databaseStatus:int=DATABASE_UNAVAILABLE;
// instance of crypto class
		//public static var _crypto:CryptoCode;
		public static function init():void
		{
			
			//_crypto = new CryptoCode("PASSWORD");
		}
		public static function login(email:String, callback:Function, failCallback:Function=null):void {
			var request:URLRequest=new URLRequest(WEBSERVICE);
			request.method=URLRequestMethod.POST;
			//request.requestHeaders.push(new URLRequestHeader('Content-type', 'multipart/form-data'));

			var variables:URLVariables = new URLVariables();
			variables.action=LOGIN;
			variables.email=email;
			request.data=variables;
			var loader:URLLoader=new URLLoader(request);

			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				callback(e.target.data);
			}
			function onFail(e:Event):void
			{
				if(failCallback!=null)
				{
					failCallback();
				}
			}
		}
		public static function ping():void
		{
			var request:URLRequest=new URLRequest(WEBSERVICE);
			request.method=URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.action=PING;
			//variables.message=_crypto.encrypt("Hello");
			request.data=variables;
			var loader:URLLoader=new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(request);
			
			function onComplete(e:Event):void 
			{
				trace(e.target.data);
				var pingResult:int=e.target.data;
				if(pingResult==DATABASE_AVAILABLE||
				   DATABASE_UNAVAILABLE){
					   databaseStatus=pingResult;
				   }else{
					    databaseStatus=DATABASE_UNAVAILABLE;
				   }
				
			}
			function onFail(e:Event):void
			{
				databaseStatus=DATABASE_UNAVAILABLE;
				
			}
		}
		public static function register(email:String, name:String, callback:Function, failCallback:Function=null):void {
			var request:URLRequest=new URLRequest(WEBSERVICE);
			request.method=URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.action=CREATE_USER;
			
			variables.email=MD5.hash(email);
			variables.name=name;
			request.data=variables;
			var loader:URLLoader=new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void {
				callback(e.target.data);
			}
			function onFail(e:Event):void
			{
				if(failCallback!=null)
				{
					failCallback();
				}
				
			}
		}
		/*
		import com.database.*;
		
		var resultDisplay:ScoreResults =new ScoreResults();
		addChild(resultDisplay);
		getHighScore.addEventListener(MouseEvent.CLICK,getScore);
		addPlaythrough.addEventListener(MouseEvent.CLICK,add);
		getUserHighScoreButton.addEventListener(MouseEvent.CLICK,getUserScore);*/
		public static function addPlaythrough(callback:Function,score:int,levelId:int, loadOut:String,replay:Boolean, imgData:BitmapData, failCallback:Function=null ):void 
		{
			var request:URLRequest=new URLRequest(WEBSERVICE);
			request.method=URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.action=ADD_PLAYTHROUGH;
			variables.score=score;
			variables.userId=User.uid;
			var encoder:JPGEncoder= new JPGEncoder(80);
variables.imgData=Base64.encode(encoder.encode(imgData));
			//variables.photoId="342fds899sfgds9s";
			variables.level=levelId;

			variables.loadOut=loadOut;
			variables.replay=int(replay);


			request.data=variables;
			var loader:URLLoader=new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
		loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				
				if(callback!=null)
				{
					callback();
				}
			}
			function onFail(e:Event):void
			{
				if(failCallback!=null)
				{
					failCallback();
				}
				
			}
		}
		public static function getScore(resultDisplay:ScoreResults, level:int, callback:Function, failCallback:Function=null):void {
			var request:URLRequest=new URLRequest(WEBSERVICE);
			request.method=URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.action=GET_HIGH_SCORE;
			variables.level=level;
			request.data=variables;
			var loader:URLLoader=new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
					loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void {
				resultDisplay.createResults(JSON.decode(e.target.data));
				callback();
			}
			function onFail(e:Event):void
			{
				if(failCallback!=null)
				{
					failCallback();
				}
				
			}
		}
		public static function updateUser( callback:Function=null, failCallback:Function=null):void {
			trace(User.name, User.levelsUnlocked,User.unlockedWeapons,User.uid);
			var request:URLRequest=new URLRequest(WEBSERVICE);
			request.method=URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.action=UPDATE_USER;
			variables.name=User.name;
			variables.levelsUnlocked=User.levelsUnlocked;
			variables.unlockedWeapons=User.unlockedWeapons;
			variables.uid=User.uid;
			request.data=variables;
			var loader:URLLoader=new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
					loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void {
				
				if (callback!=null) {
					callback();
				}
			}
			function onFail(e:Event):void
			{
				if(failCallback!=null)
				{
					failCallback();
				}
				
			}
		}

		public static function getUserScore(resultDisplay:ScoreResults, level:int, callback:Function, userId:int, failCallback:Function=null):void {
			var request:URLRequest=new URLRequest(WEBSERVICE);
			request.method=URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.action=GET_USER_HIGH_SCORE;
			variables.level=level;
			variables.user=userId;
			request.data=variables;
			var loader:URLLoader=new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
					loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat=URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				//var resultData:Object  = JSON.decode(e.target.data);
				//for (var i:int=0;i<resultData.length;i++)
				//{
				//trace(resultData[i].name+" "+resultData[i].score);
				//}

				resultDisplay.createResults(JSON.decode(e.target.data));
				trace(e.target.data);
				callback();
			}
			function onFail(e:Event):void
			{
				if(failCallback!=null)
				{
					failCallback();
				}
				
			}
		}
	}
}