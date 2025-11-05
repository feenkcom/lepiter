"
I am a target for LePage dropdown actions appearing in the hambuirger menu of a lepiter page.

To use me as a target, define an action as an extension method in LePage, with me as a `target:`.

For example:

```
gtONOpenInNewTabActionFor: anAction
	<gtAction>
	^ anAction button
		tooltip: 'Open page in a new world tab';
		target: LePageActionTarget;
		icon: BrGlamorousVectorIcons spawn;
		menuItemGroup: BrMenuItemGroupConfiguration inspection;
		action: [  :aButton | 
			BlSpace new
				pageInPager: self;
				withSceneDriller;
				showFrom: aButton ]
```
"
Class {
	#name : #LePageActionTarget,
	#superclass : #GtPhlowActionUniqueTarget,
	#category : #'Lepiter-UI-Action Targets'
}
