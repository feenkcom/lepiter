Extension { #name : #LePage }

{ #category : #'*Lepiter-Zip-Archive' }
LePage >> gtAddActionFor: anAction [
	<lePageAction>
	
	"self isUnnamedPage 
		ifTrue: [ ^ anAction noAction ].
	(LeDatabasesRegistry new defaultLogicalDatabase hasPageNamed: self title) 
		ifTrue: [ ^ anAction noAction ]."

	^ anAction dropdown 
		tooltip: 'Add independent page into default database';
		icon: BrGlamorousVectorIcons add;
		content: [:aButton | (LePageAddDropdownContentStencil new
						page: self;
						anchor: aButton) ]
]

{ #category : #'*Lepiter-Zip-Archive' }
LePage >> gtZipArchiveExportActionFor: anAction [
	<gtAction>
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].

	^ anAction button
		label: 'ZIP';
		tooltip: 'Export the page into an independent external ZIP archive';
		priority: 10;
		icon: BrGlamorousVectorIcons spawn;
		action: [ :aButton | | output |
			output := LePageZipArchiveExporter new page: self; export.
			Clipboard clipboardText: output zipFile pathString.
			aButton phlow spawnObject: output ]
]
