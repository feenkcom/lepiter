"
I provide examples to easily show {{gtClass:BlElement}} instances in a {{gtClass:BlSpace}}.

"
Trait {
	#name : #TLeSpaceExamples,
	#category : #'Lepiter-UI-Examples'
}

{ #category : #'examples - support' }
TLeSpaceExamples >> closeSpace: aSpace with: anElement [
	<gtExample>
	"Remove an element from the space and close the space"
	anElement removeFromParent.
	aSpace close.
]

{ #category : #'examples - support' }
TLeSpaceExamples >> newSpace [
	<gtExample>
	<return: #BlSpace>
	<return: #BlSpace>
	<return: #Error>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Async Element Examples'.
	aSpace extent: 600 @ 400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #'examples - support' }
TLeSpaceExamples >> performUIAction: aBlock in: anElement [
	anElement enqueueTask: (BlTaskAction new action: aBlock).
	self waitTaskExecutionIn: anElement.
]

{ #category : #'examples - support' }
TLeSpaceExamples >> putInSpace: aBlElement [
	<gtExample>
	| aSpace |
	self 
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace enqueueTask: (BlTaskAction new action: [ 
		aSpace root addChild: aBlElement ]).
	^ aSpace
]

{ #category : #'examples - support' }
TLeSpaceExamples >> showInSpace: aBlElement [
	<gtExample>
	| aSpace |
	aSpace := self putInSpace: aBlElement.
	aSpace show.
	self waitTaskExecutionIn: aSpace.
	^ aSpace
]

{ #category : #'examples - support' }
TLeSpaceExamples >> waitTaskExecutionIn: anElement [
	| aSemaphore isExpired |

	aSemaphore := Semaphore new.
	anElement enqueueTask: (BlTaskAction new action: [ 
		aSemaphore signal ]).
	isExpired := aSemaphore waitTimeoutSeconds: 10.
	self assert: isExpired not description: [ 'Task execution semaphore expired, queue=', anElement taskQueue printString ].
]
