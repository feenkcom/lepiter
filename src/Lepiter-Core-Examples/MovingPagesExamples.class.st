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

{ #category : #'example - database' }
MovingPagesExamples >> emptyTemporaryDatabase [
	<gtExample>
	| db temporaryDatabase |
	temporaryDatabase := LeTemporaryDatabase new.
	db := temporaryDatabase.
	self assert: db database pages isEmpty.
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
MovingPagesExamples >> filePictureSnippetPage [
	"Local file that is NOT an attachment"
	<gtExample>
	^ (LePage named: 'A local file Picture snippet page')
		addSnippet: LeExportSnippetExamples new pictureSnippetWithHttps;
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
MovingPagesExamples >> gemstoneSnippetPage [
	<gtExample>
	^ (LePage named: 'A GemStone snippet page')
		addSnippet: ((LeGemStoneSnippet sessionName: 'nonExistentConnector:1')
				code: '4+3';
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
MovingPagesExamples >> httpsPictureSnippetPage [
	<gtExample>
	^ (LePage named: 'An https Picture snippet page')
		addSnippet: LeExportSnippetExamples new pictureSnippetWithHttps;
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> javaScriptSnippetPage [
	<gtExample>
	^ (LePage named: 'A JavaScript snippet page')
	addSnippet: (LeJavaScriptSnippet new
			code: '1 + 2';
			yourself);
	yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> jenkinsSnippetPage [
	<gtExample>
	^ (LePage named: 'A Jenkins snippet page')
		addSnippet: (LeJenkinsSnippet new
				jenkinsUrl: '';
				yourself);
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

{ #category : #'example - page' }
MovingPagesExamples >> mockedSnippetPage [
	"Work in progress?"

	<gtExample>
	^ (LePage named: 'A Docker snippet page')
		addSnippet: (LeMockedSnippet new string: 'Mocked');
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

{ #category : #'example - moving' }
MovingPagesExamples >> moveAllPagesWithPictures [
	"NB: These examples use a TemporaryDatabase.
	For the moment moving does not work for picture snippets."
	<gtExample>
	| source target sourceSize targetSize |
	source := self temporaryDatabaseWithPicturePages.
	target := self emptyTemporaryDatabase.
	sourceSize := source database pages size.
	targetSize := target database pages size.
	self assert: sourceSize > 0.
	self assert: targetSize equals: 0.
	source database pages
		do: [ :p | 
			"| newSourceSize newTargetSize |
			self assert: p canMoveToAnotherDatabase.
			p moveToDatabase: target.
			newSourceSize := source pages size.
			newTargetSize := target pages size.
			self assert: newSourceSize equals: sourceSize - 1.
			self assert: newTargetSize equals: targetSize + 1.
			sourceSize := newSourceSize.
			targetSize := newTargetSize" ].
	^ target
]

{ #category : #'example - page' }
MovingPagesExamples >> pharoRewriteSnippetPage [
	<gtExample>
	^ (LePage named: 'A Pharo rewrite snippet page')
		addSnippet: (LePharoRewriteSnippet new
				search: 'children isNil ifTrue: [ ^ self ].';
				replace: 'children ifNil: [ ^ self ].';
				yourself);
		yourself
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
	db addPage: self jenkinsSnippetPage.
	db addPage: self pharoRewriteSnippetPage.
	db addPage: self smaccRewriteSnippetPage.
	db addPage: self gemstoneSnippetPage.
	db addPage: self javaScriptSnippetPage.
	db addPage: self pythonSnippetPage.
	db addPage: self shellScriptSnippetPage.
	db addPage: self stringSnippetPage.
	db addPage: self unknownSnippetPage.
	db addPage: self wardleyMapSnippetPage.
	db addPage: self youTubeSnippetPage.
	"db addPage: self changesSnippetPage."
	"db addPage: self wordSnippetPage."
	"db addPage: self mockedSnippetPage."
	^ db
]

{ #category : #'example - page' }
MovingPagesExamples >> pythonSnippetPage [
	<gtExample>
	^ (LePage named: 'A Python snippet page')
		addSnippet: (LePythonSnippet new
				code: '1 + 2';
				yourself);
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> shellScriptSnippetPage [
	<gtExample>
	^ (LePage named: 'A Shell Script snippet page')
		addSnippet: (LeShellScriptSnippet new
				code: 'pwd';
				yourself);
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> smaccRewriteSnippetPage [
	<gtExample>
	^ (LePage named: 'A SmaCC Rewrite snippet page')
	addSnippet: (LeSmaCCRewriteSnippet new
			search: '';
			replace: '';
			scope: nil;
			parser: nil;
			startingState: nil;
			yourself);
	yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> stringSnippetPage [
	<gtExample>
	^ (LePage named: 'A String snippet page')
		addSnippet: (LeStringSnippet new
				contentString: '{
  "name": "Elizabeth",
  "children": [
    {
      "name": "Charles",
      "children": [
        {
          "name": "William",
          "children": [
            { "name": "George" },
            { "name": "Charlotte" }
          ]
        },
        {
          "name": "Harry",
          "children": [
          	{ "name": "Archie" },
          	{ "name": "Lilibet" }
          ]
        }
      ]
    }
  ]
}';
				bindingName: 'jsonQuery';
				format: #JSONParser;
				yourself);
		yourself
]

{ #category : #'example - database' }
MovingPagesExamples >> temporaryDatabaseWithPicturePages [
	<todo: 'Use this to test moving pages to another temporary database'>
	<gtExample>
	| db |
	db := LeModelExamples new databaseWithTwoPagesHavingPictureSnippets.
	db database addPage: self httpsPictureSnippetPage.
	db database addPage: self filePictureSnippetPage.
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
MovingPagesExamples >> unknownSnippetPage [
	<gtExample>
	^ (LePage named: 'An Unknown snippet page')
		addSnippet: (LeDatabaseReloadWithUnknownSnippetExamples new reloadPageWithUnknownSnippet
				pageNamed: #page1) children first;
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> wardleyMapSnippetPage [
	<gtExample>
	^ (LePage named: 'A Wardley Map snippet page')
		addSnippet: (LeWardleyMapSnippet new
				wardleyMap: GtWardleyMapModelExamples new newMapWithPipelineInnerNodes);
		yourself
]

{ #category : #'example - page' }
MovingPagesExamples >> wordSnippetPage [
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

{ #category : #'example - page' }
MovingPagesExamples >> youTubeSnippetPage [
	<gtExample>
	^ (LePage named: 'A YouTube snippet page')
		addSnippet: (LeYoutubeReferenceSnippet new
				urlString: 'https://www.youtube.com/watch?v=vtD-xD0Eo3c';
				yourself);
		yourself
]
