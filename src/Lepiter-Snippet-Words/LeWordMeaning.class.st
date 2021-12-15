"
I provide a word explanation.
I hold collection of {{gtClass:LeWordDefinition}}.
I am used by {{gtClass:LeWordExplanation}}.
## Example
The following explanation example holds several meanings that you can explore.
{{gtExample:LeWordExamples>>#helloExplanation|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #LeWordMeaning,
	#superclass : #LeWordData,
	#category : #'Lepiter-Snippet-Words-Model'
}

{ #category : #accessing }
LeWordMeaning >> = anObject [

	^ (anObject isKindOf: LeWordMeaning) and: [ 
		  anObject partOfSpeech == self partOfSpeech and: [ 
			  anObject definitions = self definitions ] ]
]

{ #category : #generated }
LeWordMeaning >> definitions [
	| definitions |
	definitions := OrderedCollection new.
	(rawData at: 'definitions') do: [ :aDefinitionData |
		definitions add: (LeWordDefinition new
			rawData: aDefinitionData;
			partOfSpeech: (rawData at: 'partOfSpeech')) ].
	^ definitions
]

{ #category : #accessing }
LeWordMeaning >> partOfSpeech [
	^ rawData at: 'partOfSpeech'
]
