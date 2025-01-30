"
Examples for testing that pages with various kinds of snippets can be moved between databases.
"
Class {
	#name : #MovingPagesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Moving'
}

{ #category : #'example - page' }
MovingPagesExamples >> changesSnippetPage [
	<gtExample>
	^ (LePage named: 'A Changes snippet')
		addSnippet: (LeChangesSnippetHeightUpdateExamples new createTargetSnippet);
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> dockerSnippetPage [
	<gtExample>
	^ (LePage named: 'A Docker snippet page')
		addSnippet: LeDockerSnippetUpdateExamples new createTargetSnippet;
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> elementSnippetPage [
	<gtExample>
	^ (LePage named: 'An Element snippet page')
		addSnippet: (LeElementSnippet new
				code: 'GtInspector newOn: ''Hello World!''';
				codeVisible: false;
				elementHeight: 239;
				codeHeight: 50;
				yourself);
		addSnippet: (LeTextSnippet new
				string: '';
				yourself);
		yourself
]

{ #category : #'example - database' }
MovingPagesExamples >> emptyDatabase [
	<gtExample>
	| db |
	db := LeDatabase new monitor: LeVolatileMonitor new.
	LeBasicDatabasesRegistry new
		defaultLogicalDatabase: (LeLogicalDatabase new primaryDB: db).
	self assert: db pages isEmpty.
	^ db
]

{ #category : #'example - page' }
MovingPagesExamples >> exampleSnippetPage [
	<gtExample>
	^ (LePage named: 'An Example snippet page')
		addSnippet: LeExampleSnippetViewModelExamples new instanceSideExampleSnippet;
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> fileSnippetPage [
	"Caveat: LeFileSnippet is a work in progress."

	<gtExample>
	^ (LePage named: 'An empty File snippet page')
		addSnippet: (LeFileSnippet new
				fileReference: nil;
				bindingName: nil;
				yourself);
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> gqlSnippetPage [
	<gtExample>
	^ (LePage named: 'A Graph QL snippet page')
		addSnippet: (GtGQLLepiterExamples new graphQLSnippet);
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> linkedTextSnippetPage [
	<gtExample>
	^ (LePage named: 'A linked text snippet page')
		addSnippet: (LeTextSnippet new
				string: 'I link to [[Plain text snippet page]] and [[A Pharo snippet page]].';
				yourself);
		yourself
]

{ #category : #'example - moving' }
MovingPagesExamples >> moveAllPages [
	<gtExample>
	| source target sourceSize targetSize |
	source := self populatedDatabase.
	target := self emptyDatabase.
	sourceSize := source pages size.
	targetSize := target pages size.
	self assert: sourceSize > 0.
	self assert: targetSize equals: 0.
	source pages
		do: [ :p | 
			| newSourceSize newTargetSize |
			self assert: p canMoveToAnotherDatabase.
			p moveToDatabase: target.
			newSourceSize := source pages size.
			newTargetSize := target pages size.
			self assert: newSourceSize equals: sourceSize - 1.
			self assert: newTargetSize equals: targetSize + 1.
			sourceSize := newSourceSize.
			targetSize := newTargetSize ].
	^ target
]

{ #category : #'example - page' }
MovingPagesExamples >> pharoSnippetPage [
	<gtExample>
	^ (LePage named: 'A Pharo snippet page')
		addSnippet: (LePharoSnippet new
				code: '3 + 4';
				yourself);
		addSnippet: (LeTextSnippet new
				string: '';
				yourself);
		yourself
]

{ #category : #'example - database' }
MovingPagesExamples >> populatedDatabase [
	<gtExample>
	| db |
	db := self emptyDatabase.
	db addPage: self textSnippetPage.
	db addPage: self pharoSnippetPage.
	db addPage: self elementSnippetPage.
	db addPage: self linkedTextSnippetPage.
	db addPage: self gqlSnippetPage.
	db addPage: self dockerSnippetPage.
	db addPage: self exampleSnippetPage.
	db addPage: self fileSnippetPage.
	"db addPage: self changesSnippetPage."
	"db addPage: self wordExplanationSnippetPage."
	^ db
]

{ #category : #'example - page' }
MovingPagesExamples >> textSnippetPage [
	<gtExample>
	^ (LePage named: 'Plain text snippet page')
		addSnippet: (LeTextSnippet new
				string: 'A text snippet without links.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: '';
				yourself);
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> wordExplanationSnippetPage [
	<gtExample>
	^ (LePage named: 'A word explanation snippet')
		addSnippet: (LeWordSnippet new
				word: 'Explanation';
				explanation: (LeWordExplanation basicNew
						instVarAt: 1
							put: ((Array new: 1)
									at: 1
										put: (Dictionary new
												add: 'phonetics'
														-> ((Array new: 1)
																at: 1
																	put: (Dictionary new
																			add: 'text' -> '/ˌɛkspləˈneɪʃən/';
																			add: 'audio'
																					-> 'https://api.dictionaryapi.dev/media/pronunciations/en/explanation-us.mp3';
																			add: 'sourceUrl' -> 'https://commons.wikimedia.org/w/index.php?curid=1661646';
																			add: 'license'
																					-> (Dictionary new
																							add: 'name' -> 'BY-SA 3.0';
																							add: 'url' -> 'https://creativecommons.org/licenses/by-sa/3.0';
																							yourself);
																			yourself);
																yourself);
												add: 'meanings'
														-> ((Array new: 1)
																at: 1
																	put: (Dictionary new
																			add: 'definitions'
																					-> ((Array new: 3)
																							at: 1
																								put: (Dictionary new
																										add: 'synonyms' -> #();
																										add: 'definition' -> 'The act or process of explaining.';
																										add: 'antonyms' -> #();
																										add: 'example' -> 'The explanation was long and drawn-out.';
																										yourself);
																							at: 2
																								put: (Dictionary new
																										add: 'synonyms' -> #();
																										add: 'definition' -> 'Something that explains, makes understandable.';
																										add: 'antonyms' -> #();
																										add: 'example' -> 'An explanation for the UFO sightings was easily found.';
																										yourself);
																							at: 3
																								put: (Dictionary new
																										add: 'synonyms' -> #();
																										add: 'definition'
																												-> 'A resolution of disputed points pursuant to discussion; a mutual clarification of disputed points; reconciliation.';
																										add: 'antonyms' -> #();
																										yourself);
																							yourself);
																			add: 'synonyms'
																					-> #('clarification' 'elaboration' 'elucidation' 'explaining' 'femsplaining' 'mansplaining' 'mansplanation');
																			add: 'antonyms' -> #();
																			add: 'partOfSpeech' -> 'noun';
																			yourself);
																yourself);
												add: 'sourceUrls' -> #('https://en.wiktionary.org/wiki/explanation');
												add: 'word' -> 'explanation';
												add: 'phonetic' -> '/ˌɛkspləˈneɪʃən/';
												add: 'license'
														-> (Dictionary new
																add: 'name' -> 'CC BY-SA 3.0';
																add: 'url' -> 'https://creativecommons.org/licenses/by-sa/3.0';
																yourself);
												yourself);
									yourself);
						instVarAt: 2 put: 'Explanation';
						yourself));
		yourself
]
