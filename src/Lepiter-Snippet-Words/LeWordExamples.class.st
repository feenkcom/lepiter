"
I provide examples for the word snippet.
"
Class {
	#name : #LeWordExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Words-Examples'
}

{ #category : #'examples - words' }
LeWordExamples >> anotherWord [
	<gtExample>
	^ 'human'
]

{ #category : #'examples - explanation text builder' }
LeWordExamples >> basicExplanationTextBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := LeWordExplanationTextBuilder new.
	self assert: aBuilder explanation isNil.
	^ aBuilder
]

{ #category : #'examples - auxiliar elements' }
LeWordExamples >> basicInputElement [
	<gtExample>
	| anElement |
	anElement := LeWordInputElement new.

	self assert: anElement editorElement text asString isEmpty.
	
	^ anElement
]

{ #category : #'examples - snippet' }
LeWordExamples >> basicSnippet [
	<gtExample>
	| aSnippet |
	aSnippet := LeWordSnippet new.
	self assert: aSnippet word isNotNil.
	self assert: aSnippet word isEmpty.
	self assert: aSnippet explanation isNil.
	^ aSnippet
]

{ #category : #'examples - auxiliar elements' }
LeWordExamples >> basicViewElement [
	<gtExample>
	| anElement |
	anElement := LeWordViewElement new.

	self assert: anElement editorElement text asString isEmpty.
	
	^ anElement
]

{ #category : #'examples - snippet element' }
LeWordExamples >> editInputEditorText [
	<gtExample>
	| anElement anEditor |
	anElement := self element.
	anEditor := anElement inputElement editor.
	anEditor selecter all; select.
	anEditor inserter
		atCursor;
		string: self anotherWord;
		insert.
	
	self assert: anElement inputElement editorElement text asString equals: self anotherWord.
	self assert: anElement snippetViewModel word equals: self anotherWord.
	self assert: anElement snippetViewModel state equals: LeWordSnippetViewModelEditState default.
	self assert: anElement snippetViewModel response isNil.
	self assert: anElement snippetViewModel snippetModel word equals: self word.
	
	^ anElement
]

{ #category : #'examples - snippet element' }
LeWordExamples >> element [
	<gtExample>
	| aSnippet aViewModel anElement |
	aSnippet := self snippet.
	aViewModel := aSnippet asSnippetViewModel.
	anElement := aViewModel snippetView asElement.
	anElement snippetViewModel: aViewModel.
	
	self assert: anElement inputElement editorElement text asString equals: self word.
	self assert: anElement snippetViewModel word equals: self word.
	self assert: anElement snippetViewModel state equals: LeWordSnippetViewModelEditState default.
	self assert: anElement snippetViewModel response isNil.
	
	^ anElement
]

{ #category : #'examples - explanation text builder' }
LeWordExamples >> explanationTextBuilder [
	<gtExample>
	| aBuilder aText |
	aBuilder := self basicExplanationTextBuilder.
	aBuilder explanation: self helloExplanation.
	aText := aBuilder build.
	self assert: aBuilder explanation isNotNil.
	self assert: aText isNotNil.
	self assert: aText isNotEmpty.
	^ aBuilder
]

{ #category : #'examples - model' }
LeWordExamples >> helloExplanation [
	<gtExample>
	^ LeWordExplanation new
		word: self helloWord;
		rawData: self helloWordJsonObject
]

{ #category : #'examples - words' }
LeWordExamples >> helloWord [
	<gtExample>
	^ 'hello'
]

{ #category : #'examples - model' }
LeWordExamples >> helloWordJsonObject [
	<gtExample>
	^ STONJSON fromString: self helloWordJsonRawData
]

{ #category : #'examples - model' }
LeWordExamples >> helloWordJsonRawData [
	<gtExample>
	^ '[
    {
      "word": "hello",
      "phonetics": [
        {
          "text": "/həˈloʊ/",
          "audio": "https://lex-audio.useremarkable.com/mp3/hello_us_1_rr.mp3"
        },
        {
          "text": "/hɛˈloʊ/",
          "audio": "https://lex-audio.useremarkable.com/mp3/hello_us_2_rr.mp3"
        }
      ],
      "meanings": [
        {
          "partOfSpeech": "exclamation",
          "definitions": [
            {
              "definition": "Used as a greeting or to begin a phone conversation.",
              "example": "hello there, Katie!"
            }          ]
        },
        {
          "partOfSpeech": "noun",
          "definitions": [
            {
              "definition": "An utterance of “hello”; a greeting.",
              "example": "she was getting polite nods and hellos from people",
              "synonyms": [
                "greeting",
                "welcome",
                "salutation",
                "saluting",
                "hailing",
                "address",
                "hello",
                "hallo"
              ]
            }
          ]
        },
        {
          "partOfSpeech": "intransitive verb",
          "definitions": [
            {
              "definition": "Say or shout “hello”; greet someone.",
              "example": "I pressed the phone button and helloed"
            }
          ]
        }
      ]
    }
  ]'
]

{ #category : #'examples - auxiliar elements' }
LeWordExamples >> inputElement [
	<gtExample>
	| anElement |
	anElement := self basicInputElement.
	anElement word: self word.
	
	self assert: anElement editorElement text asString equals: self word.
	
	^ anElement
]

{ #category : #'examples - snippet element' }
LeWordExamples >> searchAnotherWordExplanation [
	<gtExample>
	| anElement |
	anElement := self editInputEditorText.
	BlUseAsyncFeatures disableDuring: [ 
		anElement snippetViewModel searchExplanation ].
	
	self assert: anElement inputElement editorElement text asString equals: self anotherWord.

	"Snippet view model"
	self assert: anElement snippetViewModel word equals: self anotherWord.
	self assert: anElement snippetViewModel response isNotNil.

	"Ideally we should simulate errors and success queries"
	anElement snippetViewModel 
		ifSuccess: [ 
			self assert: anElement snippetViewModel state equals: LeWordSnippetViewModelViewState default.
			self assert: anElement snippetViewModel snippetModel word equals: self anotherWord. ]
		otherwise: [ 
			self assert: anElement snippetViewModel state equals: LeWordSnippetViewModelEditState default.
			self assert: anElement snippetViewModel snippetModel word equals: self word ].

	"There should be at least (ideally) one update request"
	self assert: anElement taskQueue tasks size isZero not.
	
	^ anElement
]

{ #category : #'examples - snippet' }
LeWordExamples >> snippet [
	<gtExample>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet word: self word.
	self assert: aSnippet word equals: self word.
	self assert: aSnippet explanation isNil.
	^ aSnippet
]

{ #category : #'examples - snippet' }
LeWordExamples >> snippetWithExplanation [
	<gtExample>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet word: self helloWord.
	aSnippet explanation: self helloExplanation.
	self assert: aSnippet word equals: self helloWord.
	self assert: aSnippet explanation isNotNil.
	^ aSnippet
]

{ #category : #'examples - auxiliar elements' }
LeWordExamples >> viewElement [
	<gtExample>
	| anElement |
	anElement := self basicViewElement.
	anElement explanation: self helloExplanation.
	
	self assert: anElement editorElement text isNotEmpty.
	
	^ anElement
]

{ #category : #'examples - words' }
LeWordExamples >> word [
	<gtExample>
	^ 'Earth'
]
