"
I provide a word explanation.
I hold collection of {{gtClass:LeWordMeaning}}.
## Example
{{gtExample:LeWordExamples>>#helloExplanation|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #LeWordExplanation,
	#superclass : #LeWordData,
	#instVars : [
		'word'
	],
	#category : #'Lepiter-Snippet-Words-Model'
}

{ #category : #accessing }
LeWordExplanation >> = anObject [
	^ (anObject isKindOf: LeWordExplanation) and: [anObject word = self word and: [anObject meanings = self meanings]]
]

{ #category : #'api - accessing' }
LeWordExplanation >> definitions [
	^ self meanings flatCollect: #definitions
]

{ #category : #'gt-extensions' }
LeWordExplanation >> gtDefinitionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Definitions';
		priority: 5;
		items: [ self definitions ];
		column: 'Part of Speech' text: [ :aDefinition | aDefinition partOfSpeech ] width: 100;
		column: 'Definition' text: [ :aDefinition | aDefinition definition ]
]

{ #category : #'gt-extensions' }
LeWordExplanation >> gtMeaningsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Meanings';
		priority: 4;
		items: [ self meanings ];
		column: 'Part of Speech' text: [ :aMeaning | aMeaning partOfSpeech ] weight: 2;
		column: 'Number of Definitions' text: [ :aMeaning | aMeaning definitions size ]
]

{ #category : #'gt-extensions' }
LeWordExplanation >> gtUIExplanationFor: aView [
	<gtView>
	^ aView explicit
		title: 'UI';
		priority: 1;
		stencil: [ 
			LeWordViewElement new
				explanation: self ]
]

{ #category : #'api - accessing' }
LeWordExplanation >> meanings [ 	
	| meanings |
	meanings := OrderedCollection new.
	rawData do: [ :aDictionary |
		(aDictionary at: 'meanings') do: [ :aMeaningData |
			meanings add: (LeWordMeaning new
				rawData: aMeaningData) ] ].
	^ meanings
]

{ #category : #printing }
LeWordExplanation >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPut: $(;
		nextPutAll: self word;
		nextPut: $)
]

{ #category : #'api - accessing' }
LeWordExplanation >> word [
	^ word
]

{ #category : #'api - accessing' }
LeWordExplanation >> word: anObject [
	word := anObject
]
