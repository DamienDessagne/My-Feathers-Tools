package controls {
	import controls.factory.Align;
	import controls.factory.ControlFactory;
	import controls.factory.LayoutFactory;
	
	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	
	// TODO : add custom names to each component for styling
	/**
	 * A toggle button on top of a list. Toggling the button expands/collapse the list.
	 */
	public class TogglePanel extends ScrollContainer {
		
		// EVENTS :
		/** Event dispatched when the panel is about to expand. */
		public static const EXPAND_BEGIN:String = "TogglePanel.ExpandBegin";
		/** Event dispatched when the panel has fully expanded. */
		public static const EXPAND_COMPLETE:String = "TogglePanel.ExpandComplete";
		/** Event dispatched when the panel is about to collapse. */
		public static const COLLAPSE_BEGIN:String = "TogglePanel.CollapseBegin";
		/** Event dispatched when the panel has fully collapsed. */
		public static const COLLAPSE_COMPLETE:String = "TogglePanel.CollapseComplete";
		
		
		/** The juggler used to expand/collapse the panel's content. */
		private var panelJuggler:Juggler;
		/** The expand/collapse animation's duration. */
		public var expandOrCollapseDuration:Number;
		
		private var _isExpanded:Boolean;
		/** Is false when the component is totally collapsed. True otherwise (ie: while expanding). */
		public function get isExpanded():Boolean { return _isExpanded; }
		
		private var _isExpanding:Boolean;
		/** Whether the panel is currently expanding. */
		public function get isExpanding():Boolean { return _isExpanding; }
		
		
		// UI COMPONENTS :
		/** The top button that expands / collapses the content list. */
		public var headerBtn:Button;
		
		/** The clipped content container used to hide / show the content list. */
		private var contentContainer:ScrollContainer;
		
		private var _panelContent:FeathersControl;
		/** The content to be expanded / collapsed. */
		public function get panelContent():FeathersControl { return _panelContent; }
		public function set panelContent(value:FeathersControl):void {
			if(_panelContent == value) return;
			if(_panelContent && contentContainer && _panelContent.parent == contentContainer)
				contentContainer.removeChild(_panelContent);
			_panelContent = value;
			
			if(_panelContent.layoutData == null) 
				_panelContent.layoutData = new AnchorLayoutData(0, 0, NaN, 0);
			if(contentContainer)
				contentContainer.addChild(_panelContent);
		}
		
		
		
		// CONSTRUCTOR :
		/**
		 * Creates a new TogglePanel with the given parameters. The panelContent is added to a
		 * ScrollContainer with an AnchorLayout. By default, if panelContent.layoutData is not set,
		 * the panelContent will be sticked to (0, 0, NaN, 0).
		 * 
		 * @param headerBtn					The button to use as a Header. If a String is supplied, a new Button with this label will be created and used 
		 * @param panelContent				The content to show when the panel is expanded
		 * @param expandOrCollapseDuration	The duration of the expand / collapse animation
		 * 
		 */
		public function TogglePanel(headerBtn:*, panelContent:FeathersControl, expandOrCollapseDuration:Number = .3) {
			super();
			
			this.expandOrCollapseDuration = expandOrCollapseDuration;
			this._isExpanded = false;
			
			// Header button :
			if(headerBtn is Button)
				this.headerBtn = headerBtn as Button;
			else
				this.headerBtn = ControlFactory.getButton(headerBtn as String, Align.LEFT);
			this.headerBtn.isToggle = true;
			
			// Content :
			this.panelContent = panelContent;
		}
		
		/**
		 * Creates the content of the TogglePanel.
		 */
		override protected function initialize():void {
			super.initialize();
			
			layout = LayoutFactory.getVLayout(0, 0);
			
			// Content container :
			contentContainer = ControlFactory.getScrollContainer(ScrollContainer.SCROLL_POLICY_OFF, ScrollContainer.SCROLL_POLICY_OFF);
			contentContainer.height = 0;
			contentContainer.layout = new AnchorLayout();
			
			addChild(headerBtn);
			addChild(contentContainer);
			if(panelContent) contentContainer.addChild(panelContent);
			
			// Panel toggling :
			headerBtn.addEventListener(Event.TRIGGERED, expandOrCollapseContent);
			
			// Juggler :
			panelJuggler = new Juggler();
			Starling.juggler.add(panelJuggler);
		}
		
		
		/**
		 * Disposes the Panel.
		 */
		override public function dispose():void {
			panelJuggler.purge();
			Starling.juggler.remove(panelJuggler);
			
			headerBtn.removeEventListener(Event.TRIGGERED, expandOrCollapseContent);
			
			super.dispose();
		}
		
		
		////////////////////////////////////
		// EXPANDING / COLLAPSING CONTENT //
		////////////////////////////////////
		
		/**
		 * Called on button click.
		 */
		private function expandOrCollapseContent(ev:Event):void {
			if(!isExpanded) expand();
			else collapse();
		}
		
		/**
		 * Expands the content in the given time.
		 */
		public function expand(duration:Number = NaN):void {
			
			if(isNaN(duration))
				duration = expandOrCollapseDuration;
			
			var expandTween:Tween = new Tween(contentContainer, duration, Transitions.EASE_OUT);
			expandTween.animate("height", panelContent.height);
			
			var onExpand:Function = function():void {
				dispatchEventWith(EXPAND_BEGIN);
				headerBtn.isSelected = true;
				panelContent.visible = true;
				_isExpanding = true;
			};
			
			var onExpandComplete:Function = function():void {
				_isExpanding = false;
				resizeToContent();
				dispatchEventWith(EXPAND_COMPLETE);
			}
			
			expandTween.onStart = onExpand;
			expandTween.onComplete = onExpandComplete;
			
			panelJuggler.purge();
			panelJuggler.add(expandTween);
			_isExpanded = true;
		}
		
		/**
		 * Collapses the content in the given time.
		 */
		public function collapse(duration:Number = NaN):void {
			
			if(isNaN(duration))
				duration = expandOrCollapseDuration;
			
			var collapseTween:Tween = new Tween(contentContainer, duration, Transitions.EASE_OUT);
			collapseTween.animate("height", 0);
			
			var onCollapse:Function = function():void {
				dispatchEventWith(COLLAPSE_BEGIN);
				headerBtn.isSelected = false;
			};
			var onCollapseComplete:Function = function():void {
				dispatchEventWith(COLLAPSE_COMPLETE);
				panelContent.visible = false;
			}
			
			collapseTween.onStart = onCollapse;
			collapseTween.onComplete = onCollapseComplete;
			
			panelJuggler.purge();
			panelJuggler.add(collapseTween);
			_isExpanded = false;
		}
		
		
		////////////////////
		// CONTENT RESIZE //
		////////////////////
		
		private var needResize:Boolean = false;
		
		public function resizeToContent():void {
			if(!_isExpanded || (_isExpanded && _isExpanding)) return;
			needResize = true;
			invalidate();
		}
		override protected function draw():void {
			super.draw();
			if(needResize) {
				trace("Resizing to content : " + contentContainer.height + " -> " + panelContent.height);
				contentContainer.height = panelContent.height;
				needResize = false;
			}
		}
	}
}