Extension { #name : 'AbstractFileReference' }

{ #category : '*Lepiter-Core' }
AbstractFileReference >> gtLepiterPageFor: aView [
	<gtView>

	(self isFile and: [ self extension = #lepiter ]) ifFalse: [ ^ aView empty ].
	^ aView forward 
		title: 'Lepiter Page';
		priority: 10;
		object: [ LeLocalStoreLoad current loadPageFrom: self ];
		view: #gtLiveFor:
]
