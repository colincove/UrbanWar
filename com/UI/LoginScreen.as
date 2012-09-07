package com.UI
{
	import flash.display.MovieClip;
	import com.globals;
	import com.database.WebServices;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;
	import com.database.User;

	public class LoginScreen extends MovieClip
	{
		private var currentPrompt:Prompt;
		public function LoginScreen():void
		{
			login.addEventListener(MouseEvent.CLICK,onLoginClick);
			newUser.addEventListener(MouseEvent.CLICK,onNewUserClick);
			continueButton.addEventListener(MouseEvent.CLICK,continueToTitle);
			infoButton.addEventListener(MouseEvent.CLICK,infoClick);
		}
		public function launch():void
		{
			if (globals.loginAfterCompletion)
			{
				loginPrompt.visible = true;
				currentPrompt=OkPrompt.createPrompt(DisplayObjectContainer(globals.main),"After logging in or registering, your games will be uploaded automatically to the server.");
			}
			else
			{
				loginPrompt.visible = false;
			}
		}
		private function onLoginClick(e:MouseEvent):void
		{
			if (emailInput.text == "")
			{
				OkPrompt.createPrompt(DisplayObjectContainer(root),"Please Enter email.");
			}
			else if (EmailValidation.check(emailInput.text))
			{

				currentPrompt = InfoModal.createPrompt(DisplayObjectContainer(root),"Attempting Login...");
				WebServices.login(emailInput.text,response, loginFail);
			}
			else
			{
				OkPrompt.createPrompt(DisplayObjectContainer(root),"Email not valid!");
			}
			function response(result:*):void
			{
				currentPrompt.remove();
				if (result=="-1")
				{
					OkPrompt.createPrompt(DisplayObjectContainer(root),"User does not exist!");
				}
				else
				{
					User.defineFromLoginResponse(result);
					
					if(!checkPlaythroughUpload()){
					OkPrompt.createPrompt(DisplayObjectContainer(root),"Login Succesful! Welcome "+User.name, playGame);
					}
				}
			}
			function loginFail():void
			{
				currentPrompt.remove();
				currentPrompt = OkPrompt.createPrompt(DisplayObjectContainer(root),"An error occured. Login Failed. Please try again.");
			}
		}
		private function infoClick(e:MouseEvent):void
		{
			RegistrationInfoPrompt.createPrompt(DisplayObjectContainer(root));
		}
		private function onNewUserClick(e:MouseEvent):void
		{
			login.removeEventListener(MouseEvent.CLICK,onLoginClick);
			newUser.removeEventListener(MouseEvent.CLICK,onNewUserClick);
			this.gotoAndStop('newUser');
			back.addEventListener(MouseEvent.CLICK,onBackClick);
			register.addEventListener(MouseEvent.CLICK,onRegisterClick);
		}
		private function onRegisterClick(e:MouseEvent):void
		{
			if (nameInput.text == "")
			{

				OkPrompt.createPrompt(DisplayObjectContainer(root),"Please Enter a display name.");
			}
			else if (EmailValidation.check(emailInput.text))
			{
				currentPrompt = InfoModal.createPrompt(DisplayObjectContainer(root),"Creating Account...");

				WebServices.register(emailInput.text,nameInput.text,response, registerFail);

			}
			else
			{
				OkPrompt.createPrompt(DisplayObjectContainer(root),"Email not valid!");
			}
			function response(result:*):void
			{
				currentPrompt.remove();
				if (result=="-1")
				{
					OkPrompt.createPrompt(DisplayObjectContainer(root),"User Already exists!");
				}
				else
				{
					User.defineFromLoginResponse(result);
					if (! checkPlaythroughUpload())
					{
						OkPrompt.createPrompt(DisplayObjectContainer(root),"Account Created! Welcome "+User.name, playGame);
					}
				}
			}
			function registerFail():void
			{
				currentPrompt.remove();
				currentPrompt = OkPrompt.createPrompt(DisplayObjectContainer(root),"An error occured. Registration Failed. Please try again.");
			}
		}
		private function checkPlaythroughUpload():Boolean
		{
			if (globals.loginAfterCompletion)
			{
				currentPrompt = InfoModal.createPrompt(globals.main,"Games being uploaded");
				globals.playthroughMemory.upload(uploadComplete, uploadFail);
				return true;
				function uploadFail():void
				{
					currentPrompt.remove();
					currentPrompt = OkPrompt.createPrompt(globals.main,"Problem uploading games");
				}
				function uploadComplete():void
				{
					globals.loginAfterCompletion = false;
					currentPrompt.remove();
					OkPrompt.createPrompt(globals.main,"Games succesfuly uploaded to server!",playGame);
				}
			}else{
				return false;
			}
			return false;
			
		}
		private function playGame():void
		{
			if(globals.loginAfterCompletion)
			{
				currentPrompt=ChoicePrompt.createPrompt(globals.main,continueProcess,function(){},"If you choose to continue to the title screen at this time, your game data will be lost. Leave without logging in?");
				function continueProcess():void
				{
					currentPrompt.remove();
					globals.main.loginComplete();
			parent.removeChild(this);
				}
			}else{
				globals.main.loginComplete();
			parent.removeChild(this);
			}
			
		}
		private function onBackClick(e:MouseEvent):void
		{
			back.removeEventListener(MouseEvent.CLICK,onBackClick);
			register.removeEventListener(MouseEvent.CLICK,onRegisterClick);
			this.gotoAndStop('login');
			login.addEventListener(MouseEvent.CLICK,onLoginClick);
			newUser.addEventListener(MouseEvent.CLICK,onNewUserClick);
		}
		private function continueToTitle(e:MouseEvent):void
		{
			playGame();
		}
	}
}