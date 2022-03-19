Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-UI' }
LeDatabase >> asContentUIModel [
	<return: #LeContentViewModel>
	
	^ LeDatabaseViewModel new database: self
]

{ #category : #'*Lepiter-UI' }
LeDatabase >> asPhlowTool [
	^ GtPhlowCompositeTool new
		addTool: (LeDatabaseTool database: self);
		addTool: (GtPhlowTool default object: self)
]

{ #category : #'*Lepiter-UI' }
LeDatabase >> asToolElement [
	^ LeDatabaseToolElement new
		margin: (BlInsets all: 10);
		databaseViewModel: self asContentUIModel;
		matchParent
]

{ #category : #'*Lepiter-UI' }
LeDatabase >> gtLiveFor: aView [
	<gtView>
	self pagesByName ifEmpty: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self asContentUIModel ];
		view: #gtLiveFor:
]
