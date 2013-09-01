package com.database
{
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
	import sekati.crypt.RC4;
	import sekati.crypt.RC4;
	import com.adobe.crypto.MD5;
	import com.globals;

	public class WebServices
	{
		public static const PING:String = "ping";
		public static const GET_USER_BY_ID:String = "get-user-by-id";
		public static const GET_USER_BY_EMAIL:String = "get-user-by-email";
		public static const CREATE_USER:String = "create-user";
		public static const GET_RECENT_USERS:String = "get-recent-users";
		public static const ADD_PLAYTHROUGH:String = "add-playthrough";
		public static const UPDATE_USER:String = "update-user";
		public static const LOGIN:String = "login";
		public static const KEY:String = "0011001101000111011100001111100100101000011000010110100001001";
		public static const GET_HIGH_SCORE:String = "get-high-score";
		public static const GET_USER_HIGH_SCORE:String = "get-user-high-score";
		public static const WEBSERVICE:String = "http://covertstudios.ca/urbanWar/webservices/";
		//break the link for testing. 
		//public static const WEBSERVICE:String="http://XXXcovertstudios.ca/urbanWar/webservices/";


		public static const DATABASE_AVAILABLE:int = 1;
		public static const DATABASE_UNAVAILABLE:int = 0;
		public static var databaseStatus:int = DATABASE_UNAVAILABLE;
		// instance of crypto class
		//public static var _crypto:CryptoCode;
		public static function init():void
		{

			//_crypto = new CryptoCode("PASSWORD");
		}
		public static function login(email:String, callback:Function, failCallback:Function=null):void
		{
			var request:URLRequest = new URLRequest(WEBSERVICE);
			request.method = URLRequestMethod.POST;
			//request.requestHeaders.push(new URLRequestHeader('Content-type', 'multipart/form-data'));

			var variables:URLVariables = new URLVariables();
			var postData:Object = new Object();
			postData.action = LOGIN;
			postData.email = MD5.hash(email.toLowerCase());
			variables.postData = RC4.encrypt(JSON.encode(postData),KEY);
			request.data = variables;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				//sometimes i find random ￛ at the end of these messsgaes. not sure why. 
				callback(handleData(e.target.data));
			}
			function onFail(e:Event):void
			{
				if (failCallback!=null)
				{
					failCallback();
				}
			}
		}

		public static function ping():void
		{
			var request:URLRequest = new URLRequest(WEBSERVICE);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			variables.action = PING;
			request.data = variables;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);

			function onComplete(e:Event):void
			{
				var pingResult:int = e.target.data;
				if (pingResult==DATABASE_AVAILABLE||
				   DATABASE_UNAVAILABLE)
				{
					databaseStatus = pingResult;
				}
				else
				{
					databaseStatus = DATABASE_UNAVAILABLE;
				}

			}
			function onFail(e:Event):void
			{
				databaseStatus = DATABASE_UNAVAILABLE;

			}
		}
		public static function register(email:String, name:String, callback:Function, failCallback:Function=null):void
		{
			var request:URLRequest = new URLRequest(WEBSERVICE);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			var postData:Object = new Object();
			postData.action = CREATE_USER;

			postData.email = MD5.hash(email.toLowerCase());
			postData.name = name;
			variables.postData = RC4.encrypt(JSON.encode(postData),KEY);
			request.data = variables;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				//var dataString = RC4.decrypt(,KEY);
				callback(handleData(e.target.data));
			}
			function onFail(e:Event):void
			{
				if (failCallback!=null)
				{
					failCallback();
				}
			}
		}
		public static function handleData(data:String):String
		{
			var dataString:String = RC4.decrypt(data,KEY);
			//} ends an objet, ] ends an array. The only 2 datatypes I get back from my server. 
			if(dataString.charAt(dataString.length-1)!="}" && dataString.charAt(dataString.length-1)!="]" && dataString!="null")
			{
				return dataString.slice(0,dataString.length-1);
			}

			return dataString;
		}
		/*
		import com.database.*;
		
		var resultDisplay:ScoreResults =new ScoreResults();
		addChild(resultDisplay);
		getHighScore.addEventListener(MouseEvent.CLICK,getScore);
		addPlaythrough.addEventListener(MouseEvent.CLICK,add);
		getUserHighScoreButton.addEventListener(MouseEvent.CLICK,getUserScore);*/
		public static function addPlaythrough(callback:Function,score:int,levelId:int, loadOut:String,replay:Boolean,enemiesKilled:int, accuracy:int, gearsCollected:int, imgData:BitmapData, failCallback:Function=null ):void
		{
			var request:URLRequest = new URLRequest(WEBSERVICE);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			var postData:Object = new Object();
			postData.action = ADD_PLAYTHROUGH;
			postData.score = score;
			postData.userId = User.uid;
			var encoder:JPGEncoder = new JPGEncoder(80);
			postData.imgData = Base64.encode(encoder.encode(imgData));
			postData.level = levelId;
			postData.loadOut = loadOut;
			postData.enemiesKilled = enemiesKilled;
			postData.accuracy = accuracy;
			postData.gearsCollected = gearsCollected;
			postData.replay = int(replay);
			variables.postData = RC4.encrypt(JSON.encode(postData),KEY);
			request.data = variables;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				if (callback!=null)
				{
					callback();
				}
			}
			function onFail(e:Event):void
			{
				if (failCallback!=null)
				{
					failCallback();
				}

			}
		}
		public static function getScore(resultDisplay:ScoreResults, level:int, callback:Function, failCallback:Function=null):void
		{
			resultDisplay.startLoading();
			var request:URLRequest = new URLRequest(WEBSERVICE);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			var postData:Object = new Object();
			postData.action = GET_HIGH_SCORE;
			postData.level = level;
			variables.postData = RC4.encrypt(JSON.encode(postData),KEY);
			request.data = variables;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				resultDisplay.finishLoading();
				
				resultDisplay.createResults(JSON.decode(handleData(e.target.data)));
				callback();
			}
			function onFail(e:Event):void
			{
				resultDisplay.onLoadFail();
				if (failCallback!=null)
				{
					failCallback();
				}
			}
		}
		public static function updateUser( callback:Function=null, failCallback:Function=null):void
		{
			var request:URLRequest = new URLRequest(WEBSERVICE);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			var postData:Object = new Object();
			postData.action = UPDATE_USER;
			postData.name = User.name;
			postData.levelsUnlocked = User.levelsUnlocked;
			postData.unlockedWeapons = User.unlockedWeapons;
			postData.gears = User.gears-globals.memoryPadding;
			postData.uid = User.uid;
			variables.postData = RC4.encrypt(JSON.encode(postData),KEY);
			request.data = variables;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{

				if (callback!=null)
				{
					callback();
				}
			}
			function onFail(e:Event):void
			{
				if (failCallback!=null)
				{
					failCallback();
				}

			}
		}

		public static function getUserScore(resultDisplay:ScoreResults, level:int, callback:Function, userId:int, failCallback:Function=null):void
		{
			var request:URLRequest = new URLRequest(WEBSERVICE);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			var postData:Object = new Object();
			postData.action = GET_USER_HIGH_SCORE;
			postData.level = level;
			postData.user = userId;
			variables.postData = RC4.encrypt(JSON.encode(postData),KEY);
			request.data = variables;
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onFail);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
			function onComplete(e:Event):void
			{
				//var resultData:Object  = JSON.decode(e.target.data);
				//for (var i:int=0;i<resultData.length;i++)
				//{
				//trace(resultData[i].name+" "+resultData[i].score);
				//}
				resultDisplay.createResults(JSON.decode(handleData(e.target.data)));
				callback();
			}
			function onFail(e:Event):void
			{
				if (failCallback!=null)
				{
					failCallback();
				}

			}
		}
	}
}