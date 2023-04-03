Class {
	#name : #LeUIStylingPageByScripterExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Examples'
}

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> assertStep: aRootStep label: aStepLabel snippetIndex: aSnippetIndex annotationFrom: aStartIndex to: aStopIndex isHidden: isHidden [
	<gtExample>
	aRootStep substeps: aStepLabel do: [ :aStep | 
		aStep assert
			label: 'Assert text start index (', aStartIndex asString, ')';
			value: [ :anEditor | 
				(anEditor text from: aStartIndex to: aStartIndex)
					hasAttributeSuchThat: [ :anAttribute | 
						anAttribute class = BrTextHideAttribute ] ]
				equals: [ isHidden ];
			// LePageToolContentTreeElement;
			// LePageSnippetsTreeElementId;
			id: LeSnippetElementId index: aSnippetIndex;
			// BrTextEditorParagraphElement;
			play.
			
		aStep assert
			label: 'Assert text stop index (', aStopIndex asString ,')';
			value: [ :anEditor | 
				(anEditor text from: aStopIndex to: aStopIndex)
					hasAttributeSuchThat: [ :anAttribute | 
						anAttribute class = BrTextHideAttribute ] ]
				equals: [ isHidden ];
			// LePageToolContentTreeElement;
			// LePageSnippetsTreeElementId;
			id: LeSnippetElementId index: aSnippetIndex;
			// BrTextEditorParagraphElement;
			play.
			
		aStartIndex > 1 ifTrue: [ 
			aStep assert
				label: 'Assert before text start index (', (aStartIndex - 1) asString, ')';
				value: [ :anEditor | 
					(anEditor text from: aStartIndex - 1 to: aStartIndex - 1)
						hasAttributeSuchThat: [ :anAttribute | 
							anAttribute class = BrTextHideAttribute ] ]
					equals: [ isHidden not ];
				// LePageToolContentTreeElement;
				// LePageSnippetsTreeElementId;
				id: LeSnippetElementId index: aSnippetIndex;
				// BrTextEditorParagraphElement;
				play ].
				
		aStep assert
				label: 'Assert after text stop index (', (aStopIndex + 1) asString, ')';
				value: [ :anEditor | 
					anEditor text size > aStopIndex
						ifFalse: [ isHidden not ]
						ifTrue: [
							(anEditor text from: aStopIndex + 1 to: aStopIndex + 1)
								hasAttributeSuchThat: [ :anAttribute | 
									anAttribute class = BrTextHideAttribute ] ] ]
					equals: [ isHidden not ];
				// LePageToolContentTreeElement;
				// LePageSnippetsTreeElementId;
				id: LeSnippetElementId index: aSnippetIndex;
				// BrTextEditorParagraphElement;
				play ]
]

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> assertStep: aStep snippetIndex: aSnippetIndex attributeId: anId labelValue: aValuable [ 

	aStep assert
		label: 'Assert attribute label';
		value: [ :aButton | aButton label asString ] 
			equals: aValuable;
		// LePageToolContentTreeElement;
		// LePageSnippetsTreeElementId;
		id: LeSnippetElementId index: aSnippetIndex;
		// anId;
		play.
]

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> assertStep: aStep snippetIndex: aSnippetIndex elementIdExists: anId [
	<gtExample>

	aStep assert
		label: 'Assert example preview exists';
		exists;
		// LePageToolContentTreeElement;
		// LePageSnippetsTreeElementId;
		id: LeSnippetElementId index: aSnippetIndex;
		// anId;
		play.
]

{ #category : #accessing }
LeUIStylingPageByScripterExamples >> pageIntoWorldTab [
	<gtExample>
	| aScripter |

	aScripter := GtWorldByScripterExamples new tabElementInScripter.	
	
	aScripter substep: 'Add page into a world tab' do: [ :aStep |
		aStep do
			label: 'Show Coder space';
			block: [ :aTabElement | 
				| aStencil |
				aStencil := [
						| aPage |
						aPage := self pageOneWithText.
						LeUIByScripterExamples new pageInPager: aPage 
					] asStencil.
				
				GtWorldUtility 
					showSpaceWithIcon: BrGlamorousVectorIcons transparent 
					title: 'Lepiter Page'
					with: aStencil 
					from: aTabElement ];
			play.
			
		aStep assert
			label: 'Assert page in a new tab';
			value: [ :anElement | anElement tabs tabs size ] equals: 2;
			play.
			
		aStep assert 
			label: 'Assert page tab label';
			value: [ :anElement | anElement tabs tabs second widget label asString ]
				equals: 'Page One';
			play.

		aStep assert 
			label: 'Assert page tab selection';
			satisfies: [ :anElement | anElement tabs tabs second isSelected ]
				description: [ 'Page tab must be selected' ];
			play ].
			
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
LeUIStylingPageByScripterExamples >> pageOneWithText [
	<gtExample>
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
	| aScripter |

	aScripter := self pageIntoWorldTab.	
	
	aScripter substep: 'Add page into a world tab' do: [ :aStep |
		aStep click
			// LeOpenPageInNewWorldTabElementId;
			play.
			
		aStep assert
			label: 'Assert page in a new tab';
			value: [ :anElement | anElement tabs tabs size ] equals: 3;
			play.
			
		aStep assert 
			label: 'Assert page tab label';
			value: [ :anElement | 
					anElement tabs tabs third widget label asString ]
				equals: 'Page One';
			play.

		aStep assert 
			label: 'Assert page tab selection';
			satisfies: [ :anElement | anElement tabs tabs third isSelected ]
				description: [ 'Page tab must be selected' ];
			play ].
			
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

{ #category : #'examples - support' }
LeUIStylingPageByScripterExamples >> step: aRootStep label: aStepLabel snippetIndex: aSnippetIndex annotationFrom: aStartIndex to: aStopIndex isHidden: isHidden [
	<gtExample>
	aRootStep substeps: aStepLabel do: [ :aStep | 
		aStep assert
			label: 'Assert text start index (', aStartIndex asString, ')';
			value: [ :anEditor | 
				(anEditor text from: aStartIndex to: aStartIndex)
					hasAttributeSuchThat: [ :anAttribute | 
						anAttribute class = BrTextHideAttribute ] ]
				equals: [ isHidden ];
			// LePageToolContentTreeElement;
			// LePageSnippetsTreeElementId;
			id: LeSnippetElementId index: aSnippetIndex;
			// BrTextEditorParagraphElement;
			play.
			
		aStep assert
			label: 'Assert text stop index (', aStopIndex asString ,')';
			value: [ :anEditor | 
				(anEditor text from: aStopIndex to: aStopIndex)
					hasAttributeSuchThat: [ :anAttribute | 
						anAttribute class = BrTextHideAttribute ] ]
				equals: [ isHidden ];
			// LePageToolContentTreeElement;
			// LePageSnippetsTreeElementId;
			id: LeSnippetElementId index: aSnippetIndex;
			// BrTextEditorParagraphElement;
			play.
			
		aStartIndex > 1 ifTrue: [ 
			aStep assert
				label: 'Assert before text start index (', (aStartIndex - 1) asString, ')';
				value: [ :anEditor | 
					(anEditor text from: aStartIndex - 1 to: aStartIndex - 1)
						hasAttributeSuchThat: [ :anAttribute | 
							anAttribute class = BrTextHideAttribute ] ]
					equals: [ isHidden not ];
				// LePageToolContentTreeElement;
				// LePageSnippetsTreeElementId;
				id: LeSnippetElementId index: aSnippetIndex;
				// BrTextEditorParagraphElement;
				play ].
				
		aStep assert
				label: 'Assert after text stop index (', (aStopIndex + 1) asString, ')';
				value: [ :anEditor | 
					anEditor text size > aStopIndex
						ifFalse: [ isHidden not ]
						ifTrue: [
							(anEditor text from: aStopIndex + 1 to: aStopIndex + 1)
								hasAttributeSuchThat: [ :anAttribute | 
									anAttribute class = BrTextHideAttribute ] ] ]
					equals: [ isHidden not ];
				// LePageToolContentTreeElement;
				// LePageSnippetsTreeElementId;
				id: LeSnippetElementId index: aSnippetIndex;
				// BrTextEditorParagraphElement;
				play ]
]

{ #category : #'examples - example annotations' }
LeUIStylingPageByScripterExamples >> textSnippetWithExampleAnnotations [
	<gtExample>
	| aScripter |
	aScripter := LeUIByScripterExamples new emptyPageElementInPager.

	aScripter type
		label: 'Type text with example annotations';
		text: self textWithExampleAnnotations;
		play.

	aScripter assert
		label: 'Assert that the written text is stored in the text snippet';
		value: [ :aDatabase | aDatabase pages first children first text asString ]
			equals: [ self textWithExampleAnnotations asString ];
		onModel;
		play.
		
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
	
	^ 'I am a number of the following value: {{gtExample: '
		, LeUIDummyExamples name,' >> #'
		, (LeUIDummyExamples >> #number) selector asString
		,' | label=#yourself}}. I can also be displayed using embedded inspectors: {{gtExample: '
		, LeUIDummyExamples name,' >> #'
		, (LeUIDummyExamples >> #number) selector asString
		,' | noCode | previewHeight = 250 }}. '
]
