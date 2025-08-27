Extension { #name : #LePage }

{ #category : #'*Lepiter-Topics' }
LePage >> gtTopicMapActionFor: anAction [
	"To do: add an id."

	<lePageAction>
	TMRegistry uniqueInstance viewsEnabled ifFalse: [ ^ anAction empty ].
	self hasTopicMap ifFalse: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Inspect topic map';
		icon: BrGlamorousVectorIcons directions;
		action: [ :aButton | aButton phlow spawnObject: self topicMap ]
]

{ #category : #'*Lepiter-Topics' }
LePage >> gtTopicMapMenuFor: anAction [
	<gtAction>
	^ anAction dropdown
		icon: BrGlamorousVectorIcons directions;
		priority: 20;
		tooltip: 'Topic Map Menu';
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Enable topic map views' -> [ TMRegistry uniqueInstance enableViews ].
						'Disable topic map views' -> [ TMRegistry uniqueInstance disableViews ]};
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
