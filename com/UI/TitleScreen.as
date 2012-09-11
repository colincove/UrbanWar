package com.UI{
	import flash.display.MovieClip;
	import com.globals;
	import com.database.WebServices;
	import flash.events.MouseEvent;

	import flash.display.DisplayObjectContainer;
	import com.database.User;

	public class TitleScreen extends MovieClip {
		private var currentPrompt:Prompt;
		public function TitleScreen():void {
			this.leaderboardsButton.addEventListener(MouseEvent.CLICK, showLeaderboards);
			this.playGameButton.addEventListener(MouseEvent.CLICK, playGame);
this.controlsButton.addEventListener(MouseEvent.CLICK, controlsClick);
		}
		private function showLeaderboards(e:MouseEvent):void {
			globals.main.launchLeaderboards();
		}
		private function playGame(e:MouseEvent):void 
		{
			if (!User.active || (User.active && User.levelsUnlocked==1)) {
				globals.main.playGame();
			} else {
				globals.main.getGame().wonLevel=true;
				globals.main.launchWeaponMenu();
			}
			close();
		}
		private function logout(e:MouseEvent):void 
		{
			globals.main.launchLoginScreen();
					OkPrompt.createPrompt(globals.main,"User "+User.name+" succesfuly logged out");
			User.logout();
			globals.main.getGame().currentLevelID=1;
		globals.main.getGame().playLevelID=1;
		globals.main.getGame().levelsUnlocked=1;
		globals.main.getGame().wonLevel=false;
		globals.main.getGame().gameVars.orbs=globals.memoryPadding;
globals.levelProgress=1;
		WeaponList.loadDefaultWeapons(globals.main.getGame().gameVars);
			
			close();
		}
		private function close():void {
			parent.removeChild(this);
		}
		public function launch():void {
			if (User.active) {
				userContext.gotoAndStop(1);
				this.userContext.logoutButton.addEventListener(MouseEvent.CLICK, logout);
				userContext.userNameDisplay.text="Welcom "+User.name;
			} else {
				userContext.gotoAndStop(2);
				this.userContext.loginButton.addEventListener(MouseEvent.CLICK, login);
			}
			if(globals.levelProgress==9){
				gotoAndStop(2);
			}

		}
		private function controlsClick(e:MouseEvent):void 
		{
			ControlsPrompt.createPrompt(globals.main);
		}
		private function login(e:MouseEvent):void {
			close();
			globals.main.launchLoginScreen();
		}
	}
}