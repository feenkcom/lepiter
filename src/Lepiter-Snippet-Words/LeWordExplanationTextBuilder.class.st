"
I build a {{gtClass:BlText}} that is displayed to user.
The text is a textural representation of a {{gtClass:LeWordExplanation}}.
I am used by {{gtClass:LeWordViewElement}}.
## Example
{{gtExample:LeWordExamples>>#explanationTextBuilder|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : #LeWordExplanationTextBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'explanation',
		'text'
	],
	#category : 'Lepiter-Snippet-Words-UI Auxiliar Elements'
}

{ #category : #'api - building' }
LeWordExplanationTextBuilder >> build [
	<return: #BlText>
	self
		assert: [ self explanation isNotNil ] 
		description: [ 'Explanation must be non-nil' ].
	
	self buildTitle.
	self buildMeanings.
	
	self text glamorousRegularFont.

	^ self text
]

{ #category : #'private - building' }
LeWordExplanationTextBuilder >> buildMeanings [
	self explanation meanings do: [ :aMeaning |
		| aText |
		aText := aMeaning partOfSpeech asRopedText italic.
		aText paragraphMargin: (BlInsets top: 5).
		self text append: String cr asRopedText.
		self text append: aText.
		
		aMeaning definitions do: [ :aDefinition |
			| aDefinitionText |
			aDefinitionText := aDefinition definition asRopedText italic.
			aDefinitionText wordPadding: (BlInsets top: 5).
			
			aDefinition exampleSentence ifNotNil: [ :anExample | 
				| anExampleText |
				anExampleText := ('"', anExample asString ,'"') asRopedText.
				anExampleText foreground: Color lightGray.
				aDefinitionText append: String cr asRopedText.
				aDefinitionText append: anExampleText.
			].
		
			aDefinitionText paragraphMargin: (BlInsets top: 0 right: 0 bottom: 0 left: 20).
			self text append: String cr asRopedText.
			self text append: aDefinitionText.
		]
	]
]

{ #category : #'private - building' }
LeWordExplanationTextBuilder >> buildTitle [
		
	| aTitle |
	aTitle := self explanation word asRopedText.
	aTitle fontSize: 16.
	self text append: aTitle
]

{ #category : #'api - accessing' }
LeWordExplanationTextBuilder >> explanation [
	^ explanation
]

{ #category : #'api - accessing' }
LeWordExplanationTextBuilder >> explanation: anObject [
	explanation := anObject
]

{ #category : #'gt-extensions' }
LeWordExplanationTextBuilder >> gtTextFor: aView [
	<gtView>
	self text ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Text';
		object: [ self text ];
		view: #gtTextFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Explanation' 
			tooltip: 'Inspect explanation object' 
			action: [ :aButton | aButton phlow spawnObject: self explanation ]
]

{ #category : #initialization }
LeWordExplanationTextBuilder >> initialize [
	super initialize.
	text := '' asRopedText.
]

{ #category : #'private - accessing' }
LeWordExplanationTextBuilder >> text [
	^ text
]
