package com.database{
	import com.adobe.serialization.json.JSON;
	import com.globals;
	public class User 
	{
		public static var name:String;
		public static var uid:int;
		public static var email:String;
		public static var levelsUnlocked:int;
		public static var unlockedWeapons:String;
		public static var joinDate:Date;
		public static var active:Boolean;
		public static function defineFromLoginResponse(response:String):void 
		{
			var responseObject:Object=JSON.decode(response);
			name=responseObject.name;
			email=responseObject.email;
			uid=responseObject.uid;
			levelsUnlocked=responseObject.levelsUnlocked;
			unlockedWeapons=responseObject.unlockedWeapons;
			globals.main.getGame().gameVars.stageStart=levelsUnlocked+1;
			globals.main.getGame().currentLevelID=levelsUnlocked+1;
						globals.levelProgress=globals.main.getGame().currentLevelID;
globals.levelProgress=globals.main.getGame().currentLevelID;
			active=true;
			WeaponList.loadWeapons(unlockedWeapons);
		}
		public static function logout():void{
			active=false;
			name="";
			email="";
			uid=0;
			levelsUnlocked=0;
			unlockedWeapons="";
		}
	}
}