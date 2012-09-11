package com.UI{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.GameComponent;
	public class TabBarControl extends GameComponent {
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
		private function btn1Hit(e:MouseEvent=null, silent:Boolean=false):void {

			state=BTN1;
			trace(state);
			setActiveButton(btn2);

		}
		private function btnHit(e:MouseEvent=null):void {



		}
		private function btn2Hit(e:MouseEvent=null, silent:Boolean=false):void {
			state=BTN2;
			setActiveButton(btn1);
		}
		public function setState(state:String, silent:Boolean=false):void {
			if (state==TabBarControl.BTN1) {
				btn1Hit(null, silent);
			}
			if (state==TabBarControl.BTN2) {
				btn2Hit(null, silent);
			}
		}

		private function setActiveButton(newButton:MovieClip, silent:Boolean=false):void {
			
			trace(0);
			if (activeButton==null)
			{
				trace(0.5);
					activeButton=btn1;
				}
				trace(0.55, newButton, activeButton);
				trace(1, newButton.name, activeButton.name);
				trace(2);
				
			if (activeButton!=newButton || silent==true)
			{
trace(3);
				
				if (activeButton!=null)
				{
					trace(4);
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
					trace(5);
					if (! silent) {
						this.dispatchEvent(new Event(state));
					}
				}
			}

		}
		private function btnRollOut(e:MouseEvent=null):void {
			activeButton.gotoAndStop(1);
		}
		private function btnRollOver(e:MouseEvent=null):void {
			activeButton.gotoAndStop(2);
		}
		private function btnDown(e:MouseEvent=null):void {

		}
		public override function destroy():void {
			//super.destroy();
			//activeButton.removeEventListener(MouseEvent.ROLL_OUT, btnRollOut);
			//activeButton.removeEventListener(MouseEvent.ROLL_OVER, btnRollOver);
			//btn1=null;
			//btn2=null;
			//trace("DestroyTabBar");
			//container=null;
			//state=null;
			//activeButton=null;

		}
	}
}