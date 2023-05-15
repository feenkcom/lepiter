Class {
	#name : #LePageToolContentCanvasElement,
	#superclass : #LePageToolContentElement,
	#instVars : [
		'canvasElement'
	],
	#category : #'Lepiter-UI-! Tool - Page'
}

{ #category : #accessing }
LePageToolContentCanvasElement >> canvasElement [
	^ canvasElement
]

{ #category : #initialization }
LePageToolContentCanvasElement >> initialize [
	super initialize.

	self initializeCanvasElement.

	self addChild: self canvasElement as: #canvas.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit: self headerElement;
		vAnyToFitContent: self headerElement;
		inherit: self canvasElement)
]

{ #category : #initialization }
LePageToolContentCanvasElement >> initializeCanvasElement [
	canvasElement := BlCanvassableElement new.
	canvasElement layout: (BlOnceLayout on: GtGraphRectanglePackLayout new).
	canvasElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	canvasElement addEventHandler: BlSlideHandler new.
]

{ #category : #'api - page view model' }
LePageToolContentCanvasElement >> onPageViewModelChanged [
	| pageSnippetsTreeViewModel |
	super onPageViewModelChanged.

	self canvasElement removeChildren.
	self canvasElement layout isStopped: false.

	pageSnippetsTreeViewModel := LeSnippetsTreeViewModel new
		sharedSnippetContext: self pageViewModel sharedSnippetContext;
		content: self pageViewModel pageModel.

	self canvasElement addChildren: (Array streamContents: [ :aStream |
		pageSnippetsTreeViewModel allChildrenBreadthFirstDo: [ :eachSnippetViewModel |
			|  eachSnippetElement |

			eachSnippetElement := eachSnippetViewModel snippetView asElement
				snippetViewModel: eachSnippetViewModel;
				hExact: 300;
				border: (BlBorder paint: Color gray width: 1);
				margin: (BlInsets all: 20);
				addEventHandler: BlPullHandler new;
				vFitContent.

			aStream nextPut: eachSnippetElement
		]
	]).
]
