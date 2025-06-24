"
I exemplify {{gtClass:LePage}} styling.
I particularly exemplify {{gtClass:LeTextSnippet}} styling. For example the [feenkcom/gtoolkit#3212](https://github.com/feenkcom/gtoolkit/issues/3212) issue is exemplified using:
 {{gtExample: LeUIStylingPageByScripterExamples >> #pageClickOnTheFirstPageWorldTab | codeExpanded=false}}
"
Class {
	#name : #LeUIStylingPageByScripterExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Examples'
}

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> assertStep: aRootStep label: aStepLabel snippetIndex: aSnippetIndex annotationFrom: aStartIndex to: aStopIndex isHidden: isHidden [
	<gtExample>
	aRootStep
		substeps: aStepLabel
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert text start index (' , aStartIndex asString , ')';
						value: [ :anEditor | 
								(anEditor text from: aStartIndex to: aStartIndex)
									hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ]
							equals: [ isHidden ];
						// LePageToolContentTreeElement;
						// LePageSnippetsTreeElementId;
						id: LeSnippetElementId index: aSnippetIndex;
						// BrTextEditorParagraphElement ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert text stop index (' , aStopIndex asString , ')';
						value: [ :anEditor | 
								(anEditor text from: aStopIndex to: aStopIndex)
									hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ]
							equals: [ isHidden ];
						// LePageToolContentTreeElement;
						// LePageSnippetsTreeElementId;
						id: LeSnippetElementId index: aSnippetIndex;
						// BrTextEditorParagraphElement ].

			aStartIndex > 1
				ifTrue: [ aStep
						assertStep: [ :s | 
							s
								label: 'Assert before text start index (' , (aStartIndex - 1) asString , ')';
								value: [ :anEditor | 
										(anEditor text from: aStartIndex - 1 to: aStartIndex - 1)
											hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ]
									equals: [ isHidden not ];
								// LePageToolContentTreeElement;
								// LePageSnippetsTreeElementId;
								id: LeSnippetElementId index: aSnippetIndex;
								// BrTextEditorParagraphElement ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert after text stop index (' , (aStopIndex + 1) asString , ')';
						value: [ :anEditor | 
								anEditor text size > aStopIndex
									ifFalse: [ isHidden not ]
									ifTrue: [ (anEditor text from: aStopIndex + 1 to: aStopIndex + 1)
											hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ] ]
							equals: [ isHidden not ];
						// LePageToolContentTreeElement;
						// LePageSnippetsTreeElementId;
						id: LeSnippetElementId index: aSnippetIndex;
						// BrTextEditorParagraphElement ] ]
]

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> assertStep: aStep snippetIndex: aSnippetIndex attributeId: anId labelValue: aValuable [
	aStep
		assertStep: [ :s | 
			s
				label: 'Assert attribute label';
				value: [ :aButton | aButton label asString ] equals: aValuable;
				// LePageToolContentTreeElement;
				// LePageSnippetsTreeElementId;
				id: LeSnippetElementId index: aSnippetIndex;
				// anId ]
]

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> assertStep: aStep snippetIndex: aSnippetIndex elementIdExists: anId [
	<gtExample>
	aStep
		assertStep: [ :s | 
			s
				label: 'Assert example preview exists';
				exists;
				// LePageToolContentTreeElement;
				// LePageSnippetsTreeElementId;
				id: LeSnippetElementId index: aSnippetIndex;
				// anId ]
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> newMemoryLogger [
	^ MemoryLogger new
		startFor: 
			BrTextStylerAsyncStrategySignal ,
			BrAsyncElementFutureSignal,
			BrElementUpdaterSignal,
			GtTextualCoderEditorElementSignal
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageClickOnTheFirstPageWorldTab [
	<gtExample>
	<return: #BlScripter>
	| aScripter aLogger |
	aScripter := self pageSecondTimeInWorldTab.

	aLogger := self newMemoryLogger name: '02 Display the page again'.
	aScripter userData at: #pageClickOnTheFirstPageWorldTab put: aLogger.

	[ aScripter
		substep: 'Display the first page tab'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on the second world tab';
						// GtWorldTabGroupId;
						/ #header;
						// #tabbar;
						onChildFromBlock: [ :aTabbar | aTabbar children second ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page in a new tab';
						value: [ :anElement | anElement tabs tabs size ] equals: 3 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab selection';
						satisfies: [ :anElement | anElement tabs tabs second isSelected ]
							description: [ 'Page tab must be selected' ] ] ] ]
		ensure: [ aLogger stop ].

	self
		assertStep: aScripter
		snippetIndex: 1
		attributeId: (LeTextSnippetAttributeLabelElementId indexed: 1)
		labelValue: LeUIDummyExamples new number asString.

	self
		assertStep: aScripter
		snippetIndex: 1
		elementIdExists: (LeTextSnippetAttributeExampleElementId indexed: 2).

	self
		assertStep: aScripter
		label: 'Assert the second example annotation is hidden'
		snippetIndex: 1
		annotationFrom: 153
		to: 227
		isHidden: true.

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageIntoWorldTab [
	<gtExample>
	<return: #BlScripter>
	| aScripter aLogger |
	aScripter := GtWorldByScripterExamples new tabElementInScripter.

	aLogger := self newMemoryLogger name: '01 Display page'.
	aScripter userData at: #pageIntoWorldTab put: aLogger.

	[ aScripter
		substep: 'Add page into a world tab'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Show Coder space';
						block: [ :aTabElement | 
							| aStencil |
							aStencil := [ | aPage |
								aPage := self pageOneWithText.
								LeUIByScripterExamples new pageInPager: aPage ] asStencil.
							BlSpace new
								icon: BrGlamorousVectorIcons transparent;
								title: 'Lepiter Page';
								addChild: aStencil asElement;
								showFrom: aTabElement ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page in a new tab';
						value: [ :anElement | anElement tabs tabs size ] equals: 2 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: 'Page One' ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab selection';
						satisfies: [ :anElement | anElement tabs tabs second isSelected ]
							description: [ 'Page tab must be selected' ] ] ] ]
		ensure: [ aLogger stop ].

	self
		assertStep: aScripter
		snippetIndex: 1
		attributeId: (LeTextSnippetAttributeLabelElementId indexed: 1)
		labelValue: LeUIDummyExamples new number asString.

	self
		assertStep: aScripter
		snippetIndex: 1
		elementIdExists: (LeTextSnippetAttributeExampleElementId indexed: 2).

	self
		assertStep: aScripter
		label: 'Assert the second example annotation is hidden'
		snippetIndex: 1
		annotationFrom: 153
		to: 227
		isHidden: true.

	^ aScripter
]

{ #category : #'examples - model' }
LeUIStylingPageByScripterExamples >> pageOneWithClass [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := LeUIByScripterExamples new pageOne.

	aPage snippetBuilder
		string: '{{gtClass:Object}}';
		add.

	^ aPage
]

{ #category : #'examples - model' }
LeUIStylingPageByScripterExamples >> pageOneWithPackage [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := LeUIByScripterExamples new pageOne.

	aPage snippetBuilder
		string: '{{gtPackage:Kernel}}';
		add.

	^ aPage
]

{ #category : #'examples - model' }
LeUIStylingPageByScripterExamples >> pageOneWithText [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := LeUIByScripterExamples new pageOne.

	aPage snippetBuilder
		string: self textWithExampleAnnotations;
		add.

	^ aPage
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageSecondTimeInWorldTab [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageIntoWorldTab.

	aScripter
		substep: 'Add page into a world tab'
		do: [ :aStep | 
			aStep clickStep: [ :s | s // LeOpenPageInNewWorldTabElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page in a new tab';
						value: [ :anElement | anElement tabs tabs size ] equals: 3 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab label';
						value: [ :anElement | anElement tabs tabs third widget label asString ]
							equals: 'Page One' ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab selection';
						satisfies: [ :anElement | anElement tabs tabs third isSelected ]
							description: [ 'Page tab must be selected' ] ] ].

	self
		assertStep: aScripter
		snippetIndex: 1
		attributeId: (LeTextSnippetAttributeLabelElementId indexed: 1)
		labelValue: LeUIDummyExamples new number asString.

	self
		assertStep: aScripter
		snippetIndex: 1
		elementIdExists: (LeTextSnippetAttributeExampleElementId indexed: 2).

	self
		assertStep: aScripter
		label: 'Assert the second example annotation is hidden'
		snippetIndex: 1
		annotationFrom: 153
		to: 227
		isHidden: true.

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageSwitchToTheFirstWorldTabThenBackToTheSecondWorldTab [
	<gtExample>
	<return: #BlScripter>
	| aScripter aLogger |
	aScripter := self pageIntoWorldTab.

	aScripter
		substep: 'Display the first tab'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on the first world tab';
						// GtWorldTabGroupId;
						/ #header;
						// #tabbar;
						onChildFromBlock: [ :aTabbar | aTabbar children first ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab selection';
						satisfies: [ :anElement | anElement tabs tabs first isSelected ]
							description: [ 'Page tab must be selected' ] ] ].

	aLogger := self newMemoryLogger name: '02 Display the page again'.
	aScripter userData
		at: #pageSwitchToTheFirstWorldTabThenBackToTheSecondWorldTab
		put: aLogger.

	[ aScripter
		substep: 'Display the second tab'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on the second world tab';
						// GtWorldTabGroupId;
						/ #header;
						// #tabbar;
						onChildFromBlock: [ :aTabbar | aTabbar children second ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab selection';
						satisfies: [ :anElement | anElement tabs tabs second isSelected ]
							description: [ 'Page tab must be selected' ] ] ] ]
		ensure: [ aLogger stop ].

	self
		assertStep: aScripter
		snippetIndex: 1
		attributeId: (LeTextSnippetAttributeLabelElementId indexed: 1)
		labelValue: LeUIDummyExamples new number asString.

	self
		assertStep: aScripter
		snippetIndex: 1
		elementIdExists: (LeTextSnippetAttributeExampleElementId indexed: 2).

	self
		assertStep: aScripter
		label: 'Assert the second example annotation is hidden'
		snippetIndex: 1
		annotationFrom: 153
		to: 227
		isHidden: true.

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageWithClassClicked [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageWithClassIntoWorldTab.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link container';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that page was spawned';
				id: #content;
				onChildAt: 1;
				onChildAt: 1;
				value: [ :aPager | aPager pages size ] equals: 2 ].

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageWithClassIntoWorldTab [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := GtWorldByScripterExamples new tabElementInScripter.

	aScripter
		substep: 'Create page with class link'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Show Coder space';
						block: [ :aTabElement | 
							| aStencil |
							aStencil := [ | aPage |
								aPage := self pageOneWithClass.
								LeUIByScripterExamples new pageInPager: aPage ] asStencil.
							BlSpace new
								icon: BrGlamorousVectorIcons transparent;
								title: 'Lepiter Page';
								addChild: aStencil asElement;
								showFrom: aTabElement ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page in a new tab';
						value: [ :anElement | anElement tabs tabs size ] equals: 2 ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab label';
						value: [ :anElement | anElement tabs tabs second widget label asString ]
							equals: 'Page One' ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert page tab selection';
						satisfies: [ :anElement | anElement tabs tabs second isSelected ]
							description: [ 'Page tab must be selected' ] ] ].

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageWithClassPrimaryClicked [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageWithClassIntoWorldTab.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link container';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link';
				modifiers: BlKeyModifiers primary;
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that tab was spawned';
				satisfies: [ :aWorld | aWorld tabs tabs size = 3 ] ].

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageWithPackageClicked [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageWithPackageIntoWorldTab.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link container';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that page was spawned';
				id: #content;
				onChildAt: 1;
				onChildAt: 1;
				satisfies: [ :aPager | aPager pages size = 2 ] ].

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageWithPackageIntoWorldTab [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := GtWorldByScripterExamples new tabElementInScripter.

	aScripter
		doStep: [ :s | 
			s
				label: 'Show Coder space';
				block: [ :aTabElement | 
					| aStencil |
					aStencil := [ | aPage |
						aPage := self pageOneWithClass.
						LeUIByScripterExamples new pageInPager: aPage ] asStencil.
					BlSpace new
						icon: BrGlamorousVectorIcons transparent;
						title: 'Lepiter Page';
						addChild: aStencil asElement;
						showFrom: aTabElement ] ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert page in a new tab';
				value: [ :anElement | anElement tabs tabs size ] equals: 2 ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert page tab label';
				value: [ :anElement | anElement tabs tabs second widget label asString ]
					equals: 'Page One' ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert page tab selection';
				satisfies: [ :anElement | anElement tabs tabs second isSelected ]
					description: [ 'Page tab must be selected' ] ].

	^ aScripter
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageWithPackagePrimaryClicked [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageWithPackageIntoWorldTab.

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link container';
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		clickStep: [ :s | 
			s
				label: 'Click link';
				modifiers: BlKeyModifiers primary;
				id: #content;
				id: #scrollable;
				onChildAt: 1 ].

	aScripter
		checkStep: [ :s | 
			s
				label: 'Check that tab was spawned';
				satisfies: [ :aWorld | aWorld tabs tabs size = 3 ] ].

	^ aScripter
]

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> step: aRootStep label: aStepLabel snippetIndex: aSnippetIndex annotationFrom: aStartIndex to: aStopIndex isHidden: isHidden [
	<gtExample>
	aRootStep
		substeps: aStepLabel
		do: [ :aStep | 
			aStep
				assertStep: [ :s | 
					s
						label: 'Assert text start index (' , aStartIndex asString , ')';
						value: [ :anEditor | 
								(anEditor text from: aStartIndex to: aStartIndex)
									hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ]
							equals: [ isHidden ];
						// LePageToolContentTreeElement;
						// LePageSnippetsTreeElementId;
						id: LeSnippetElementId index: aSnippetIndex;
						// BrTextEditorParagraphElement ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert text stop index (' , aStopIndex asString , ')';
						value: [ :anEditor | 
								(anEditor text from: aStopIndex to: aStopIndex)
									hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ]
							equals: [ isHidden ];
						// LePageToolContentTreeElement;
						// LePageSnippetsTreeElementId;
						id: LeSnippetElementId index: aSnippetIndex;
						// BrTextEditorParagraphElement ].

			aStartIndex > 1
				ifTrue: [ aStep
						assertStep: [ :s | 
							s
								label: 'Assert before text start index (' , (aStartIndex - 1) asString , ')';
								value: [ :anEditor | 
										(anEditor text from: aStartIndex - 1 to: aStartIndex - 1)
											hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ]
									equals: [ isHidden not ];
								// LePageToolContentTreeElement;
								// LePageSnippetsTreeElementId;
								id: LeSnippetElementId index: aSnippetIndex;
								// BrTextEditorParagraphElement ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert after text stop index (' , (aStopIndex + 1) asString , ')';
						value: [ :anEditor | 
								anEditor text size > aStopIndex
									ifFalse: [ isHidden not ]
									ifTrue: [ (anEditor text from: aStopIndex + 1 to: aStopIndex + 1)
											hasAttributeSuchThat: [ :anAttribute | anAttribute class = BrTextHideAttribute ] ] ]
							equals: [ isHidden not ];
						// LePageToolContentTreeElement;
						// LePageSnippetsTreeElementId;
						id: LeSnippetElementId index: aSnippetIndex;
						// BrTextEditorParagraphElement ] ]
]

{ #category : #'examples - example annotations' }
LeUIStylingPageByScripterExamples >> textSnippetWithExampleAnnotations [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := LeUIByScripterExamples new emptyPageElementInPager.

	aScripter
		typeStep: [ :s | 
			s
				label: 'Type text with example annotations';
				text: self textWithExampleAnnotations ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert that the written text is stored in the text snippet';
				value: [ :aDatabase | aDatabase pages first children first text asString ]
					equals: [ self textWithExampleAnnotations asString ];
				onModel ].

	self
		assertStep: aScripter
		snippetIndex: 1
		attributeId: (LeTextSnippetAttributeLabelElementId indexed: 1)
		labelValue: LeUIDummyExamples new number asString.

	self
		assertStep: aScripter
		snippetIndex: 1
		elementIdExists: (LeTextSnippetAttributeExampleElementId indexed: 2).

	self
		assertStep: aScripter
		label: 'Assert the second example annotation is hidden'
		snippetIndex: 1
		annotationFrom: 153
		to: 227
		isHidden: true.

	^ aScripter
]

{ #category : #'examples - example annotations' }
LeUIStylingPageByScripterExamples >> textWithExampleAnnotations [
	<gtExample>
	<return: #ByteString>
	^ 'I am a number of the following value: {{gtExample: '
		, LeUIDummyExamples name , ' >> #'
		, (LeUIDummyExamples >> #number) selector asString
		, ' | label=#yourself}}. I can also be displayed using embedded inspectors: {{gtExample: '
		, LeUIDummyExamples name , ' >> #'
		, (LeUIDummyExamples >> #number) selector asString
		, ' | noCode | previewHeight = 250 }}. '
]
