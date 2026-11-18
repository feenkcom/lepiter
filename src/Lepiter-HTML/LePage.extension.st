Extension { #name : #LePage }

{ #category : #'*Lepiter-HTML' }
LePage >> gtHTMLLocalExportActionFor: anAction [
	<gtAction>
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].

	^ anAction button
		label: 'Export as HTML';
		tooltip: 'Export the page into an HTML format and store locally';
		priority: 10;
		target: LePageActionTarget;
		icon: BrGlamorousVectorIcons save;
		action: [ :aButton | 
			| tempDir output |
			tempDir := GtTemporaryDirectory new.
			output := LeHtmlPageExporter exportPage: self to: tempDir reference.
			output optionAt: GtTemporaryDirectory put: tempDir.
			aButton phlow spawnObject: output ]
]

{ #category : #'*Lepiter-HTML' }
LePage >> gtMarkdownLocalExportActionFor: anAction [
	<gtAction>
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].

	^ anAction button
		label: 'Export as Markdown';
		tooltip: 'Export the page into a Markdown format and store locally';
		priority: 11;
		target: LePageActionTarget;
		icon: BrGlamorousVectorIcons save;
		action: [ :aButton | 
			| tempDir output |
			tempDir := GtTemporaryDirectory new.
			output := LeMarkdownPageExporter exportPage: self to: tempDir reference.
			output optionAt: GtTemporaryDirectory put: tempDir.
			aButton phlow spawnObject: output ]
]
