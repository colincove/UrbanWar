/** * sekati.ui.Scroll * @version 1.0.7 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.ui {	import caurina.transitions.Tweener;		import sekati.display.Canvas;	import sekati.events.ExternalMouseEvent;	import sekati.external.ExternalMouseWheel;	import sekati.validators.OSValidator;		import flash.display.*;	import flash.events.*;	import flash.geom.Rectangle;			/**	 * Scroll provides a flexible scrollbar controller class: handling mouseWheel (PC & Mac), dynamic resizing content, external size 	 * tracking for accordian style content scrolling, slideContent method, modal ui states, proportional bar, gutter and more.	 * 	 * @see sekati.external.ExternalMouseWheel	 * @see sekati.events.ExternalMouseEvent	 * @see http://code.google.com/p/sekati/source/browse/trunk/deploy/js/swfmouse.js	 */	public class Scroll {		/**		 * Default percentage of content to tween by in <code>move</code> methods.		 */		protected static const MOVE_PERCENT : Number = 0.05;		/**		 * Default tween duration, in second, in <code>move</code> methods. 		 */		protected static const MOVE_TIME : Number = 0.2;		// scroll properties				/*** @private */		protected var _axis : String;		/*** @private */		protected var _prop : String;		// scroll objects				/*** @private */		protected var _content : DisplayObject;		/*** @private */		protected var _contentSizeTracker : DisplayObject;		/*** @private */		protected var _scrollArea : DisplayObject;			/*** @private */		protected var _gutter : Sprite;		/*** @private */		protected var _bar : Sprite;		// options				/*** @private */		protected var _isProportionalGutter : Boolean;		/*** @private */		protected var _isProportionalBar : Boolean;		/*** @private */		protected var _hasMouseWheel : Boolean;		/*** @private */		protected var _friction : Number;		/*** @private */		protected var _ratio : Number;		/*** @private */		protected var _ease : String;		// state tracking				/*** @private */		protected var _isDrag : Boolean;		/*** @private */		protected var _contentBegin : Number;		/*** @private */		protected var _contentEnd : Number;		/*** @private */		protected var _gutterBegin : Number;		/*** @private */		protected var _gutterEnd : Number;		/*** @private */		protected var _oldPos : Number;		/*** @private */		protected var _newPos : Number;		/*** @private */		protected var _speed : Number;		/**		 * Scroll Constructor		 * @param content 				The scrollable content <code>DisplayObject</code> <i>(Registered 0,0 in its container)</i>.		 * @param scrollArea 			The area within which the <code>content</code> is to be scrolled; usually a mask, background or overlay. Also the area within which <code>MouseWheel</code> support is active.		 * @param gutter 				The clickable, interactive "track" area for the scroll <code>bar</code> <i>(Registered axis 0 in its container)</i>.		 * @param bar 					The object which is dragged or thrown to scroll <code>content</code> inside the <code>viewArea</code> <i>(Registered axis 0 in its container)</i>.		 * @param axis 					The axis (must be: <code>x || y</code>) upon which to scroll.		 * @param isInit 				The (optional) initialization <code>Scroll</code> upon instantiation, otherwise <code>init()</code> must be called manually.		 * @param hasMouseWheel 		The (optional) enabling of <code>MouseWheel</code> support (both Mac & PC) of the <code>Scroll</code> instance.		 * @param isProportionalGutter 	The (optional) resizing of the gutter to match the <code>viewArea</code>'s width or height depending on <code>axis</code>.		 * @param isProportionalBar 	The (optional) resizing of the scroll <code>bar</code> to reflect the <code>viewArea</code>'s scrollable <code>content</code>.		 * @param ease 					The <code>Tweener</code> easing equation applied to <code>slideContent, slideScroller or moveScroller</code> calls.		 * @param contentSizeTracker 	The (optional) content size tracking object; used to calculate the viewable scroll area. For use in accordian style content where child objects of <code>content</code> visible property is toggled throwing off the scroll calculations.		 * @param friction 				The motion friction of the <code>content</code> & <code>bar</code>. Note: this does not reflect the motion of <code>slideContent, slideScroller or moveScroller</code> calls. 		 * @param ratio 				The motion ratio of the <code>content</code> & <code>bar</code>. Note: this does not reflect the motion of <code>slideContent, slideScroller or moveScroller</code> calls.		 * @throws Error if axis is not "x" or "y" & returns without proper instantiation		 * @example The following code creates a new Scroll instance:		 * <listing version="3.0">		 * // Scroll(content, scrollArea, gutter, bar, axis, isInit, hasMouseWheel, isProportionalGutter, isProportionalBar, easingEquation, contentSizeTracker, friction, ratio); 		 * var scroll:Scroll = new Scroll( content, scrollArea, gutter, bar, "x", true, true, true, true, "easeOutQuint", null, 0.7, 0.4 );		 * </listing>		 */		public function Scroll(content : DisplayObject, scrollArea : DisplayObject, gutter : Sprite, bar : Sprite, axis : String = "y", isInit : Boolean = true, hasMouseWheel : Boolean = true, isProportionalGutter : Boolean = true, isProportionalBar : Boolean = true, ease : String = "easeOutExpo", contentSizeTracker : DisplayObject = null, friction : Number = 0.8, ratio : Number = 0.5) {			if (axis != "x" && axis != "y") {				throw new Error( "sekati.ui.Scroll Constructor expects axis param: 'x' or 'y'." );			}			_speed = 0;					_prop = (axis == "y") ? "height" : "width";			_isDrag = false;						// user defined			_content = content;			_scrollArea = scrollArea;			_gutter = gutter;			_bar = bar;			_contentSizeTracker = (contentSizeTracker == null) ? _content : contentSizeTracker;			_axis = axis;			_isProportionalBar = isProportionalBar;			_isProportionalGutter = isProportionalGutter;			_hasMouseWheel = hasMouseWheel;			_friction = friction;			_ratio = ratio;			_ease = (ease != null) ? ease : "linear";			// auto init on request ...			if (isInit) {				init( );			}		}		/**		 * Initialize scroll behavior: define confines, mouseWheel, and set scroller to rollout color state.		 */		public function init() : void {			setConfines( );			setMouseWheel( );						_bar.buttonMode = true;			_gutter.buttonMode = true;						// events			_gutter.addEventListener( Event.ENTER_FRAME, enterFrame, false, 0, true );			_gutter.addEventListener( MouseEvent.CLICK, gutterClickHandler, false, 0, true );			_bar.addEventListener( MouseEvent.MOUSE_DOWN, barDownHandler, false, 0, true );			_bar.addEventListener( MouseEvent.MOUSE_UP, barUpHandler, false, 0, true );		}		// SCROLL MOTIONS		/**		 * Tween <code>_bar</code> to position, <code>_content</code> will reposition accordingly.		 * @param pos 	the position to slide scroller on axis.		 * @param sec 	the tween duration in seconds.		 */		public function moveBar(pos : Number, sec : Number = MOVE_TIME) : void {			stopScroll( );			updateConfines( );			var base : Object = (_axis == "y") ? { y:resolvePosition( pos ) } : { x:resolvePosition( pos ) };			Tweener.addTween( _bar, {base:base, time:sec, rounded:true, transition:_ease} );		}		/**		 * Tween to a position within the <code>_content</code>, scroll <code>_bar</code> will reposition accordingly.		 * @param pos 	the position to slide content on axis.		 * @param sec 	the tween duration in seconds.		 */		public function moveContent(pos : Number, sec : Number = MOVE_TIME) : void {			var newScrollPos : Number = (_contentBegin - pos) * (_gutterEnd - _gutterBegin) / (_gutterEnd - _contentEnd + _bar[_prop]) + _gutterBegin;			moveBar( newScrollPos, sec );		}		/**		 * Tween the scroll <code>_bar</code> by a certain amount. Useful when scroll UI arrows are required.		 * @param amount 	of pixels to move: positive or negative.		 * @param sec 		tween duration in seconds.		 * <code>		 * 	_myScroll.moveAmount( -100 );		 * </code>		 */		public function moveAmount(amount : Number, sec : Number = MOVE_TIME) : void {			stopScroll( );			updateConfines( );			moveBar( resolvePosition( _bar[_axis] + amount ), sec );		}		/**		 * Tween the scroll <code>_bar</code> by the specified percentage of the total content.		 * @param percent of total content (e.g. <code>MyScroll.movePercent(.1); // increases position by 10%</code>).		 * @param sec (Number) optional tween duration in seconds		 */		public function movePercent(contentPercent : Number = MOVE_PERCENT, sec : Number = MOVE_TIME) : void {			var pos : Number = Math.ceil( _contentSizeTracker[_prop] * contentPercent );			moveAmount( pos, sec );		}		/**		 * Stop all scrolling motions		 */		public function stopScroll() : void {			_speed = 0;			try {				Tweener.removeTweens( _bar, _axis );			} catch (e : Error) {			}		}						// CONFINE DRIVERS						/**		 * Store the scrollable confines & resize the bar and gutter if necessary.		 */		protected function setConfines() : void {			_contentBegin = _content[_axis];			_gutterBegin = _gutter[_axis];			_gutterEnd = _gutter[_axis] + _gutter[_prop];			if (!_isProportionalBar) {				_gutterEnd -= _bar[_prop];			}			// scale gutter to content scrollArea			_gutter[_prop] = (_isProportionalGutter) ? _scrollArea[_prop] : _gutter[_prop];			updateConfines( );		}		/**		 * Set content related confines (isloated from setConfines as this may need to be called upon content size changes).		 */		protected function updateConfines() : void {			_contentEnd = _contentBegin + _contentSizeTracker[_prop];			//scale scroller bar in proportion to the content to scroll			if (_isProportionalBar) {				// new proportioning				var percent : Number = Math.ceil( (_scrollArea[_prop] / _contentSizeTracker[_prop]) * 100 );							_bar[_prop] = int( _gutter[_prop] * percent / 100 );				//get new gutterEnd with new size of scrollerbar                               				_gutterEnd = _gutter[_axis] + _gutter[_prop] - _bar[_prop];			}		}		/**		 * ResolvePosition insure that the scroller moves within its gutter boundaries.		 */		protected function resolvePosition(pos : Number) : Number {			return Math.max( Math.min( pos, _gutterEnd ), _gutterBegin );		}		// SCROLLABLE GETTER/SETTERS						/**		 * Check if content is scrollable.		 */		public function get isScrollable() : Boolean {			// check if we need a scroller at all			var _isScrollable : Boolean = (_content[_axis] <= _scrollArea[_axis] && _contentSizeTracker[_prop] < _scrollArea[_prop]) ? false : true;			return _isScrollable;		}		/**		 * Check if bar is being dragged.		 */		public function get isDragging() : Boolean {			return _isDrag;			}				/**		 * Check if Mouse is in scrollable area.		 */		public function get isMouseInArea() : Boolean {			//var x : Number = _content.parent.mouseX;			//var y : Number = _content.parent.mouseY;			//return (x >= 0 && x <= _scrollArea.width && y >= 0 && y <= _scrollArea.height);			return(_scrollArea.hitTestPoint( Canvas.stage.mouseX, Canvas.stage.mouseY ));		}		// SCROLL CORE				/**		 * EnterFrame runs the core scroll logic.		 */		protected function enterFrame(e : Event) : void {			//trace( "eof" );			_bar.visible = isScrollable;			// height changed, adjust scroller			if (_contentEnd != _contentBegin + _contentSizeTracker[_prop]) {				_contentEnd = _contentBegin + _contentSizeTracker[_prop];				updateConfines( );				_bar[_axis] = resolvePosition( (_contentBegin + _content[_axis]) * (_gutterEnd - _gutterBegin) / (_gutterEnd - _contentEnd + _bar[_prop]) + _gutterBegin );			}                                                                                              			if (!_isDrag) {				_oldPos = _bar[_axis];				_newPos = _oldPos + _speed;				if (_newPos > _gutterEnd || _newPos < _gutterBegin) {					//bounce - reverse movement					_speed = -_speed;					_newPos = _oldPos;				}				_speed = Math.round( _speed * _friction * 100 ) / 100;			} else {				_oldPos = _newPos;				_newPos = _bar[_axis];			}										//update scroller			_bar[_axis] = _newPos;			//update content			var percent : Number = (_bar[_axis] - _gutterBegin) / (_gutterEnd - _gutterBegin);			_content[_axis] = Math.round( (percent * (_gutterEnd - _contentEnd + _bar[_prop])) + _contentBegin );						//weird throw bug fix - gets stuck on speed 0.05 when scroller is thrown upwards and decelerates			if (_speed < 0.1 && _speed > -0.1) {				_speed = 0;			}					}		// UI EVENT HANDLERS		/**		 * Bar Press - start bar drag: register a pseudo		 * onReleaseOutside event listener on stage.		 */		protected function barDownHandler(e : MouseEvent) : void {			//trace( "press" );			var bounds : Rectangle;			stopScroll( );			_isDrag = true;			if(_axis == "y") {				bounds = new Rectangle( _bar.x, _gutterBegin, 0, _gutterEnd );				_bar.startDrag( false, bounds ); 			} else {				bounds = new Rectangle( _gutterBegin, _bar.y, _gutterEnd, 0 );				_bar.startDrag( false, bounds );			}						// listen for a pseudo "onReleaseOutside": why adobe - why?			_bar.stage.addEventListener( MouseEvent.MOUSE_UP, barUpHandler, false, 0, true );		}		/**		 * Bar Release - stop bar drag: unregister a pseudo		 * onReleaseOutside event listener from stage.		 */		protected function barUpHandler(e : MouseEvent) : void {			//trace( "release" );			_bar.stopDrag( );			_isDrag = false;			//throw			_speed = (_newPos - _oldPos) * _ratio;						// cleanup after our pseudo "onReleaseOutside".			_bar.stage.removeEventListener( MouseEvent.MOUSE_UP, barUpHandler );				}		/**		 * Gutter clicks.		 */		protected function gutterClickHandler(e : MouseEvent) : void {			//trace( "gutter click" );			if (isScrollable) {				_gutter.buttonMode = true;				var mousePos : Number = (_axis == "y") ? _gutter.parent.mouseY : _gutter.parent.mouseX;				moveBar( mousePos - (_bar[_prop] / 2) );			} else {				_gutter.buttonMode = false;			}					}		// MOUSE WHEEL				/**		 * MouseWheel handler for <code>MouseEvent.MOUSE_WHEEL</code> or mac <code>ExternalMouseEvent.MOUSE_WHEEL</code>.		 */		protected function mouseWheelHandler(e : MouseEvent) : void {			//trace( "mouseWheel: " + e.delta + " isMouseInArea: " + isMouseInArea + " isScrollable: " + isScrollable );			if (isMouseInArea && isScrollable) {				var m : Number = _bar[_axis] - ((_gutter[_prop] / 5) * (e.delta / 3));				moveBar( m );				//trace( "moving bar: " + m );			}					}		/**		 * Initialize Mac/PC compatible MouseWheel support.		 */		protected function setMouseWheel() : void {			if (_hasMouseWheel) {				//trace( "setting up mouse wheel ..." );				if (!OSValidator.isMac( )) { 					_scrollArea.addEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true );				} else {					ExternalMouseWheel.$.addEventListener( ExternalMouseEvent.MOUSE_WHEEL, mouseWheelHandler );				}			}		}		// CLEANUP				/**		 * Reset the Scroll and content positioning and reinitialize.		 */		public function reset() : void {			_bar[_axis] = _content[_axis] = 0;			destroy( );			init( );		}		/**		 * Cleanly destroy Scroll instances.		 */		public function destroy() : void {			_gutter.removeEventListener( Event.ENTER_FRAME, enterFrame );			_gutter.removeEventListener( MouseEvent.CLICK, gutterClickHandler );			_bar.removeEventListener( MouseEvent.MOUSE_DOWN, barDownHandler );			_bar.removeEventListener( MouseEvent.MOUSE_UP, barUpHandler );			_bar.stage.removeEventListener( MouseEvent.MOUSE_UP, barUpHandler );							_scrollArea.removeEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelHandler );		}			}}