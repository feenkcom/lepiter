Extension { #name : #LePage }

{ #category : #'*Lepiter-HTML' }
LePage >> gtHTMLLocalExportActionFor: anAction [
	<gtAction>
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].

	^ anAction button
		label: 'HTML';
		tooltip: 'Export the page into an HTML format and store locally';
		priority: 10;
		icon: BrGlamorousVectorIcons spawn;
		action: [ :aButton | 
			| tempDir output |
			tempDir := GtTemporaryDirectory new.
			output := LeHtmlPageExporter exportPage: self to: tempDir reference.
			output optionAt: GtTemporaryDirectory put: tempDir.
			aButton phlow spawnObject: output ]
]
