"
I provide a word explanation.
I hold collection of ${class:LeWordDefinition}$.
I am used by ${class:LeWordExplanation}$.
!! Example
The following explanation example holds several meanings that you can explore.
${example:LeWordExamples>>#helloExplanation|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #LeWordMeaning,
	#superclass : #LeWordData,
	#category : #'Lepiter-Snippet-Words-Model'
}

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
