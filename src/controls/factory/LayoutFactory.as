package controls.factory {
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.ILayout;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	
	/**
	 * A factory to ease Feathers layouts creation.
	 */
	public class LayoutFactory {
		
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
			setGap(gap, vl);
			setPadding(padding, vl);
			
			vl.horizontalAlign = hAlign == null ? Align.JUSTIFY : hAlign;
			vl.verticalAlign = vAlign == null ? Align.TOP : vAlign;
			
			return vl;
		}
		
		/**
		 * Returns a HorizontalLayout and sets his properties according to the supplied parameters
		 * @param gap				the gap for the layout
		 * @param padding			the padding of the layout. Can be a CSS-like String, or a Number
		 * @param hAlign			one of the Align constant for horizontal align. Defaults to Align.LEFT
		 * @param vAlign			one of the Align constant for vertical align. Defaults to Align.TOP
		 */
		public static function getHLayout(gap:Number = 0, padding:* = null,
										  hAlign:String = null, vAlign:String = null):HorizontalLayout
		{
			var hl:HorizontalLayout = new HorizontalLayout();
			setGap(gap, hl);
			setPadding(padding, hl);
			
			hl.horizontalAlign = hAlign == null ? Align.LEFT : hAlign;
			hl.verticalAlign = vAlign == null ? Align.TOP : vAlign;
			
			return hl;
		}
		
		
		/**
		 * Returns a TiledRowsLayout and sets his properties according to the supplied parameters
		 * @param gap			the gap for the layout. Can be a Number for both horizontal and vertical,
		 * 						or a string (eg: "10 20" means 10 for horizontalGap and 20 for verticalGap)
		 * @param padding		the padding of the layout. Can be a CSS-like String, or a Number
		 * @param hAlign		one of the Align constant for horizontal align. Defaults to Align.LEFT
		 * @param vAlign		one of the Align constant for vertical align. Defaults to Align.TOP
		 * @param tileHAlign	the horizontal alignment of tile items. Defaults to Align.CENTER
		 * @param tileVAlign	the vertical alignment of tile items. Defaults to Align.TOP
		 */
		public static function getTiledRowsLayout(gap:* = null, padding:* = null,
												  hAlign:String = null, vAlign:String = null,
												  tileHAlign:String = null, tileVAlign:String = null):TiledRowsLayout
		{
			var trl:TiledRowsLayout = new TiledRowsLayout();
			setGap(gap, trl);
			setPadding(padding, trl);
			
			trl.horizontalAlign = hAlign == null ? Align.LEFT : hAlign;
			trl.verticalAlign = vAlign == null ? Align.TOP : vAlign;
			
			trl.tileHorizontalAlign = tileHAlign == null ? Align.CENTER : tileHAlign;
			trl.tileVerticalAlign = tileVAlign == null ? Align.TOP : tileVAlign;
			
			return trl;
		}
		
		/**
		 * Returns a HorizontalLayout and sets his properties according to the supplied parameters
		 * @param gap			the gap for the layout. Can be a Number for both horizontal and vertical,
		 * 						or a string (eg: "10 20" means 10 for horizontalGap and 20 for verticalGap)
		 * @param padding		the padding of the layout. Can be a CSS-like String, or a Number
		 * @param hAlign		one of the Align constant for horizontal align. Defaults to Align.LEFT
		 * @param vAlign		one of the Align constant for vertical align. Defaults to Align.TOP
		 * @param tileHAlign	the horizontal alignment of tile items. Defaults to Align.CENTER
		 * @param tileVAlign	the vertical alignment of tile items. Defaults to Align.TOP
		 */
		public static function getTiledColsLayout(gap:* = null, padding:* = null,
												  hAlign:String = null, vAlign:String = null,
												  tileHAlign:String = null, tileVAlign:String = null):TiledColumnsLayout
		{
			var tcl:TiledColumnsLayout = new TiledColumnsLayout();
			setGap(gap, tcl);
			setPadding(padding, tcl);
			
			tcl.horizontalAlign = hAlign == null ? Align.LEFT : hAlign;
			tcl.verticalAlign = vAlign == null ? Align.TOP : vAlign;
			
			tcl.tileHorizontalAlign = tileHAlign == null ? Align.CENTER : tileHAlign;
			tcl.tileVerticalAlign = tileVAlign == null ? Align.TOP : tileVAlign;
			
			return tcl;
		}
		
		
		/**
		 * Returns an AnchorLayoutData object with the given properties set. All unknown properties will be ignored.
		 * @param properties	an object containing all properties to set on the AnchorLayoutData object.
		 */
		public static function getAnchorLayoutData(properties:Object):AnchorLayoutData {
			var ld:AnchorLayoutData = new AnchorLayoutData();
			for(var propertyName:String in properties) {
				if(!ld.hasOwnProperty(propertyName)) continue;
				ld[propertyName] = properties[propertyName];
			}
			return ld;
		}
		
		
		/**
		 * Computes CSS-like paddings into [paddingTop, paddingRight, paddingBottom, paddingLeft] array and sets 
		 * them in the given layout. 
		 * @param padding	the padding to process. Can be a CSS-like String, or a Number
		 * @param layout	the layout to modify
		 */
		public static function setPadding(padding:*, layout:ILayout):void {
			if(padding == null) return;
			
			var paddings:Array = [];
			
			// A number = same padding everywhere :
			if(padding is Number) { 
				paddings = [padding, padding, padding, padding];
			}
			
			// A string, process it CSS-style :
			else {
				var inputPaddings:Array = padding.toString().split(" ");
				var pl:int = inputPaddings.length;
				switch(pl) {
					case 1:
						paddings[0] = paddings[1] = paddings[2] = paddings[3] = inputPaddings[0];
						break;
					case 2:
						paddings[0] = paddings[2] = inputPaddings[0];
						paddings[3] = paddings[1] = inputPaddings[1];
						break;
					case 3:
						paddings[0] = inputPaddings[0];
						paddings[3] = paddings[1] = inputPaddings[1];
						paddings[2] = inputPaddings[2];
						break;
					case 4:
						paddings[0] = inputPaddings[0];
						paddings[1] = inputPaddings[1];
						paddings[2] = inputPaddings[2];
						paddings[3] = inputPaddings[3];
						break;
				}
			}
			
			layout["paddingTop"] = paddings[0];
			layout["paddingRight"] = paddings[1];
			layout["paddingBottom"] = paddings[2];
			layout["paddingLeft"] = paddings[3];
		}
		
		
		/**
		 * Computes a gap (Number or String) and sets layout's gap accordingly.
		 * @param gap		the gap for the layout. Can be a Number for both horizontal and vertical,
		 * 					or a string (eg: "10 20" means 10 for horizontalGap and 20 for verticalGap)
		 * @param layout	the layout to modify
		 */
		public static function setGap(gap:*, layout:ILayout):void {
			if(gap == null) return;
			if(gap is Number) {
				layout["gap"] = gap;
				return
			}
			
			try {
				var gaps:Array = gap.toString().split(" ");
				layout["horizontalGap"] = gaps[0]; 
				layout["verticalGap"] = gaps[1];
			}
			catch(e:Error) {}
		}
	}
}