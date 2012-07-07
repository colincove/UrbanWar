package com.UI{
	import flash.display.MovieClip;
	import com.globals;
	import com.database.WebServices;
	import flash.events.MouseEvent;

	import flash.display.DisplayObjectContainer;
	import com.database.User;

	public class TitleScreen extends MovieClip 
{
		private var currentPrompt:Prompt;
		public function TitleScreen():void {
			this.leaderboardsButton.addEventListener(MouseEvent.CLICK, showLeaderboards);
			this.playGameButton.addEventListener(MouseEvent.CLICK, playGame);
			
		}
				private function showLeaderboards(e:MouseEvent):void 
				{
			globals.main.launchLeaderboards();
		}
		private function playGame(e:MouseEvent):void
		{
			if(!User.active || (User.active && User.levelsUnlocked==0))
			{
			globals.main.playGame();
			}else{
				globals.main.launchWeaponMenu();
			}
			close();
		}
		private function logout(e:MouseEvent):void
		{
			User.logout();
			globals.main.launchLoginScreen();
			close();
		}
		private function close():void{
			parent.removeChild(this);
		}
		public function launch():void{
			if(User.active){
				userContext.gotoAndStop(1);
				this.userContext.logoutButton.addEventListener(MouseEvent.CLICK, logout);
				userContext.userNameDisplay.text="Welcom "+User.name;
			}else{
				userContext.gotoAndStop(2);
				this.userContext.loginButton.addEventListener(MouseEvent.CLICK, login);
			}
			
		}
		private function login(e:MouseEvent):void{
close();
globals.main.launchLoginScreen();
		}
	}
}