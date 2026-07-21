Class {
	#name : #LeContextMenuItemValuableSpecification,
	#superclass : #Object,
	#traits : 'TLeContextMenuItemSpecification',
	#classTraits : 'TLeContextMenuItemSpecification classTrait',
	#instVars : [
		'title',
		'valuable'
	],
	#category : 'Lepiter-UI-Snippet-Spotter'
}

{ #category : #'api - converting' }
LeContextMenuItemValuableSpecification >> asSnippet [
	<return: #LeSnippet>
	^ self valuable value
]

{ #category : #'api - accessing' }
LeContextMenuItemValuableSpecification >> title [
	^ title value ifNil: [ String empty ]
]

{ #category : #'api - accessing' }
LeContextMenuItemValuableSpecification >> title: anObject [
	title := anObject
]

{ #category : #'api - accessing' }
LeContextMenuItemValuableSpecification >> valuable [
	^ valuable
]

{ #category : #'api - accessing' }
LeContextMenuItemValuableSpecification >> valuable: aValuable [
	valuable := aValuable
]
