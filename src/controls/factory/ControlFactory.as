package controls.factory {
	import controls.AnchorGroup;
	import controls.HGroup;
	import controls.VGroup;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	import flash.text.SoftKeyboardType;
	
	import starling.display.DisplayObject;
	
	/**
	 * A factory to ease Feathers controls creation.
	 */
	public class ControlFactory {
		
		
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
		 * Returns a ProgressBar with the given values.
		 * @param min	the progressbar's minimum value
		 * @param max	the progressbar's maximum value
		 * @param value	the progressbar's progress value
		 */
		public static function getProgressBar(min:Number = 0, max:Number = 100, value:Number = 0):ProgressBar {
			var pb:ProgressBar = new ProgressBar();
			pb.minimum = min;
			pb.maximum = max;
			pb.value = value;
			return pb;
		}
		
		/**
		 * Returns a HGroup with the given content.
		 * @param content	the content to be added to the HGroup
		 * @param gap		the gap of the HGroup
		 * @param padding	a Number, or a CSS-like padding String.
		 * @param hAlign	one of the Align constant for horizontal align. Defaults to Align.LEFT
		 * @param vAlign	one of the Align constant for vertical align. Defaults to Align.TOP
		 */
		public static function getHGroup(content:Vector.<DisplayObject>, gap:Number = 0, padding:* = null,
										 hAlign:String = null, vAlign:String = null):HGroup
		{
			var group:HGroup = new HGroup();
			LayoutFactory.setGap(gap, group.layout);
			LayoutFactory.setPadding(padding, group.layout);
			group.layout["horizontalAlign"] = hAlign == null ? Align.LEFT : hAlign;
			group.layout["verticalAlign"] = vAlign == null ? Align.TOP : vAlign;
			
			for each(var displayObject:DisplayObject in content) {
				group.addChild(displayObject);
			}
			
			return group;
		}
		
		/**
		 * Returns a VGroup with the given content.
		 * @param content	the content to be added to the HGroup
		 * @param gap		the gap of the HGroup
		 * @param padding	a Number, or a CSS-like padding String.
		 * @param hAlign	one of the Align constant for horizontal align. Defaults to Align.JUSTIFY
		 * @param vAlign	one of the Align constant for vertical align. Defaults to Align.TOP
		 */
		public static function getVGroup(content:Vector.<DisplayObject>, gap:Number = 0, padding:* = null,
										 hAlign:String = null, vAlign:String = null):VGroup
		{
			var group:VGroup = new VGroup();
			LayoutFactory.setGap(gap, group.layout);
			LayoutFactory.setPadding(padding, group.layout);
			group.layout["horizontalAlign"] = hAlign == null ? Align.JUSTIFY : hAlign;
			group.layout["verticalAlign"] = vAlign == null ? Align.TOP : vAlign;
			
			for each(var displayObject:DisplayObject in content) {
				group.addChild(displayObject);
			}
			
			return group;
		}
		
		/**
		 * Creates an AnchorGroup with the given data.
		 * @param content			an array of objects, each describing a content to be added to the group and its anchorLayoutData properties.
		 * 							Each object must have a <code>content</code> property with a reference to the FeathersControl to add to the group.
		 * 							For example :<br>
		 * 							<code>[{content:ControlFactory.getButton("MyButton"), top:10, left:10, right:10},
	 	 * 								   {content:ControlFactory.getLabel("MyLabel"), horizontalCenter:0}]</code>
		 * @param groupLayoutData	an object containing all properties of AnchorLayoutData to set on the group.
		 */
		public static function getAnchorGroup(content:Vector.<Object>, groupLayoutData:Object = null):AnchorGroup {
			var group:AnchorGroup = new AnchorGroup();
			var propertyName:String;
			
			// Add group's anchor layout data :
			if(groupLayoutData) {
				for(propertyName in groupLayoutData) {
					if(!group.anchorLayoutData.hasOwnProperty(propertyName)) continue;
					group.anchorLayoutData[propertyName] = groupLayoutData[propertyName];
				}
			}
			
			// Add content with its layout data to the group :
			for each(var contentDesc:Object in content) {
				if(!contentDesc.hasOwnProperty("content")) continue;
				var control:FeathersControl = contentDesc["content"] as FeathersControl;
				control.layoutData = LayoutFactory.getAnchorLayoutData(contentDesc);
				group.addChild(control);
			}
			
			return group;
		}
	}
}