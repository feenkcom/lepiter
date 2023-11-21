Extension { #name : #LePage }

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
