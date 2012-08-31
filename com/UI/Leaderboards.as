package com.UI{
	import flash.display.MovieClip;
	import com.globals;
	import com.database.*;
	import flash.events.MouseEvent;

	import flash.display.DisplayObjectContainer;
	import com.database.User;

	public class Leaderboards extends MovieClip {
		private var currentPrompt:Prompt;
		private var resultDisplay:ScoreResults;
		private var levelView:int;
		public function Leaderboards():void {
			resultDisplay=new ScoreResults();
			resultDisplay.x=225;
			resultDisplay.y=145;
			this.addChild(resultDisplay);
			leaderboard1.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard2.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard3.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard4.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard5.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard6.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard7.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard8.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			leaderboard9.addEventListener(MouseEvent.CLICK,getLeaderboardRecords);
			
			CloseButton.addEventListener(MouseEvent.CLICK,close);
			
		}
		private function getLeaderboardRecords(e:MouseEvent):void 
		{
			levelView=int(e.target.name.split("leaderboard")[1]);
			//currentPrompt=InfoModal.createPrompt(DisplayObjectContainer(root),"Retrieving results...");
			WebServices.getScore(resultDisplay,levelView,resultFound, onFail);
			function resultFound():void 
			{
				//currentPrompt.remove();
			}
			function onFail():void 
			{
				//currentPrompt.remove();
				currentPrompt=OkPrompt.createPrompt(DisplayObjectContainer(root),"An error occured. Results could not be found. Please Try again.");

			}
		}
		private function close(e:MouseEvent):void
		{
			parent.removeChild(this);
		}
		private function findMe(e:MouseEvent):void{
			//currentPrompt=InfoModal.createPrompt(DisplayObjectContainer(root),"Retrieving results...");
			WebServices.getUserScore(resultDisplay,levelView,resultFound, User.uid);
			function resultFound():void 
			{
				//currentPrompt.remove();
			}
		}
		public function launch():void{
			if(User.active){
				userContext.gotoAndStop(1);
				userContext.findMeButton.addEventListener(MouseEvent.CLICK,findMe);
				userContext.userNameDisplay.text=User.name;
			}else{
				userContext.gotoAndStop(2);
			}
		}
	}
}