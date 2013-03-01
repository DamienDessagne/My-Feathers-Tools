package controls.dialogs {
	import controls.factory.ControlFactory;
	
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayoutData;
	
	import starling.events.Event;
	
	/**
	 * A Dialog with a TextInput and Cancel / OK buttons.
	 */
	public class InputDialog extends Dialog {
		
		/** The displayed text input. */
		protected var textInput:TextInput;
		
		private var inputIsPassword:Boolean;
		private var inputIsEmail:Boolean;
		private var validateInput:Function;
		
		// CONSTRUCTOR :
		/**
		 * Creates a new dialog with an TextInput placed right after the message.
		 * @param message			the message above the TextInput
		 * @param title				the optionnal dialog title
		 * @param callback			function signature : <code>function(button:String, userInput:String):void</code>
		 * @param validateInput		used to validate user input on OK press.
		 * 							function signature : <code>function(textInput:TextInput):Boolean</code>
		 * @param inputIsPassword	to set the TextInput to displays as a password
		 * @param inputIsEmail		to set the TextInput to use email softKeyboard
		 */
		public function InputDialog(message:String, title:String = null,
									callback:Function = null, validateInput:Function = null,
									inputIsPassword:Boolean = false, inputIsEmail:Boolean = false) {
			super(message, title, [BTN_CANCEL, BTN_OK], callback);
			
			this.validateInput = validateInput;
			this.inputIsPassword = inputIsPassword;
			this.inputIsEmail = inputIsEmail;
		}
		
		
		override protected function initialize():void {
			super.initialize();
			
			// Add text input to the content :
			textInput = ControlFactory.getTextInput(inputIsEmail, inputIsPassword);
			
			textInput.layoutData = new AnchorLayoutData(10, 10, NaN, 10);
			(textInput.layoutData as AnchorLayoutData).topAnchorDisplayObject = messageLbl;
			(btnGroup.layoutData as AnchorLayoutData).topAnchorDisplayObject = textInput;
			
			addChild(textInput);
		}
		
		override protected function btnTriggered(ev:Event):void {
			var btn:Button = ev.target as Button;
			
			// Validate input :
			if(btn.label == BTN_OK && validateInput != null && !validateInput(textInput)) return;
			
			// Callback :
			if(callback != null) callback(btn.label, textInput.text);
			
			// Close dialog :
			PopUpManager.removePopUp(this);
		}
	}
}