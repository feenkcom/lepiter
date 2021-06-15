Class {
	#name : #LeLocalSyncErrorStatus,
	#superclass : #LeLocalSyncMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #'gt-extensions' }
LeLocalSyncErrorStatus >> gtViewCorruptFilesFor: aView [
	<gtView>
	^ aView forward
		title: 'Corrupt files';
		priority: 5;
		object: [ self database ];
		view: #gtViewCorruptFilesFor:
]

{ #category : #testing }
LeLocalSyncErrorStatus >> isErrorStatus [
	^ true
]

{ #category : #accessing }
LeLocalSyncErrorStatus >> statusColor [
	^ Color red
]

{ #category : #accessing }
LeLocalSyncErrorStatus >> statusIcon [
	^ BrGlamorousIcons redcircle
]

{ #category : #'gt-extensions' }
LeLocalSyncErrorStatus >> statusWidget [
	| container |
	container := super statusWidget.
	container addChild: (BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousIcons inspect;
		label: 'View status';
		margin: (BlInsets left: 5);
		action: [ :aButtonElement |
			GtWorldUtility 
				showSpaceWithTitle: self 
				with: (GtInspector createOn: self) maximized
				from: aButtonElement.
			aButtonElement fireEvent: BrDropdownHideWish new ]).
	^ container
]
