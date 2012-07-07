package com.items {
	import com.globals;
	import com.UI.JetpackRetrievedPrompt;

	public class JetpackItem extends FloatingItem 
	{

		public function JetpackItem()
		{
			// constructor code
			super(50,this);
		}
public function action():void 
		{
			removeSelf();
			globals.hero.createJetpack();
			parent.removeChild(this);
			JetpackRetrievedPrompt.createPrompt();
								globals.game_progThread.removeProg(this);
		}
	}
	
}
