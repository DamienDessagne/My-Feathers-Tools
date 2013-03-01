package controls {
	import starling.events.Event;
	
	
	/**
	 * Provides an accordion behavior to a list of ExpandablePanels : only one expanded 
	 * panel at a time.
	 * Simply call create() with the list of expandable panels to apply the behavior to.
	 */
	public class Accordion {
		
		/**
		 * Creates a new Accordion effect for the given collection of ExapandablePanels.
		 */
		public static function create(content:Vector.<TogglePanel>):void {
			
			// Callback for panel expand :
			var collapseAllOthers:Function = function(ev:Event):void {
				var ep:TogglePanel = ev.target as TogglePanel;
				var otherEP:TogglePanel;
				for each(otherEP in content) {
					if(otherEP == ep) continue;
					if(otherEP.isExpanded) otherEP.collapse();
				}
			};
			
			// Add behavior :
			var ep:TogglePanel;
			for each(ep in content) {
				ep.addEventListener(TogglePanel.EXPAND_BEGIN, collapseAllOthers);
			}
		}
	}
}