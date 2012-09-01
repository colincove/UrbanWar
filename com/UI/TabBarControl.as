package com.UI{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	public class TabBarControl extends EventDispatcher {
		public static const BTN1:String="btn1";
		public static const BTN2:String="btn2";
		
		private var btn1:MovieClip;
		private var btn2:MovieClip;
		private var container:MovieClip;
		private var state:String=BTN1;
		private var activeButton:MovieClip;
		public function TabBarControl(btn1:MovieClip, btn2:MovieClip, container:MovieClip):void {
			this.btn1=btn1;
			this.btn2=btn2;
			this.container=container;
			btn1.addEventListener(MouseEvent.MOUSE_DOWN,btn1Hit);
			btn2.addEventListener(MouseEvent.MOUSE_DOWN,btn2Hit);
			btn1.gotoAndStop(1);
			btn2.gotoAndStop(1);
			setActiveButton(btn1);
			setActiveButton(btn2);

		}
		private function btn1Hit(e:MouseEvent=null):void {

			state=BTN1;
				setActiveButton(btn2);

		}
		private function btnHit(e:MouseEvent=null):void
		{
			


		}
		private function btn2Hit(e:MouseEvent=null):void 
		{
			state=BTN2;
				setActiveButton(btn1);
		}
		private function setState(state:String):void {
			if (state==TabBarControl.BTN1) {
				btn1Hit();
			}
			if (state==TabBarControl.BTN2) {
				btn2Hit();
			}
		}
		private function setActiveButton(newButton:MovieClip):void
		{
			
			if (activeButton!=newButton) 
			{

				if (activeButton==null)
				{
					activeButton=btn1;
				}
				if(activeButton!=null){
					//activeButton.removeEventListener(MouseEvent.MOUSE_DOWN,btn1Hit);
				activeButton.removeEventListener(MouseEvent.ROLL_OUT, btnRollOut);
				activeButton.removeEventListener(MouseEvent.ROLL_OVER, btnRollOver);
				//activeButton.removeEventListener(MouseEvent.ROLL_OVER, btnDown);
				activeButton.buttonMode=false;
				activeButton.gotoAndStop(3);
				activeButton=newButton;
				activeButton.addEventListener(MouseEvent.ROLL_OUT, btnRollOut);
				activeButton.addEventListener(MouseEvent.ROLL_OVER, btnRollOver);
				//activeButton.addEventListener(MouseEvent.ROLL_OVER, btnDown);
				activeButton.buttonMode=true;
				activeButton.gotoAndStop(1);
				this.dispatchEvent(new Event(state));
				}
			}

		}
		private function btnRollOut(e:MouseEvent=null):void 
		{
			activeButton.gotoAndStop(1);
		}
		private function btnRollOver(e:MouseEvent=null):void
		{
			activeButton.gotoAndStop(2);
		}
		private function btnDown(e:MouseEvent=null):void
		{
			
		}
	}
}