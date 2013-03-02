package screens {
	import controls.Accordion;
	import controls.HeadedScreen;
	import controls.TogglePanel;
	import controls.dialogs.Dialog;
	import controls.dialogs.InputDialog;
	import controls.dialogs.LoadingDialog;
	import controls.factory.Align;
	import controls.factory.ControlFactory;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	/**
	 * The code in here tries to demonstrate the use of most of the FeathersTools.
	 */
	public class HomeScreen extends HeadedScreen {
		
		// UI Components :
		private var dialogBtn:Button;
		private var inputDialogBtn:Button;
		private var loadingDialogBtn:Button;
		
		private var togglePanel1:TogglePanel;
		private var togglePanel2:TogglePanel;
		private var togglePanel3:TogglePanel;
		
		
		// CONSTRUCTOR :
		/**
		 * Inits the screen's basic properties.
		 */
		public function HomeScreen() {
			
			// Call the HeadedScreen constructor with your screen's basic parameters : 
			super(
				"My sample app", 		// -> screen's header title
				"FakeScreenID", 60,		// -> if you have a previous screen, give it his ID here, a BackButton leading to this screenID will be added automatically 
				20, 20,					// -> VerticalLayout params : gap, padding
				
				// Left and right sample items :
				new <DisplayObject>[ControlFactory.getButton("LeftBtn", Align.LEFT)],
				new <DisplayObject>[ControlFactory.getButton("RightBtn", Align.RIGHT)]
			);
		}
		
		
		/**
		 * Inits the screen's content and then add its behavior.
		 */
		override protected function initialize():void {
			super.initialize();
			
			initScreen();
			initBehavior();
		}
		
		
		/**
		 * Create the screen's content.
		 */
		private function initScreen():void {
			
			// Create content :
			dialogBtn = ControlFactory.getButton("Dialog");
			inputDialogBtn = ControlFactory.getButton("InputDialog");
			loadingDialogBtn = ControlFactory.getButton("LoadingDialog");
			
			togglePanel1 = new TogglePanel("My toggle panel 1", ControlFactory.getLabel("Some content ..."));
			
			togglePanel2 = new TogglePanel(
				ControlFactory.getButton("My second toggle panel", Align.RIGHT),
				ControlFactory.getLabel("Some other content ..."));
			
			var tp3Container:ScrollContainer = ControlFactory.getScrollContainer(ScrollContainer.SCROLL_POLICY_OFF, ScrollContainer.SCROLL_POLICY_OFF);
			tp3Container.layout = ControlFactory.getVLayout(10, "10 25");
			tp3Container.addChild(ControlFactory.getLabel("Here is a more elaborate TogglePanel sample content!", true));
			tp3Container.addChild(ControlFactory.getTextInput(false, true));
			tp3Container.addChild(ControlFactory.getButton("OK"));
			
			togglePanel3 = new TogglePanel("A more elaborate toggle panel", tp3Container);
			
			// Display content :
			addChild(ControlFactory.getLabel("controls.dialogs.* samples :"));
			addChild(dialogBtn);
			addChild(inputDialogBtn);
			addChild(loadingDialogBtn);
			addChild(togglePanel1);
			addChild(togglePanel2);
			addChild(togglePanel3);
		}
		
		/**
		 * Add components behavior.
		 */
		private function initBehavior():void {
			
			// Dialogs :
			dialogBtn.addEventListener(Event.TRIGGERED, showDialog);
			inputDialogBtn.addEventListener(Event.TRIGGERED, showInputDialog);
			loadingDialogBtn.addEventListener(Event.TRIGGERED, showLoadingDialog);
			
			
			// Accordion on toggle panels :
			Accordion.create(new <TogglePanel>[togglePanel1, togglePanel2, togglePanel3]);
			
		}
		
		
		//////////////////////////
		// COMPONENTS BEHAVIORS //
		//////////////////////////
		
		// DIALOG :
		private function showDialog(ev:Event):void {
			PopUpManager.addPopUp(
				new Dialog("This is the message part of the dialog", "My dialog title",
					[Dialog.BTN_CANCEL, Dialog.BTN_OK], dialogCallback)
			);
		}
		private function dialogCallback(button:String):void {
			trace(button == Dialog.BTN_CANCEL ? "Why did you cancel?" : "Ok!");
		}
		
		
		// INPUT DIALOG :
		private function showInputDialog(ev:Event):void {
			PopUpManager.addPopUp(
				new InputDialog("Enter an email :", "My input dialog",
					inputDialogCallback, validateInputDialogContent,
					false, true)
			);
		}
		
		private function validateInputDialogContent(textInput:TextInput):Boolean {
			if(!Boolean(textInput.text.match(/^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i))) {
				Callout.show(ControlFactory.getLabel("Enter a valid email address !"), textInput, Callout.DIRECTION_UP);
				return false;
			}
			return true;
		}
		
		private function inputDialogCallback(button:String, userInput:String):void {
			trace(button == Dialog.BTN_CANCEL ? "Why did you cancel?" : "You entered : " + userInput);
		}
		
		
		// LOADING DIALOG :
		private function showLoadingDialog(ev:Event):void {
			PopUpManager.addPopUp(LoadingDialog.instance);
			
			trace("Loading dialog will hide in 3 seconds ...");
			Starling.juggler.delayCall(
				function():void { PopUpManager.removePopUp(LoadingDialog.instance); },
				3);
		}
		
		
		/**
		 * Overrides BACK button's default behavior.
		 */
		override protected function backButtonTriggered(ev:Event=null):void {
			trace("There is no real previous screen, but this way, you can add some more behavior, or code your very own.");
		}
	}
}