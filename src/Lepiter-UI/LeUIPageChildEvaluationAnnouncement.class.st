"
I inform all {{gtClass:LePage}} children that a {{gtClass:LeCodeSnippet}} was evaluated.

"
Class {
	#name : #LeUIPageChildEvaluationAnnouncement,
	#superclass : #LeUIAnnouncement,
	#instVars : [
		'evaluatedBlock',
		'evaluatedBlockElement',
		'evaluationResult',
		'topParentElement'
	],
	#category : 'Lepiter-UI-Basic - Announcements'
}

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> evaluatedBlock [
	^ evaluatedBlock
]

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> evaluatedBlock: anObject [
	evaluatedBlock := anObject
]

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> evaluatedBlockElement [
	^ evaluatedBlockElement
]

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> evaluatedBlockElement: anObject [
	evaluatedBlockElement := anObject
]

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> evaluationResult [
	^ evaluationResult
]

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> evaluationResult: anObject [
	evaluationResult := anObject
]

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> topParentElement [
	^ topParentElement
]

{ #category : #'api - accessing' }
LeUIPageChildEvaluationAnnouncement >> topParentElement: anObject [
	topParentElement := anObject
]
