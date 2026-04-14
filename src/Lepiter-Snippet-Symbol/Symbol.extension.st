Extension { #name : #Symbol }

{ #category : #'*Lepiter-Snippet-Symbol' }
Symbol >> gtSymbolAnnotationBrowseImplementorsFor: anAction context: aPhlowContext [
	<gtAction>
	^ anAction button
		target: LeSymbolAnnotationActionTarget;
		priority: 20;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Browse implementors';
		menuItemPreview: [ self printString ];
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: self gtImplementors ]
]

{ #category : #'*Lepiter-Snippet-Symbol' }
Symbol >> gtSymbolAnnotationBrowsePragmasFor: anAction context: aPhlowContext [
	<gtAction>
	^ anAction button
		target: LeSymbolAnnotationActionTarget;
		priority: 22;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Browse pragmas';
		menuItemPreview: [ self printString ];
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: self gtPragmas ]
]

{ #category : #'*Lepiter-Snippet-Symbol' }
Symbol >> gtSymbolAnnotationBrowseRerencesFor: anAction context: aPhlowContext [
	<gtAction>
	^ anAction button
		target: LeSymbolAnnotationActionTarget;
		priority: 10;
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Browse references';
		menuItemPreview: [ self printString ];
		menuItemGroup: BrMenuItemGroupConfiguration navigation;
		action: [ :aButton | aButton phlow spawnObject: self gtReferences ]
]

{ #category : #'*Lepiter-Snippet-Symbol' }
Symbol >> gtSymbolAnnotationCopyFor: anAction context: aPhlowContext [
	<gtAction>
	^ anAction button
		target: LeSymbolAnnotationActionTarget;
		priority: 20;
		icon: BrGlamorousVectorIcons clipboard;
		tooltip: 'Copy';
		menuItemPreview: [ self printString ];
		menuItemGroup: BrMenuItemGroupConfiguration editing;
		action: [ :aButton | Clipboard clipboardText: self printString ]
]
