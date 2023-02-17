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
	| aScripter |
	aScripter := self textSnippetElement.
	
	aScripter substep: 'Change and check snippet text' do: [ :aStep |
		aStep do
			label: 'Change snippet text';
			block: [ :aSnippet |
				| aText |
				aText := aSnippet text copy.
				aText insertString: ' INSERTED ' at: 5.
				aSnippet updateText: aText ];
			onModel.
		aStep wait forEmptySpaceTaskQueue.
		
		aStep check
			label: 'Check whether text editor and text snippet have different BlText instances';
			satisfies: [ :anEditor | 
				anEditor text ~~ aScripter model text ] 
			description: [ 'Text editor must not share same BlText instance with the block model' ];
			onBreadthFirstChildOfClass: GtTextualCoderEditorElement.

		aStep check
			label: 'Text editor have same text content as snippet';
			satisfies: [ :anEditor | 
				anEditor text characters = aScripter model text characters ] 
			description: [ 'Text editor must have same content as the snippet' ];
			onBreadthFirstChildOfClass: GtTextualCoderEditorElement.
			
	].
	
	^ aScripter syncContinue
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
	| aScripter |
	aScripter := self textSnippetElement.
	
	aScripter check
		label: 'Text editor and snippet have differentes text instances';
		satisfies: [ :anEditor | 
			anEditor text ~~ aScripter model text ] 
		description: [ 'Text editor must not have the same BlText instance as the snipept model' ];
		onBreadthFirstChildOfClass: GtTextualCoderEditorElement.

	aScripter check
		label: 'Text editor have same text content as snippet';
		satisfies: [ :anEditor | 
			anEditor text characters = aScripter model text characters ] 
		description: [ 'Text editor must have same content as the snippet' ];
		onBreadthFirstChildOfClass: GtTextualCoderEditorElement.
	
	^ aScripter syncContinue
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
	<gtExample>
	| aScripter |
	aScripter := LeUIByScripterExamples new logicalDatabasePageOneElementInPager.

	aScripter
		substeps: 'Link Page Two in Page One'
		do: [ :aStep | 
			aStep do
				label: 'Add Page Two';
				block: [ :aLogicalDatabase :aUserData | 
					LeUIByScripterExamples
						inExample: [ :anExample | 
							| aPageTwo |
							aPageTwo := anExample
									addEmptyPageTwoInto: (anExample databaseTwoIn: aLogicalDatabase).
							aUserData at: #pageTwoRemoteLink put: aPageTwo asRemoteLink ] ];
				onModel;
				play.

			aStep assert
				label: 'Assert remote link';
				satisfies: [ :theScripter | (theScripter userData at: #pageTwoRemoteLink) isNotNil ];
				onScripter;
				play.

			aStep requestFocus
				in: [ :theStep | LeUIByScripterExamples new targetPageInfiniteElement: theStep ];
				onChildAt: 1;
				id: GtSourceCoderEditorId;
				play.

			aStep type
				label: 'Type Page Two link';
				valuable: [ :anElement :theScripter | (theScripter userData at: #pageTwoRemoteLink) , '  ' ];
				play.

			aStep assert
				label: 'Page Two link is valid';
				value: [ :aText | 
						aText iterator
							detectAttribute: [ :each | each class = BlTextForegroundAttribute ]
							ifFound: [ :that | that paint ]
							ifNone: [ nil ] ]
					equals: [ BrGlamorousColors linkColor ];
				in: [ :theStep | LeUIByScripterExamples new targetPageInfiniteElement: theStep ];
				onChildAt: 1;
				id: GtSourceCoderEditorId;
				onBreadthFirstChildOfClass: BrButton;
				/ #label;
				onChildFromMessage: #text;
				play ].

	^ aScripter
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
	| aScripter |
	aScripter := self
		             scripterWithModel: [ 
		             LeUIExamples new titledPageWithTextSnippets_numbers ]
		             element: [ :aPage | 
			             LePageToolContentTreeElement new pageViewModel:
				             aPage asContentUIModel ].
	^ aScripter syncContinue
]

{ #category : #'examples - page - text snippets' }
LeTextSnippetByScripterExamples >> scrollDownEnumeradedTextSnippets [
	<gtExample>
	| aScripter |
	aScripter := self pageContentElementWithEnumeradedTextSnippets.
	aScripter
		substeps: 'Scroll down and check snippet element contents'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			8
				timesRepeat: [ 
					anIndex := anIndex + 1.
					
					self moveDownTextSnippetAt: 1 step: aRootStep. 
					
					self editEveryVisibleTextSnippetIn: aRootStep appending: ' scrollDown'.
					
					aRootStep
						substeps: anIndex asString , ' scroll and snippet element content'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll down text snippets';
								downBy: 25;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement.
							aStep wait forEmptySpaceTaskQueueTimeout: 1 seconds.
							
							self assertTextSnippetElementContentIn: aStep. ] ] ].
	^ aScripter syncContinue
]

{ #category : #'examples - page - text snippets' }
LeTextSnippetByScripterExamples >> scrollUpEnumeradedTextSnippets [
	<gtExample>
	| aScripter |
	aScripter := self scrollDownEnumeradedTextSnippets.
	aScripter
		substeps: 'Scroll up and check snippet element contents'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			8
				timesRepeat: [ 
					anIndex := anIndex + 1.
					
					self editEveryVisibleTextSnippetIn: aRootStep appending: ' scrollUp'.
					
					aRootStep
						substeps: anIndex asString , ' scroll and snippet element content'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll down text snippets';
								upBy: 25;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement.
							aStep wait forEmptySpaceTaskQueueTimeout: 1 seconds.
							
							self assertTextSnippetElementContentIn: aStep ] ] ].
	^ aScripter syncContinue
]

{ #category : #'examples - by scripter' }
LeTextSnippetByScripterExamples >> textSnippetElement [
	<gtExample>
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
	| aScripter |
	aScripter := self textSnippetElement.
	
	aScripter substep: 'Insert text' do: [ :aStep |
		aStep do
			label: 'Insert text';
			block: [ :anEditor |
				| aText |
				aText := anEditor text.
				aText insertString: ' INSERTED ' at: 5 ];
			onBreadthFirstChildOfClass: GtTextualCoderEditorElement.
		aStep wait forEmptySpaceTaskQueue.
		
		aStep check
			label: 'Check whether text editor and text snippet have different BlText instances';
			satisfies: [ :anEditor | 
				anEditor text ~~ aScripter model text ] 
			description: [ 'Text editor must not share same BlText instance with the block model' ];
			onBreadthFirstChildOfClass: GtTextualCoderEditorElement.

		aStep check
			label: 'Text editor have same text content as snippet';
			satisfies: [ :anEditor | 
				anEditor text characters = aScripter model text characters ] 
			description: [ 'Text editor must have same content as the snippet' ];
			onBreadthFirstChildOfClass: GtTextualCoderEditorElement.
			
	].
	
	^ aScripter syncContinue
]
