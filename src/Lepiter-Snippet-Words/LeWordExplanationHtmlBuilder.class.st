Class {
	#name : #LeWordExplanationHtmlBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'explanation',
		'context'
	],
	#category : #'Lepiter-Snippet-Words-Support'
}

{ #category : #'api - building' }
LeWordExplanationHtmlBuilder >> build [
	self
		assert: [ self explanation isNotNil ] 
		description: [ 'Explanation must be non-nil' ].
		
	self buildTitle.
	self buildMeanings.
]

{ #category : #'private - building' }
LeWordExplanationHtmlBuilder >> buildDefinition: aDefinition [
	context html 
		tag: #p
		class: 'explanation-definition'
		with: aDefinition definition.
	
	aDefinition exampleSentence
		ifNotNil: [ :anExample | 
			context html 
				tag: #p
				class: 'explanation-example'
				with: anExample asString. ].
]

{ #category : #'private - building' }
LeWordExplanationHtmlBuilder >> buildMeanings [
	self explanation meanings
		do: [ :aMeaning | 
			context html 
				tag: #p
				class: 'explanation-meaning'
				with: aMeaning partOfSpeech.

			aMeaning definitions do: [ :aDefinition | 
				self buildDefinition: aDefinition ] ]
]

{ #category : #'private - building' }
LeWordExplanationHtmlBuilder >> buildTitle [
	context html
		tag: #p
		class: 'explanation-word'
		with: self explanation word
]

{ #category : #accessing }
LeWordExplanationHtmlBuilder >> context [
	^ context
]

{ #category : #accessing }
LeWordExplanationHtmlBuilder >> context: anObject [
	context := anObject
]

{ #category : #'api - accessing' }
LeWordExplanationHtmlBuilder >> explanation [
	^ explanation
]

{ #category : #'api - accessing' }
LeWordExplanationHtmlBuilder >> explanation: anObject [
	explanation := anObject
]
