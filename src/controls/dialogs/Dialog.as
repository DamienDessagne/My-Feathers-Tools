package controls.dialogs {
	import controls.factory.ControlFactory;
	
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.events.Event;
	
	
	/**
	 * A simple dialog with a Title, a content and a buttonGroup at the bottom.
	 * By default, only a label with the given message is displayed.
	 */
	public class Dialog extends ScrollContainer {
		
		// Buttons constants :
		/** An OK button. */
		public static const BTN_OK:String = "OK";
		/** A CANCEL button. */
		public static const BTN_CANCEL:String = "Cancel";
		/** A YES button. */
		public static const BTN_YES:String = "Yes";
		/** A NO button. */
		public static const BTN_NO:String = "No";
		
		
		/** The default buttons of the panel (OK button only). */
		public static const BTN_DEFAULT:String = BTN_OK;
		
		
		// Dialog properties :
		/** The title label. */
		protected var title:String;
		/** The <code>content</code>'s label content. */
		protected var message:String;
		/** An array of button's labels. */
		protected var buttons:Array;
		/** The buttons callback. */
		protected var callback:Function;
		
		
		// Dialog components :
		/** The header created if a title is supplied. */
		protected var header:Header;
		/** The basic label of the <code>content</code>. */
		protected var messageLbl:Label;
		/** The buttons at the bottom of the Dialog. */
		protected var btnGroup:ButtonGroup;
		
		
		// CONSTRUCTOR :
		/**
		 * Creates a new Dialog with the given messsage and buttons. Title is optionnal.
		 * @param message	the message to display
		 * @param title		the title of the dialog
		 * @param buttons	an array of button labels. You can use BTN_* constants for classic buttons or supply yours directly.
		 * 					If ommited, BTN_DEFAULT is used.
		 * @param callback	the callback called when dialog is closed. function signature : function(button:String):void
		 */
		public function Dialog(message:String, title:String = null, buttons:Array = null, callback:Function = null) {
			super();
			
			this.message = message;
			this.title = title;
			this.buttons = buttons ? buttons : [BTN_DEFAULT];
			this.callback = callback;
			
			// TODO : remove, place in the Theme class
			// Add a background :
			backgroundSkin = new Quad(10, 10, 0x999999);
		}
		
		/**
		 * Creates the Dialog's content.
		 */
		override protected function initialize():void {
			
			this.width = Starling.current.stage.width * .8;
			
			// Title :
			if(title) {
				header = ControlFactory.getHeader(title);
				// TODO : remove, place in the Theme class
				header.backgroundSkin = new Quad(10, 10, 0x333333); 
			}
			
			// Message :
			messageLbl = ControlFactory.getLabel(message, true);
			
			// Buttons :
			var buttonsList:Array = new Array();
			for(var i:int = 0 ; i < buttons.length ; i++) {
				buttonsList.push({label:buttons[i], triggered:btnTriggered});
			}
			
			btnGroup = new ButtonGroup();
			btnGroup.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			btnGroup.gap = btnGroup.firstGap = btnGroup.lastGap = 0;
			btnGroup.dataProvider = new ListCollection(buttonsList);
			
			
			// Layout :
			this.layout = new AnchorLayout();
			this.horizontalScrollPolicy = this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			
			var mld:AnchorLayoutData = new AnchorLayoutData(10, 10, NaN, 10);
			if(title) {
				header.layoutData = new AnchorLayoutData(0, 0, NaN, 0);
				mld.topAnchorDisplayObject = header;
			}
			messageLbl.layoutData = mld;
			
			var bgld:AnchorLayoutData = new AnchorLayoutData(10, 0, NaN, 0);
			bgld.topAnchorDisplayObject = messageLbl;
			// TODO : BUTTON GROUP ANCHOR LAYOUT BUG FIX :
			bgld.right = buttons.length > 2 ? 0 : 18 / buttons.length; 
			
			btnGroup.layoutData = bgld;
			
			// Display content :
			if(title) addChild(header);
			addChild(messageLbl);
			addChild(btnGroup);
		}
		
		/**
		 * Called when a button has been triggered.
		 */
		protected function btnTriggered(ev:Event):void {
			var btn:Button = ev.currentTarget as Button;
			if(callback != null) callback(btn.label);
			
			// Close Dialog :
			PopUpManager.removePopUp(this);
		}
		
	}
}