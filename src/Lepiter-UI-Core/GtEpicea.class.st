Class {
	#name : #GtEpicea,
	#superclass : #Object,
	#traits : 'TBlDebug + TLepiterConstants + TGtAnnouncer',
	#classTraits : 'TBlDebug classTrait + TLepiterConstants classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'epiceaLog',
		'events',
		'diff',
		'applyErrorHandler',
		'impacted',
		'previousNumberOfEvents'
	],
	#classVars : [
		'DebugMode'
	],
	#category : #'Lepiter-UI-Core-Epicea'
}

{ #category : #accessing }
GtEpicea class >> allInSessionStore [
	<script>
	| monitor directory currentGlobalName |
	monitor := EpMonitor current.
	directory := monitor sessionStore baseLocator.
	currentGlobalName := monitor sessionStore store globalName.
	^ (EpFileLogNode fromAllLogsIn: directory)
		sort: [ :a :b | a modificationTime >= b modificationTime ];
		collect: [ :n | 
			| node |
			node := n globalName = currentGlobalName
				ifTrue: [ EpMonitorLogNode for: monitor ]
				ifFalse: [ n ].
			self new
				log: node log;
				yourself ]
]

{ #category : #accessing }
GtEpicea class >> constants [
	^ LepiterConstants
]

{ #category : #modification }
GtEpicea >> addEvent: anEpEvent [
	self log addEntryWith: anEpEvent tags: [ :tags | "ignore" ].
	self log store flush.
]

{ #category : #accessing }
GtEpicea >> announcer [
	^ announcer
]

{ #category : #modification }
GtEpicea >> applyChanges [
	self 
		assert: [ self log notNil ] 
		description: [ 'Epicea log must be non-nil.' ].
	self hasChanges ifFalse: [ ^ self ].
	EpLogBrowserOperationFactory new
		logBrowserModel: self log;
		entries: self entries;
		errorHandlerBlock: applyErrorHandler;
		applyCodeChanges.
	self notifyEpiceaChanged.
]

{ #category : #private }
GtEpicea >> computeImpact [
	"Return true if impact changed"

	<return: #Boolean>
	| oldImpacted changed |
	oldImpacted := impacted.
	impacted := self events
		select: [ :eachEvent | 
			eachEvent isCodeChange
				ifTrue: [ eachEvent
						accept: (EpHasImpactVisitor inEnvironment: self theEnvironment) ]
				ifFalse: [ false ] ].
	changed := impacted ~= oldImpacted.
	changed
		ifTrue: [ diff := nil ].
	^ changed
]

{ #category : #accessing }
GtEpicea >> constants [
	^ LepiterConstants
]

{ #category : #accessing }
GtEpicea >> diff [
	<return: #BlRope>
	^ diff ifNil: [ 
			diff := self hasImpact 
				ifTrue: [ 
					GtEpiceaDiffStencil new
						from: self systemState;
						to: self tutorialState;
						create ]
				ifFalse: [ '"No changes comparing to current system state"' asRopedText 
						glamorousCodeFontAndSize;
						foreground: self constants subtleColor ] ]
]

{ #category : #'gt-extension' }
GtEpicea >> diffElements [
	| elements |
	elements := OrderedCollection new.
	self events
		do: [ :each | 
			| previous builder new element |
			previous := each
				accept:
					((GtEpiceaCurrentStateVisitor inEnvironment: self class environment)
						showClassNameInMethodSource: false).
			new := each accept: EpNewStateVisitor new.
			previous = new
				ifFalse: [ builder := (GtEpiceaDiffBuilder from: previous to: new)
						isMethod: (each isKindOf: EpMethodChange).
					element := BrVerticalPane new.
					element margin: (BlInsets all: 3).
					element hMatchParent.
					element vFitContent.
					element
						addChild: ((GtEpiceaDiffElement on: builder) aptitude: GtDiffFlatAptitude) vFitContent beSmallSize.
					element
						addChild:
							(BrButton new
								aptitude: BrGlamorousButtonWithIconAptitude;
								icon: BrGlamorousVectorIcons accept;
								label: 'Accept';
								margin:
									(BlInsets
										top: 0
										left: 5
										bottom: 5
										right: 0);
								action: [ each applyCodeChange ]).
					element addAptitude: (BrShadowAptitude new width: 1).
					elements add: element ] ].
	^ elements
]

{ #category : #accessing }
GtEpicea >> entries [
	<return: #OrderedeCollection of: #OmEntry>
	^ self log entries
]

{ #category : #accessing }
GtEpicea >> events [
	<return: #OrderedeCollection of: #EpEvent>
	^ events
]

{ #category : #'gt-extension' }
GtEpicea >> gtDiffFor: aView [
	"<gtView>
	<gtViewChanges>"
	^ aView textEditor
		title: 'Diff';
		priority: 1;
		aptitude: BrGlamorousCodeEditorAptitude;
		updateWhen: GtEpiceaUpdatedAnnouncement in: self;
		text: [ :anEditor | self diff ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtDiffsFor: aView [

	<gtView>
	<gtViewChanges>
	self hasChanges ifFalse: [ ^ aView empty ].

	^ aView explicit
		  title: 'Diff';
		  priority: 1;
		  updateWhen: GtEpiceaUpdatedAnnouncement in: self;
		  actionUpdateButton;
		  actionButtonIcon: BrGlamorousVectorIcons accept
		  tooltip: 'Apply changes'
		  action: [ self applyChanges ];
		  stencil: [ 
			  | element headerElement label diffElement |
			  element := BrVerticalPane new.
			  element matchParent.
			  headerElement := BrHorizontalPane new
				                   padding: (BlInsets all: 0);
				                   hMatchParent;
				                   vFitContent.
			  label := BrLabel new aptitude: BrGlamorousLabelAptitude.
			  label text:
				  ('Current:' asRopedText glamorousCodeSmallSize foreground:
					   BrGlamorousColors defaultButtonTextColor).
			  label margin: (BlInsets left: 15).
			  label hMatchParent.
			  headerElement addChild: label.
			  headerElement addChild: (BlElement new
					   height: 0;
					   width: 15;
					   yourself).
			  label := BrLabel new aptitude: BrGlamorousLabelAptitude.
			  label text:
				  ('Change:' asRopedText glamorousCodeSmallSize foreground:
					   BrGlamorousColors defaultButtonTextColor).
			  label hMatchParent.
			  headerElement addChild: label.
			  element addChild: headerElement.
			  diffElement := BrVerticalPane new.
			  diffElement hMatchParent.
			  diffElement vFitContent.
			  diffElement addChildren: self diffElements.
			  element addChild: diffElement asScrollableElement.
			  element ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtEventsFor: aView [

	<gtView>
	self hasChanges ifFalse: [ ^ aView empty ].

	^ aView explicit
		  title: 'Change List';
		  priority: 3;
		  stencil: [ 
			  | aList |
			  aList := BrColumnedList new itemsProvider:
					           (BrListStreamItemsProvider forCollection: self events).
			  aList addEventHandler: GtPhlowListToSelectHandler new.
			  aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			  self announcer
				  when: GtEpiceaUpdatedAnnouncement
				  do: [ :anAnnouncement | aList items: self events ].
			  aList column
				  title: 'Icon';
				  width: 16;
				  stencil: [ :anEpEvent :anIndex | 
					  (anEpEvent accept: EpIconVisitor new) asElement ].
			  aList column
				  title: 'Description';
				  stencil: [ :anEpEvent :anIndex | 
					  | aRemoveButton aContainer |
					  aRemoveButton := BrButton new.
					  aRemoveButton
						  layout: BlLinearLayout new;
						  aptitude: BrGlamorousButtonWithIconAptitude;
						  icon: (BlElement new
								   layout: BlLinearLayout new;
								   background: Color lightGray;
								   size: 10 @ 3);
						  action: [ 
							  self removeEvent: anEpEvent.
							  aRemoveButton enqueueTask: (BlTaskAction new action: [ 
									   aRemoveButton visibility: BlVisibility hidden ]) ];
						  visibility: BlVisibility hidden.
					  aContainer := BlElement new
						                layout: BlLinearLayout horizontal;
						                addChildren:
							                (anEpEvent accept: GtEpiceaBrickVisitor new);
						                addChild: aRemoveButton;
						                constraintsDo: [ :c | 
							                c horizontal fitContent.
							                c vertical fitContent ].
					  aContainer
						  when: BlMouseEnterEvent
						  do: [ :anEvent | 
						  aRemoveButton visibility: BlVisibility visible ].
					  aContainer
						  when: BlMouseLeaveEvent
						  do: [ :anEvent | 
						  aRemoveButton visibility: BlVisibility hidden ].
					  aContainer ].
			  aList ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtGlobalEntriesIn: aView [
	<gtView>
	^ aView explicit
		title: 'Global Changes';
		priority: 20;
		stencil: [ | aList aGlobalLog |
			aGlobalLog := EpMonitor current log entries reversed.
			aList := BrColumnedList new items: aGlobalLog.
			aList addEventHandler: GtPhlowListToSelectHandler new.
			aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			aList column
				title: 'Icon';
				width: 16;
				stencil:
						[ :anOmEntry :anIndex | (anOmEntry content accept: EpIconVisitor new) asElement ].
			aList column
				title: 'Description';
				stencil: [ :anOmEntry :anIndex | 
					| anAddButton aContainer |
					anAddButton := BrButton new.
					anAddButton
						layout: BlLinearLayout new;
						aptitude: BrGlamorousButtonWithIconAptitude;
						icon: GtInspectorPlusIconStencil new asElement;
						action: [ self addEvent: anOmEntry content.
							anAddButton
								enqueueTask:
									(BlTaskAction new
										action: [ anAddButton visibility: BlVisibility hidden ]) ];
						visibility: BlVisibility hidden.
					aContainer := BlElement new
						layout: BlLinearLayout horizontal;
						addChildren: (anOmEntry content accept: GtEpiceaBrickVisitor new);
						addChild: anAddButton;
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent.
							c linear vertical alignCenter ].
					aContainer
						when: BlMouseEnterEvent
						do: [ :anEvent | anAddButton visibility: BlVisibility visible ].
					aContainer
						when: BlMouseLeaveEvent
						do: [ :anEvent | anAddButton visibility: BlVisibility hidden ].
					aContainer ].
			aList ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtPreviewFor: aView [
	^ aView composite
		title: 'Document Preview';
		priority: 50;
		collectorDo: [ :aCollector |
			aCollector 
				pragmaName: #gtViewChanges;
				fromObject: self ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtTutorialFor: aView [

	<gtView>
	<gtViewChanges>
	| code |
	code := self tutorialStateRope.

	code ifEmpty: [ ^ aView empty ].

	^ aView textEditor
		  title: 'Code';
		  priority: 0;
		  aptitude: BrGlamorousCodeEditorAptitude;
		  updateWhen: GtEpiceaUpdatedAnnouncement in: self;
		  actionUpdateButton;
		  actionButtonIcon: BrGlamorousVectorIcons accept
		  tooltip: 'Apply changes'
		  action: [ self applyChanges ];
		  text: [ :anEditor | code ]
]

{ #category : #'announcement handling' }
GtEpicea >> handleEpEntryAddedAnnouncement: anEpEntryAdded [
	self privateAddEvent: anEpEntryAdded entry content.
	self notifyEpiceaChanged.
]

{ #category : #testing }
GtEpicea >> hasChanges [
	<return: #Boolean>
	^ self numberOfEvents isZero not
]

{ #category : #accessing }
GtEpicea >> hasImpact [
	"Return true, if changes have impact to the current system state"
	<return: #Boolean>
	^ impacted notEmpty
]

{ #category : #initialization }
GtEpicea >> initialize [
	super initialize.
	announcer := Announcer new.
	impacted := OrderedCollection new.
	previousNumberOfEvents := 0.
	applyErrorHandler := [ :anException | | message |
		DebugMode ifTrue: [ anException pass ].
		message := 'Error while applying Epicea changes: ' , anException asString.
		message traceCr.
		self inform: message ].
]

{ #category : #accessing }
GtEpicea >> log [
	<return: #EpLog>
	^ epiceaLog
]

{ #category : #accessing }
GtEpicea >> log: anEpLog [
	self log ifNotNil: [ self log announcer unsubscribe: self ].
	epiceaLog := anEpLog.
	self privateEvents: (self entries collect: #content).
	self log announcer
		when: EpEntryAdded
		send: #handleEpEntryAddedAnnouncement:
		to: self.
	self notifyEpiceaChanged
]

{ #category : #notifying }
GtEpicea >> notifyEpiceaChanged [
	| anImpactChanged |
	anImpactChanged := self computeImpact.
	self notifyEpiceaChangedWithImpactState: self hasImpact impactChanged: anImpactChanged.
]

{ #category : #notifying }
GtEpicea >> notifyEpiceaChangedWithImpactState: anImpactStateBoolean impactChanged: anImpactChangeBoolean [
	| anAnnouncement |
	anAnnouncement := (GtEpiceaUpdatedAnnouncement new 
		hasImpact: anImpactStateBoolean;
		impactChanged: anImpactChangeBoolean;
		numberOfEvents: self numberOfEvents;
		previousNumberOfEvents: previousNumberOfEvents).
	previousNumberOfEvents := self numberOfEvents.
	self announce: anAnnouncement.
]

{ #category : #accessing }
GtEpicea >> numberOfEvents [
	<return: #Integer>
	^ events ifNotNil: #size ifNil: 0
]

{ #category : #accessing }
GtEpicea >> ombuFile [
	<return: #FileReference>
	^ self log store writingFileReference
]

{ #category : #accessing }
GtEpicea >> ombuFile: aFileReference [
	self log: (EpLog fromFile: aFileReference)
]

{ #category : #testing }
GtEpicea >> ombuFileExists [
	<return: #Boolean>
	^ self ombuFile notNil and: [ self ombuFile exists ]
]

{ #category : #accessing }
GtEpicea >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self log store printOn: aStream.
	aStream nextPut: $)
]

{ #category : #private }
GtEpicea >> privateAddEvent: anEpEvent [
	events addLast: anEpEvent.
	diff := nil.
]

{ #category : #private }
GtEpicea >> privateEvents: aCollection [
	events := aCollection.
	diff := nil.
]

{ #category : #modification }
GtEpicea >> removeEvent: anEpEvent [
	| aNewEvents |
	aNewEvents := self events reject: [ :eachEvent | eachEvent = anEpEvent ].
	self log gtReset.
	aNewEvents do: [ :eachEvent | 
		self log addEntryWith: eachEvent tags: [ :tags | "ignore" ] ].
	self log store flush.
	self privateEvents: aNewEvents.
	self notifyEpiceaChanged.
]

{ #category : #accessing }
GtEpicea >> systemState [
	<return: #String>
	^ String streamContents: [ :aStream | 
		self events 
			do: [ :eachEvent | 
				| anOutput |
				anOutput := eachEvent accept: (GtEpiceaCurrentStateVisitor 
					inEnvironment: self theEnvironment).
				aStream nextPutAll: anOutput ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #accessing }
GtEpicea >> theEnvironment [
	^ self class environment
]

{ #category : #accessing }
GtEpicea >> tutorialState [
	<return: #String>
	^ String streamContents: [ :aStream | 
		self events 
			do: [ :eachEvent | 
				| anOutput |
				anOutput := eachEvent accept: GtEpiceaNewStateVisitor new.
				aStream nextPutAll: anOutput ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #accessing }
GtEpicea >> tutorialStateRope [
	<return: #BlRope>
	^ self tutorialState asRopedText
			glamorousCodeFontAndSize; 
			foreground: self constants matchLineColor
]

{ #category : #modification }
GtEpicea >> updateImpact [
	"Return true if impact changed"
	<return: #Boolean>
	| anImpactChanged |
	anImpactChanged := self computeImpact.
	anImpactChanged ifTrue: [ 
		self notifyEpiceaChangedWithImpactState: self hasImpact impactChanged: anImpactChanged ].
	^ anImpactChanged
]
