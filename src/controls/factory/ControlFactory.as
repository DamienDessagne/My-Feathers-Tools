package controls.factory {
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.layout.VerticalLayout;
	
	import flash.text.SoftKeyboardType;
	
	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	
	import starling.display.DisplayObject;
	
	/**
	 * A factory to ease Feathers controls creation.
	 */
	public class ControlFactory {
		private static const logger:ILogger = getLogger(ControlFactory);
		
		
		/**
		 * Returns a Label with the given text and 
		 */
		public static function getLabel(text:String, wordWrap:Boolean = false):Label {
			var l:Label = new Label();
			l.text = text;
			if(wordWrap) l.textRendererProperties.wordWrap = true;
			return l;
		}
		
		/**
		 * Returns a Button with the given label and alignment.
		 * @param label		obvious, no ?
		 * @param hAlign	the label's horizontal align. Defaults to Align.CENTER
		 * @param vAlign	the label's vertical align. Defaults to Align.MIDDLE
		 */
		public static function getButton(label:String, hAlign:String = null, vAlign:String = null):Button {
			var b:Button = new Button();
			b.label = label;
			b.horizontalAlign = hAlign == null ? Align.CENTER : hAlign;
			b.verticalAlign = vAlign == null ? Align.MIDDLE : vAlign;
			return b;
		}
		
		/**
		 * Returns a TextInput with the supplied parameters.
		 */
		public static function getTextInput(isEmail:Boolean = false, isPassword:Boolean = false, text:String = null):TextInput {
			var t:TextInput = new TextInput();
			if(isEmail) t.textEditorProperties.softKeyboardType = SoftKeyboardType.EMAIL;
			if(isPassword) t.textEditorProperties.displayAsPassword = true;
			if(text != null) t.text = text;
			return t;
		}
		
		/**
		 * Returns a ScrollContainer with the given scroll policy.
		 * @param hScrollPolicy	Defaults to ScrollContainer.SCROLL_POLICY_AUTO
		 * @param vScrollPolicy	Defaults to ScrollContainer.SCROLL_POLICY_AUTO
		 */
		public static function getScrollContainer(hScrollPolicy:String = null, vScrollPolicy:String = null):ScrollContainer
		{
			var sc:ScrollContainer = new ScrollContainer();
			sc.horizontalScrollPolicy = hScrollPolicy == null ? ScrollContainer.SCROLL_POLICY_AUTO : hScrollPolicy;
			sc.verticalScrollPolicy = vScrollPolicy == null ? ScrollContainer.SCROLL_POLICY_AUTO : vScrollPolicy;
			return sc;
		}
		
		/**
		 * Returns a Header with the given title, leftItems and rightItems.
		 */
		public static function getHeader(title:String, leftItems:Vector.<DisplayObject> = null, rightItems:Vector.<DisplayObject> = null):Header {
			var h:Header = new Header();
			h.title = title;
			h.leftItems = leftItems;
			h.rightItems = rightItems;
			return h;
		}
		
		/**
		 * Returns a VerticalLayout and sets his properties according to the supplied parameters
		 * @param gap				the gap for the layout
		 * @param padding			the padding of the layout. Can be a CSS-like String, or a Number
		 * @param hAlign			one of the Align constant for horizontal align. Defaults to Align.JUSTIFY
		 * @param vAlign			one of the Align constant for vertical align. Defaults to Align.TOP
		 */
		public static function getVLayout(gap:Number = 0, padding:* = null,
										  hAlign:String = null, vAlign:String = null):VerticalLayout
		{
			var vl:VerticalLayout = new VerticalLayout();
			vl.gap = gap;
			if(padding is Number) {
				vl.padding = padding as Number;
			}
			else {
				var paddings:Array = padding.toString().split(" ");
				var pl:int = paddings.length;
				switch(pl) {
					case 1:
						vl.padding = paddings[0];
						break;
					case 2:
						vl.paddingTop = vl.paddingBottom = paddings[0];
						vl.paddingLeft = vl.paddingRight = paddings[1];
						break;
					case 3:
						vl.paddingTop = paddings[0];
						vl.paddingLeft = vl.paddingRight = paddings[1];
						vl.paddingBottom = paddings[2];
						break;
					case 4:
						vl.paddingTop = paddings[0];
						vl.paddingRight = paddings[1];
						vl.paddingBottom = paddings[2];
						vl.paddingLeft = paddings[3];
						break;
				}
			}
			
			vl.horizontalAlign = hAlign == null ? Align.JUSTIFY : hAlign;
			vl.verticalAlign = vAlign == null ? Align.TOP : vAlign;
			
			return vl;
		}
	}
}