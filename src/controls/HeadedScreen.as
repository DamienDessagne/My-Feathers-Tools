package controls {
	import controls.factory.ControlFactory;
	
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	/**
	 * A basic screen with a header and a VerticalLayout, based on a PanelScreen.
	 * Handles back button automatically. If you want to add back button behavior,
	 * you can override <code>backButtonTriggered()</code>.
	 */
	public class HeadedScreen extends PanelScreen {
		
		// UI ELEMENTS :
		/** The optionnal Back button, in the header's leftItems. */
		protected var backButton:Button;
		
		/** The previous screen ID. */
		protected var previousScreenID:String;
		
		
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
				this.previousScreenID = previousScreenID;
				this.backButton = ControlFactory.getButton("Back");
				this.backButton.nameList.add(Button.ALTERNATE_NAME_BACK_BUTTON);
				leftItems.push(backButton);
			}
			
			if(headerLeftItems != null) // -> add other items
				leftItems = leftItems.concat(headerLeftItems);
			
			this.headerProperties.leftItems = leftItems;
			
			if(headerRightItems != null)
				this.headerProperties.rightItems = headerRightItems;
			
			// Layout :
			layout = ControlFactory.getVLayout(layoutGap, layoutPadding);
		}
		
		
		/**
		 * Inits the screen behavior.
		 */
		override protected function initialize():void {
			super.initialize();
			
			// Behavior :
			if(previousScreenID != null) {
				this.backButton.addEventListener(starling.events.Event.TRIGGERED, backButtonTriggered);
				this.backButtonHandler = backButtonTriggered;
			}
		}
		
		
		/**
		 * The back button (including hardware BACK button) handler.
		 * If a <code>previousScreenID</code> is supplied, switches to that previous screen.
		 */
		protected function backButtonTriggered(ev:starling.events.Event = null):void {
			if(previousScreenID == null)
				return;
			
			GameScreens.goto(previousScreenID);
		}
	}
}