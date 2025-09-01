Extension { #name : #LePage }

{ #category : #'*Lepiter-Topics' }
LePage >> asPageNode [
	^ TMPageNode for: self
]

{ #category : #'*Lepiter-Topics' }
LePage >> gtTopicMapActionFor: anAction [
	"To do: 
		- fix this to show the topic map for just this page
		- add an id."

	<lePageAction>
	TMRegistry uniqueInstance extensionsEnabled ifFalse: [ ^ anAction empty ].
	self hasTopicMap ifFalse: [ ^ anAction empty ].
	^ anAction button
		tooltip: 'Inspect topic map';
		icon: TopicMap topicMapIcon;
		action: [ :aButton | aButton phlow spawnObject: self asPageNode ];
		primaryModifierAction: [ :aButton | aButton phlow showObject: self asPageNode ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*Lepiter-Topics' }
LePage >> gtTopicMapMenuFor: anAction [
	<gtAction>
	^ anAction dropdown
		icon: TopicMap topicMapIcon;
		priority: 20;
		tooltip: 'Topic Map Menu';
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Inspect topic map' -> [ aButton phlow spawnObject: (TMPageNode for: self) ].
						'Enable topic map actions' -> [ TMRegistry uniqueInstance enableExtensions ].
						'Disable topic map actions'
							-> [ TMRegistry uniqueInstance disableExtensions ]};
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
