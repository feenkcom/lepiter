Extension { #name : 'AbstractFileReference' }

{ #category : '*Lepiter-UI' }
AbstractFileReference >> gtInspectLepiterDatabaseFor: aView [
	<gtView>

	(LeRegisterDbDropdown isUnregisteredLepiterDb: self) ifFalse: [ ^ aView empty ].

	^ aView forward 
		title: 'Lepiter DB';
		priority: 80;
		object: [ LeLocalStoreLoad current loadAndMonitorFrom: self resolve ];
		view: #gtLiveFor:

]
