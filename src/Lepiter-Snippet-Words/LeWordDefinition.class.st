"
I provide a word definition.
I know a word definition and example.
I am used by {{gtClass:LeWordMeaning}}.
## Example
The following explanation example holds several definitions that you can explore.
{{gtExample:LeWordExamples>>#helloExplanation|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #LeWordDefinition,
	#superclass : #LeWordData,
	#instVars : [
		'partOfSpeach'
	],
	#category : #'Lepiter-Snippet-Words-Model'
}

{ #category : #accessing }
LeWordDefinition >> = anObject [

	^ (anObject isKindOf: LeWordDefinition) and: [ 
		  anObject definition = self definition and: [ 
			  anObject partOfSpeech = self partOfSpeech and: [ 
				  anObject exampleSentence = self exampleSentence ] ] ]
]

{ #category : #accessing }
LeWordDefinition >> definition [
	^ rawData at: 'definition'
]

{ #category : #accessing }
LeWordDefinition >> exampleSentence [
	^ rawData at: 'example' ifAbsent: [ nil ].
]

{ #category : #accessing }
LeWordDefinition >> partOfSpeech [
	^ partOfSpeach
]

{ #category : #accessing }
LeWordDefinition >> partOfSpeech: anObject [
	partOfSpeach := anObject
]

{ #category : #accessing }
LeWordDefinition >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: self partOfSpeech;
		nextPutAll: ', ';
		nextPutAll: self definition;
		nextPutAll: ')'
]
