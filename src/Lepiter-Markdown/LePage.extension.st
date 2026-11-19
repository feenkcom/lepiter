Extension { #name : #LePage }

{ #category : #'*Lepiter-Markdown' }
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
