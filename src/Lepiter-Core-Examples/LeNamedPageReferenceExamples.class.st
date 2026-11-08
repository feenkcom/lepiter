Class {
	#name : #LeNamedPageReferenceExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeNamedPageReferenceExamples >> elementWithoutKnowledgeBaseUsesTheDefault [
	<gtExample>
	<return: #LeNamedPageReference>
	| reference element space |

	reference := LeNamedPageReference
		databaseName: 'Example documentation'
		pageTitle: 'Example page'.
	self
		assert: (reference knowledgeBaseFor: BlElement new)
		identicalTo: reference defaultKnowledgeBase.
	element := BlElement new.
	space := BlSpace new.
	space root addChild: element.
	self assert: element space identicalTo: space.
	self
		assert: (reference knowledgeBaseFor: element)
		identicalTo: reference defaultKnowledgeBase.
	^ reference

]

{ #category : #private }
LeNamedPageReferenceExamples >> exampleKnowledgeBase [
	| database knowledgeBase |

	database := LeDatabase new.
	database monitor: LeVolatileMonitor new.
	database databaseName: 'Example documentation'.
	database addPage: (LePage named: 'Example page').
	knowledgeBase := LeLogicalDatabase new.
	knowledgeBase primaryDB: database.
	^ knowledgeBase

]

{ #category : #examples }
LeNamedPageReferenceExamples >> referenceFindsThePage [
	<gtExample>
	<return: #LePage>
	| reference page |

	reference := LeNamedPageReference
		databaseName: 'Example documentation'
		pageTitle: 'Example page'.
	page := reference
		pageIn: self exampleKnowledgeBase
		ifFound: [ :aPage | aPage ]
		ifNone: [ nil ].
	self assert: page notNil.
	self assert: page title equals: 'Example page'.
	^ page

]

{ #category : #examples }
LeNamedPageReferenceExamples >> referenceToAMissingDatabaseIsNotFound [
	<gtExample>
	<return: #LeNamedPageReference>
	| reference result |

	reference := LeNamedPageReference
		databaseName: 'No such database'
		pageTitle: 'Example page'.
	result := reference
		pageIn: self exampleKnowledgeBase
		ifFound: [ :aPage | aPage ]
		ifNone: [ #notFound ].
	self assert: result equals: #notFound.
	^ reference

]

{ #category : #examples }
LeNamedPageReferenceExamples >> referenceToAMissingPageIsNotFound [
	<gtExample>
	<return: #LeNamedPageReference>
	| reference result |

	reference := LeNamedPageReference
		databaseName: 'Example documentation'
		pageTitle: 'No such page'.
	result := reference
		pageIn: self exampleKnowledgeBase
		ifFound: [ :aPage | aPage ]
		ifNone: [ #notFound ].
	self assert: result equals: #notFound.
	^ reference

]

{ #category : #examples }
LeNamedPageReferenceExamples >> referencesAreEqualByDatabaseAndTitle [
	<gtExample>
	<return: #LeNamedPageReference>
	| reference |

	reference := LeNamedPageReference
		databaseName: 'Example documentation'
		pageTitle: 'Example page'.
	self
		assert: reference
		equals: (LeNamedPageReference databaseName: 'Example documentation' pageTitle: 'Example page').
	self
		assert: reference hash
		equals: (LeNamedPageReference databaseName: 'Example documentation' pageTitle: 'Example page') hash.
	self
		deny: reference
		equals: (LeNamedPageReference databaseName: 'Example documentation' pageTitle: 'Other page').
	self assert: (reference printString endsWith: '(page ''Example page'' in ''Example documentation'')').
	^ reference

]
