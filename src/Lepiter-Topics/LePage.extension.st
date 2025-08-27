Extension { #name : #LePage }

{ #category : #'*Lepiter-Topics' }
LePage >> gtTopicMapActionFor: anAction [
	"To do: 
		- fix this to show the topic map for just this page
		- add an id."

	<lePageAction>
	TMRegistry uniqueInstance actionsEnabled ifFalse: [ ^ anAction empty ].
	self hasTopicMap ifFalse: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Inspect topic map';
		icon: BrGlamorousVectorIcons bookmark;
		action: [ :aButton | aButton phlow spawnObject: self topicMap ]
]

{ #category : #'*Lepiter-Topics' }
LePage >> gtTopicMapMenuFor: anAction [
	<gtAction>
	^ anAction dropdown
		icon: BrGlamorousVectorIcons bookmark;
		priority: 20;
		tooltip: 'Topic Map Menu';
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Enable topic map actions' -> [ TMRegistry uniqueInstance enableActions ].
						'Disable topic map actions' -> [ TMRegistry uniqueInstance disableActions ]};
				yourself ]
]

{ #category : #'*Lepiter-Topics' }
LePage >> hasTopicMap [
	^ self database hasTopicMap
]

{ #category : #'*Lepiter-Topics' }
LePage >> pageString [
	^ GtLlmLepiterContentExporter new
		page: self;
		export
]

{ #category : #'*Lepiter-Topics' }
LePage >> topicMap [
	^ self database topicMap
]
