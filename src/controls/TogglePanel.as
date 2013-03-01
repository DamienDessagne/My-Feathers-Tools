package controls {
	import controls.factory.Align;
	import controls.factory.ControlFactory;
	
	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import feathers.core.FeathersControl;
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
		
		
		// UI COMPONENTS :
		/** The top button that expands / collapses the content list. */
		public var headerBtn:Button;
		
		/** The clipped content container used to hide / show the content list. */
		private var contentContainer:ScrollContainer;
		/** The content to be expanded / collapsed. */
		public var panelContent:FeathersControl;
		
		
		
		// CONSTRUCTOR :
		/**
		 * Creates a new TogglePanel with the given parameters. The panelContent is added to a
		 * ScrollContainer with an AnchorLayout. By default, if panelContent.layoutData is not set,
		 * the panelContent will be sticked to 0 0 NaN (CSS-like description).
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
			
			// Content container :
			contentContainer = ControlFactory.getScrollContainer(ScrollContainer.SCROLL_POLICY_OFF, ScrollContainer.SCROLL_POLICY_OFF);
			contentContainer.height = 0;
			contentContainer.layout = new AnchorLayout();
			
			// Content :
			this.panelContent = panelContent;
			if(this.panelContent.layoutData == null)
				this.panelContent.layoutData = new AnchorLayoutData(0, 0, NaN, 0);
			panelContent.visible = false;
		}
		
		
		/**
		 * Adds the behavior to the content.
		 */
		override protected function initialize():void {
			super.initialize();
			
			// Layout :
			layout = ControlFactory.getVLayout(0, 0);
			
			// Behavior :
			panelJuggler = new Juggler();
			Starling.juggler.add(panelJuggler);
			headerBtn.addEventListener(Event.TRIGGERED, expandOrCollapseContent);
			
			// Display content :
			addChild(headerBtn);
			addChild(contentContainer);
			contentContainer.addChild(panelContent);
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
			};
			
			expandTween.onStart = onExpand;
			expandTween.onComplete = dispatchEventWith;
			expandTween.onCompleteArgs = [EXPAND_COMPLETE];
			
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
		
		
	}
}