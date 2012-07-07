package {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import com.globals;
	import com.interfaces.removable;
	public class Controls implements removable {
		public static var upArrowPress:Boolean=false;
		public static var downArrowPress:Boolean=false;
		public static var rightArrowPress:Boolean=false;
		public static var leftArrowPress:Boolean=false;
		public static var pPress:Boolean=false;
		private var keyListener:MovieClip;
		public function Controls(keyListener:MovieClip) {
			this.keyListener=keyListener;
			globals.main.stage.addEventListener(KeyboardEvent.KEY_DOWN,checkDown,false, 0, true);
			globals.main.stage.addEventListener(KeyboardEvent.KEY_UP,checkUp,false, 0, true);
		}
		public function removeSelf():void {
			keyListener=null;
			globals.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN,checkDown,false);
			globals.main.stage.removeEventListener(KeyboardEvent.KEY_UP,checkUp,false);
			upArrowPress=false;
			downArrowPress=false;
			rightArrowPress=false;
			leftArrowPress=false;
		}
		protected function checkDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 87 :
					//keyUp
					if (! upArrowPress) {
						upArrowPress=true;
						keyListener.upPress();
					}
					break;
				case 83 :
					//keyDown
					if (! downArrowPress) {
						downArrowPress=true;
						keyListener.downPress();
					}
					break;
				case 68 :
					//keyRight
					keyListener.rightHold();
					if (! rightArrowPress) {
						rightArrowPress=true;
						keyListener.rightPress();
					}
					break;
				case 65 :
					//keyLeft
					if (! leftArrowPress) {
						leftArrowPress=true;
						keyListener.leftPress();
					}
					break;
					case 80 :
					//keyLeft
					if (! pPress) {
						pPress=true;
					}
					break;
			}
		}
		protected function checkUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 87 :
					//keyUp
					if (upArrowPress) {
						upArrowPress=false;
					}
					break;
				case 83 :
					//keyDown
					if (downArrowPress) {
						downArrowPress=false;

					}
					break;
				case 68 :
					//keyUp
					if (rightArrowPress) {
						rightArrowPress=false;
						keyListener.rightUp();
					}
					break;
				case 65 :
					//keyLeft
					if (leftArrowPress) {
						leftArrowPress=false;
						keyListener.leftUp();
					}
					break;
					case 80 :
					//keyLeft
					if ( pPress) {
						pPress=false;
					}
					break;
			}
		}
	}
}