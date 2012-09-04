package {
	import flash.display.MovieClip;
	import com.globals;
	import com.Prog;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.UI.*;
	import sekati.crypt.Rijndael;
import com.Sound.GlobalSounds;
import flash.events.TimerEvent;
import flash.utils.Timer;
import com.database.WebServices;
import com.globalFunctions;
import com.removeChildrenUtil;

	public class scrollerDocumentClass extends MovieClip {
		var weaponUI:MovieClip;
		var levelUI:MovieClip;
			var pauseUI:MovieClip;
		var game:gameStart;
		var loginScreen:LoginScreen;
		var titleScreen:TitleScreen;
		var leaderboards:Leaderboards;
		var menuBackground:MovieClip;
		var levelEndTimer:Timer;
var endLevelScreen:EndLevelScreen;

		var skipButton:SkipButton;

		var introAnimation:MovieClip;
		var outroAnimation:MovieClip;
		public function scrollerDocumentClass():void 
		{
			
			// create instance with encryption key
			WebServices.init();
			GlobalSounds.defineSounds();
			menuBackground=new MenuBackground();
			globals.prog=new Prog();
			globals.game_progThread=globals.prog.newThread();
			globals.menus_progThread=globals.prog.newThread();
			globals.static_progThread=globals.prog.newThread();
			weaponUI  =  new GameMenu();
		levelUI  =  new levelMenu();
			pauseUI  =  new PauseUI();
			loginScreen = new LoginScreen();
			globals.setMain(this);//must set before starting game. 
			globals.setGravity(1);//must set before starting game.
			launchLoginScreen();
			game = new gameStart();
			titleScreen = new TitleScreen();
			leaderboards=new Leaderboards();
			endLevelScreen = new EndLevelScreen();
			WebServices.ping();
		}
		public function launchEndLevelScreen():void
		{
			if(endLevelScreen==null)
			{
				endLevelScreen=new EndLevelScreen();
			}
			endLevelScreen.launch();
		}
		private function validateMenuBackground():void
		{
			if(!menuBackground.parent)
			
			{
			this.addChild(menuBackground);
			}
		}
		public function launchWeaponMenu():void 
		{
			if(globals.skipWeaponMenu){
				game.startLevel();
			}else{
				this.x=0;
			this.y=0;
			weaponUI.launch();
			this.addChild(weaponUI);
			}
			
		}
		public function launchPauseMenu():void 
		{
			this.addChild(pauseUI);
			pauseUI.x=globals.HUD.x;
			pauseUI.y=globals.HUD.y;
		}
		public function removePauseMenu():void
		{
			pauseUI.parent.removeChild(pauseUI);
		}
		public function launchLevelMenu():void 
		{
			this.x=0;
			this.y=0;
			//weaponUI.launch();
			this.addChild(levelUI);
		}
		public function loginComplete():void
		{
			launchTitleScreen();
		}
		public function playGame():void
		{
			
			if(menuBackground.parent)
			{
			this.removeChild(menuBackground);
			}
			skipButton = new SkipButton();
			skipButton.x=17;
			skipButton.y=558.9;
			introAnimation = new IntroAnimation();
			skipButton.addEventListener(MouseEvent.CLICK, skipScene);
			//introAnimation = new ClosingCinematic();
			this.addChild(introAnimation);
			addChild(skipButton);
			introAnimation.addEventListener(Event.ENTER_FRAME, listenForCompleteAnimation);
			//game.startLevel();
		}
		public function playEndGameScene():void{
			skipButton = new SkipButton();
			skipButton.x=17;
			skipButton.y=558.9;
			globals.endOfGame=true;
				globals.letPlayerLive=true;
			outroAnimation = new ClosingCinematic();
			skipButton.addEventListener(MouseEvent.CLICK, skipScene);
			//introAnimation = new ClosingCinematic();
			this.addChild(outroAnimation);
			addChild(skipButton);
			outroAnimation.addEventListener(Event.ENTER_FRAME, listenForCompleteEndAnimation);
			//game.startLevel();
			
		}
		private function skipScene(e:MouseEvent):void
		{
			introAnimation.gotoAndPlay(559);
		}
		private function skipEndScene(e:MouseEvent):void
		{
			introAnimation.gotoAndPlay(559);
		}
		private function listenForCompleteEndAnimation(e:Event):void
		{
			if(outroAnimation.currentFrame==530)
			{
				
				x=0;
			y=0;
			globals.endOfGame=true;
			
					globals.main.getGame().beatCurrentLevel();
			}
			if(outroAnimation.currentFrame==1000)
			{
				skipButton.removeEventListener(MouseEvent.CLICK, skipScene);
							removeChild(skipButton);
skipButton=null;
			}
			if(outroAnimation.currentFrame==1525)
			{
				globals.main.launchEndLevelScreen();
				
				outroAnimation.stop();
				outroAnimation.removeEventListener(Event.ENTER_FRAME, listenForCompleteEndAnimation);
				//removeChild(introAnimation);
				removeChildrenUtil.removeAllChildren(outroAnimation);
			}
			}
		private function listenForCompleteAnimation(e:Event):void
		{
			if(introAnimation.currentFrame==560)
			{
				skipButton.removeEventListener(MouseEvent.CLICK, skipScene);
							removeChild(skipButton);
skipButton=null;
			}
			if(introAnimation.currentFrame==768)
			//if(introAnimation.currentFrame==1000)
			{
							
				introAnimation.removeEventListener(Event.ENTER_FRAME, listenForCompleteAnimation);
				//removeChild(introAnimation);
				removeChildrenUtil.removeAllChildren(introAnimation);
				introAnimation.stop();
				if(introAnimation.parent!=null){
					removeChild(introAnimation);
				}
				introAnimation=null;
				game.startLevel();
			}
		}
		public function launchTitleScreen():void 
		{
			validateMenuBackground()
			this.x=0;
			this.y=0;
			//weaponUI.launch();
			titleScreen.launch();
			this.addChild(titleScreen);
		}
				public function launchLeaderboards():void
				{
			this.x=0;
			this.y=0;
			leaderboards.launch();
			//weaponUI.launch();
			this.addChild(leaderboards);
		}
		public function launchLoginScreen():void
		{
			validateMenuBackground();
			addChild(loginScreen);
		}
		public function getWeaponMenu():MovieClip
		{
			return weaponUI;
		}
		public function getGame():gameStart
		{
		return game;
		}
		
		public function heroDie():void
		{
			game.wonLevel=false;
			globals.gameVars.orbs=globals.gameVars.oldOrbs;
			globals.HUD.stopCAM();
			if(game.levelsUnlocked==1)
			{
				//if the hero died while on the first level, we need to remove the jetpack that he retrieved. 
				if(globals.hero.jetpack!=null){
				globals.hero.jetpack.destroy();
				globals.hero.jetpack=null;
				}
			}
			levelEndTimer = new Timer(5000);
			levelEndTimer.addEventListener(TimerEvent.TIMER,endLevelTimer);
			levelEndTimer.start();
			WeaponList.loadWeapons(WeaponList.oldInventory);
			
		}
		public function endLevelTimer(e:TimerEvent):void
		{
			
			levelEndTimer.reset();
				levelEndTimer.removeEventListener(TimerEvent.TIMER,endLevelTimer);
				
				globals.main.getGame().endCurrentLevel();
		}
	}
}