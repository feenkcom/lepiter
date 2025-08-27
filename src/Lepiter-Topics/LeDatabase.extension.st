Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-Topics' }
LeDatabase >> gtTopicMapMenuFor: anAction [
	<gtAction>
	^ anAction dropdown
		icon: BrGlamorousVectorIcons bookmark;
		priority: 20;
		tooltip: 'Topic Map Menu';
		content: [ :aButton | 
			BrGlamorousSimpleContextMenuContent new
				items: {'Inspect topic map' -> [ aButton phlow spawnObject: self topicMap ].
						'Enable topic map actions' -> [ TMRegistry uniqueInstance enableActions ].
						'Disable topic map actions' -> [ TMRegistry uniqueInstance disableActions ]};
				yourself ]
]

{ #category : #'*Lepiter-Topics' }
LeDatabase >> hasTopicMap [
	^ TMRegistry uniqueInstance hasTopicMapFor: self databaseName
]

{ #category : #'*Lepiter-Topics' }
LeDatabase >> topicMap [
	self
		assert: self hasTopicMap
		description: 'No topic map exists for the database ' , self databaseName.
	^ TMRegistry uniqueInstance topicMapFor: self databaseName
]
