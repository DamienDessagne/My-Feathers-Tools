package controls {
	import controls.factory.ControlFactory;
	import controls.factory.LayoutFactory;
	
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.events.FeathersEventType;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	/**
	 * A basic screen with a header and a VerticalLayout, based on a PanelScreen.
	 * Handles back button automatically. If you want to add back button behavior,
	 * you can override <code>backButtonTriggered()</code>.
	 */
	public class HeadedScreen extends PanelScreen {
		
		/** The optionnal Back button, in the header's leftItems. */
		public var backButton:Button;
		
		private var _previousScreenID:String;
		/** The previous screen ID. */
		public function get previousScreenID():String { return _previousScreenID; }
		public function set previousScreenID(value:String):void {
			_previousScreenID = value;
			backButton.visible = _previousScreenID != null;
		}
		
		/** The screenData to be passed to the previousScreen on BACK button press. */
		public var previousScreenData:Object;
		
		
		// CONSTRUCTOR :
		/**
		 * Creates a new HeadedScreen with the given parameters. The "Back" button is automatically added if
		 * a <code>previousScreenID</code> is supplied.
		 */
		public function HeadedScreen(headerTitle:String,
									 previousScreenID:String = null,
									 headerHeight:Number = 50,
									 layoutPadding:Number = 15, layoutGap:Number = 15,
									 headerLeftItems:Vector.<DisplayObject> = null,
									 headerRightItems:Vector.<DisplayObject> = null)
		{
			super();
			
			// Header :
			this.headerProperties.title = headerTitle;
			this.headerProperties.height = headerHeight;
			
			// Left items :
			var leftItems:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			
			if(previousScreenID != null) { // -> add back button.
				this.backButton = ControlFactory.getButton("Back");
				this.backButton.nameList.add(Button.ALTERNATE_NAME_BACK_BUTTON);
				leftItems.push(backButton);
				this.previousScreenID = previousScreenID;
			}
			
			if(headerLeftItems != null) // -> add other items
				leftItems = leftItems.concat(headerLeftItems);
			
			this.headerProperties.leftItems = leftItems;
			
			if(headerRightItems != null)
				this.headerProperties.rightItems = headerRightItems;
			
			// Layout :
			layout = LayoutFactory.getVLayout(layoutGap, layoutPadding);
		}
		
		
		/**
		 * Inits the screen's essential display for transitionning. The behavior and deeper screen's content creation should
		 * be put in transitionComplete().
		 */
		override protected function initialize():void {
			super.initialize();
			
			// Behavior :
			if(previousScreenID != null) {
				this.backButton.addEventListener(Event.TRIGGERED, backButtonTriggered);
				this.backButtonHandler = backButtonTriggered;
			}
			
			// Delay call to deeper initializing of the screen to after transition :
			addEventListener(FeathersEventType.TRANSITION_COMPLETE, onTransitionComplete);
		}
		
		/**
		 * Simply calls the protected transitionComplete() method, for subclasses not to bother with events.
		 */
		private function onTransitionComplete(ev:Event):void {
			removeEventListener(FeathersEventType.TRANSITION_COMPLETE, onTransitionComplete);
			transitionComplete();
		}
		
		/**
		 * Called once the screen's transition in is complete.
		 * Typically, you want to create invisible content and  add your screen's behavior in here. 
		 */
		protected function transitionComplete():void {
			
		}
		
		
		/**
		 * The back button (including hardware BACK button) handler.
		 * If a <code>previousScreenID</code> is supplied, switches to that previous screen.
		 */
		protected function backButtonTriggered(ev:Event = null):void {
			if(previousScreenID == null)
				return;
			
			owner.getScreen(previousScreenID).properties = previousScreenData;
			owner.showScreen(previousScreenID);
			owner.getScreen(previousScreenID).properties = null;
		}
	}
}