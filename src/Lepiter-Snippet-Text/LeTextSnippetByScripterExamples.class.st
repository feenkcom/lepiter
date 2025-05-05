Class {
	#name : #LeTextSnippetByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Lepiter-Snippet-Text-Examples'
}

{ #category : #'examples - support' }
LeTextSnippetByScripterExamples >> assertTextSnippetElementContentIn: aStep [
	<gtExample>
	aStep check
		label: 'Check text snippet element content';
		do: [ :aList | 
			| anElementCollection |
			anElementCollection := (aList query // LeTextCoderSnippetElement) result.
			self assert: anElementCollection isNotEmpty description: [ 'Page must have some Pharo snippet elements' ].
			anElementCollection do: [ :eachSnippetElement |
				self assert: eachSnippetElement editor text asString equals: eachSnippetElement snippet text asString ] ];
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement
]

{ #category : #'examples - text snippet' }
LeTextSnippetByScripterExamples >> changeTextSnippetText [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self textSnippetElement.

	aScripter
		substep: 'Change and check snippet text'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Change snippet text';
						block: [ :aSnippet | 
							| aText |
							aText := aSnippet text copy.
							aText insertString: ' INSERTED ' at: 5.
							aSnippet updateText: aText ];
						onModel ].
			aStep wait
				forEmptySpaceTaskQueue;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check whether text editor and text snippet have different BlText instances';
						satisfies: [ :anEditor | anEditor text ~~ aScripter model text ]
							description: [ 'Text editor must not share same BlText instance with the block model' ];
						onBreadthFirstChildOfClass: GtTextualCoderEditorElement ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Text editor have same text content as snippet';
						satisfies: [ :anEditor | anEditor text characters = aScripter model text characters ]
							description: [ 'Text editor must have same content as the snippet' ];
						onBreadthFirstChildOfClass: GtTextualCoderEditorElement ] ].

	^ aScripter
]

{ #category : #'examples - support' }
LeTextSnippetByScripterExamples >> clickOnTextSnippetAt: anIndex step: aStep [
	<gtExample>
	
	aStep click
		label: 'Click on a text snippet at ', anIndex asString, ' position';
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement;
		onChildAt: anIndex;
		onBreadthFirstChildOfClass: LeTextCoderSnippetElement;
		onBreadthFirstChildOfClass: BrTextElementWithCursors.

	^ aStep
]

{ #category : #'examples - by scripter' }
LeTextSnippetByScripterExamples >> compareElementAndSnippetTextInstances [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self textSnippetElement.

	aScripter
		checkStep: [ :s | 
			s
				label: 'Text editor and snippet have differentes text instances';
				satisfies: [ :anEditor | anEditor text ~~ aScripter model text ]
					description: [ 'Text editor must not have the same BlText instance as the snipept model' ];
				onBreadthFirstChildOfClass: GtTextualCoderEditorElement ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Text editor have same text content as snippet';
				satisfies: [ :anEditor | anEditor text characters = aScripter model text characters ]
					description: [ 'Text editor must have same content as the snippet' ];
				onBreadthFirstChildOfClass: GtTextualCoderEditorElement ].

	^ aScripter
]

{ #category : #'examples - support' }
LeTextSnippetByScripterExamples >> editEveryVisibleTextSnippetIn: aStep appending: aString [
	<gtExample>
	aStep do
		label: 'Edit textual snippet element content';
		block: [ :aList | 
			| anElementCollection |
			anElementCollection := (aList query // LeTextCoderSnippetElement) result.
			self assert: anElementCollection isNotEmpty description: [ 'Page must have some Pharo snippet elements' ].
			anElementCollection do: [ :eachSnippetElement |
				eachSnippetElement editor text append: aString asRopedText. 
				self assert: eachSnippetElement editor text asString equals: eachSnippetElement snippet text asString ] ];
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement
]

{ #category : #'examples - two databases' }
LeTextSnippetByScripterExamples >> insertPageRemoteLink [
	"Add a Page Two remote linke into a Page One text snippet.
	Each page is in a different database.
	Both databases and pages exists."

	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := LeUIByScripterExamples new logicalDatabasePageOneElementInPager.

	aScripter
		substeps: 'Link Page Two in Page One'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Add Page Two';
						block: [ :aLogicalDatabase :aUserData | 
							LeUIByScripterExamples
								inExample: [ :anExample | 
									| aPageTwo |
									aPageTwo := anExample
											addEmptyPageTwoInto: (anExample databaseTwoIn: aLogicalDatabase).
									aUserData at: #pageTwoRemoteLink put: aPageTwo asRemoteLink ] ];
						onModel ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert remote link';
						satisfies: [ :theScripter | (theScripter userData at: #pageTwoRemoteLink) isNotNil ];
						onScripter ].

			aStep requestFocus
				in: [ :theStep | LeUIByScripterExamples targetPageInfiniteElement: theStep ];
				onChildAt: 1;
				id: GtSourceCoderEditorId;
				play.

			aStep
				typeStep: [ :s | 
					s
						label: 'Type Page Two link';
						valuable: [ :anElement :theScripter | (theScripter userData at: #pageTwoRemoteLink) , '  ' ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Page Two link is valid';
						value: [ :aText | 
								aText iterator
									detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
									ifFound: [ :that | that paint ]
									ifNone: [ nil ] ]
							equals: [ BrGlamorousColors linkColor ];
						in: [ :theStep | LeUIByScripterExamples targetPageInfiniteElement: theStep ];
						onChildAt: 1;
						id: GtSourceCoderEditorId;
						onBreadthFirstChildOfClass: BrButton;
						/ #label;
						onChildFromMessage: #text ] ].

	^ aScripter
]

{ #category : #'examples - two databases' }
LeTextSnippetByScripterExamples >> linkPageOneAndPageTwoOfDisconnectedDatabases [
	"Create a Database One with Page Two.
	Create a Database Two with Page Two.
	Keep both databases separate.
	Add Page One remote link into Page Two.
	Add Database One into a logical database.
	Add Database Two into a logical database.
	Display Page Two (According to https://github.com/feenkcom/gtoolkit/issues/3081 the link should be red)."

	<gtExample>
	<return: #LeTextSnippetExampleResult>
	| aDatabaseOne aDatabaseTwo aPageOne aPageTwo aPageOneRemoteLink aSnippet |
	aDatabaseOne := LeUIByScripterExamples new databaseWithPageOne.
	aDatabaseOne databaseName: LeUIByScripterExamples new databaseOneName.
	aDatabaseTwo := LeUIByScripterExamples new databaseWithPageTwo.
	aDatabaseTwo databaseName: LeUIByScripterExamples new databaseTwoName.

	aPageOne := LeUIByScripterExamples new pageOneIn: aDatabaseOne.
	aPageTwo := LeUIByScripterExamples new pageTwoIn: aDatabaseTwo.

	aPageOneRemoteLink := aPageOne asRemoteLink.
	aSnippet := aPageTwo snippetBuilder
			string: aPageOneRemoteLink , '  ';
			add.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first isExistingPage not.

	^ LeTextSnippetExampleResult new
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aPageOne;
		pageTwo: aPageTwo;
		pageTwoSnippet: aSnippet
]

{ #category : #'examples - two databases' }
LeTextSnippetByScripterExamples >> linkPageOneAndPageTwoOfDisconnectedDatabases_connectDatabases [
	"Create a Database One with Page Two.
	Create a Database Two with Page Two.
	Keep both databases separate.
	Add Page One remote link into Page Two.
	Add Database One into a logical database.
	Add Database Two into a logical database.
	Display Page Two (According to https://github.com/feenkcom/gtoolkit/issues/3081 the link should be red)."

	<gtExample>
	<return: #LeTextSnippetExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aLogicalDatabase |
	aResult := self linkPageOneAndPageTwoOfDisconnectedDatabases.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	aLogicalDatabase addDB: aDatabaseTwo.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTextSnippetExampleResult new
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet
]

{ #category : #'examples - two databases' }
LeTextSnippetByScripterExamples >> linkPageOneAndPageTwoOfDisconnectedDatabases_connectDatabases_databaseTwoFirst [
	"Create a Database One with Page Two.
	Create a Database Two with Page Two.
	Keep both databases separate.
	Add Page One remote link into Page Two.
	Add Database Two into a logical database.
	Add Database One into a logical database.
	Display Page Two (According to https://github.com/feenkcom/gtoolkit/issues/3081 the link should be red)."

	<gtExample>
	<return: #LeTextSnippetExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aLogicalDatabase |
	aResult := self linkPageOneAndPageTwoOfDisconnectedDatabases.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseTwo.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	aLogicalDatabase addDB: aDatabaseOne.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTextSnippetExampleResult new
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet
]

{ #category : #'examples - support' }
LeTextSnippetByScripterExamples >> moveDownTextSnippetAt: anIndex step: aStep [
	<gtExample>
	
	self clickOnTextSnippetAt: anIndex step: aStep.
	
	aStep shortcut
		combination: (LeSnippetElement keyboardShortcut: #MoveSnippetDown);
		label: 'Click on a text snippet at ', anIndex asString, ' position';
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement;
		onChildAt: anIndex;
		onBreadthFirstChildOfClass: LeTextCoderSnippetElement;
		onBreadthFirstChildOfClass: BrTextElementWithCursors.

	^ aStep
]

{ #category : #'examples - page - text snippets' }
LeTextSnippetByScripterExamples >> pageContentElementWithEnumeradedTextSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ LeUIExamples new titledPageWithTextSnippets_numbers ]
			element: [ :aPage | LePageToolContentTreeElement new pageViewModel: aPage asContentUIModel ].
	^ aScripter
]

{ #category : #'examples - page - text snippets' }
LeTextSnippetByScripterExamples >> scrollDownEnumeradedTextSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageContentElementWithEnumeradedTextSnippets.
	aScripter
		substeps: 'Scroll down and check snippet element contents'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			8
				timesRepeat: [ anIndex := anIndex + 1.

					self moveDownTextSnippetAt: 1 step: aRootStep.

					self editEveryVisibleTextSnippetIn: aRootStep appending: ' scrollDown'.

					aRootStep
						substeps: anIndex asString , ' scroll and snippet element content'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll down text snippets';
								downBy: 25;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement;
								play.
							aStep wait
								forEmptySpaceTaskQueueTimeout: 1 seconds;
								play.

							self assertTextSnippetElementContentIn: aStep ] ] ].
	^ aScripter
]

{ #category : #'examples - page - text snippets' }
LeTextSnippetByScripterExamples >> scrollUpEnumeradedTextSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scrollDownEnumeradedTextSnippets.
	aScripter
		substeps: 'Scroll up and check snippet element contents'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			8
				timesRepeat: [ anIndex := anIndex + 1.

					self editEveryVisibleTextSnippetIn: aRootStep appending: ' scrollUp'.

					aRootStep
						substeps: anIndex asString , ' scroll and snippet element content'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll down text snippets';
								upBy: 25;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement;
								play.
							aStep wait
								forEmptySpaceTaskQueueTimeout: 1 seconds;
								play.

							self assertTextSnippetElementContentIn: aStep ] ] ].
	^ aScripter
]

{ #category : #'examples - by scripter' }
LeTextSnippetByScripterExamples >> textSnippetElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ LeUIExamples new blockWithLinkToPage ]
			element: [ :aSnippet | 
				| snippetViewModel snippetElement |
				snippetViewModel := aSnippet asSnippetViewModel.
				snippetElement := snippetViewModel snippetView asElement.
				snippetElement snippetViewModel: snippetViewModel ].
	^ aScripter
]

{ #category : #'examples - by scripter' }
LeTextSnippetByScripterExamples >> typeTextInTextSnippetElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self textSnippetElement.

	aScripter
		substep: 'Insert text'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Insert text';
						block: [ :anEditor | 
							| aText |
							aText := anEditor text.
							aText insertString: ' INSERTED ' at: 5 ];
						onBreadthFirstChildOfClass: GtTextualCoderEditorElement ].
			aStep wait
				forEmptySpaceTaskQueue;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check whether text editor and text snippet have different BlText instances';
						satisfies: [ :anEditor | anEditor text ~~ aScripter model text ]
							description: [ 'Text editor must not share same BlText instance with the block model' ];
						onBreadthFirstChildOfClass: GtTextualCoderEditorElement ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Text editor have same text content as snippet';
						satisfies: [ :anEditor | anEditor text characters = aScripter model text characters ]
							description: [ 'Text editor must have same content as the snippet' ];
						onBreadthFirstChildOfClass: GtTextualCoderEditorElement ] ].

	^ aScripter
]
