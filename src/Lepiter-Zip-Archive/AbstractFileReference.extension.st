Extension { #name : #AbstractFileReference }

{ #category : #'*Lepiter-Zip-Archive' }
AbstractFileReference >> gtLepiterZipArchivePageFor: aView [
	<gtView>

	(self isFile and: [ self basename endsWith: '.lepiter.zip' ]) ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Lepiter archive page';
		priority: 9;
		object: [ LePageZipArchiveImporter new file: self; import ];
		view: #gtPageFor:
]
