"
I exemplify {{gtPackage:Lepiter-Snippet-Picture}} using {{gtClass:BlDevScripter}}.
"
Class {
	#name : #LePictureByScripterExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #'examples - ui' }
LePictureByScripterExamples >> acceptUrl: aParentStep [
	aParentStep
		substeps: 'Accept picture URL'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						// LePictureSnippetElement;
						// LePictureSnippetAcceptUrlElementId ] ]
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> addPictureSnippetAfterTheFirstSnippet [
	<gtExample>
	| aScripter |
	
	aScripter := LeUIByScripterExamples new emptyPageElement.

	LeUIByScripterExamples addSnippetNamed: 'Picture' step: aScripter.
	
	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> displayedImage [
	"It takes too much time to download the image
	and we therefore do not want to run it by default."

	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self filledValues.

	self acceptUrl: aScripter.

	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> filledValues [
	<gtExample>
	| aScripter |
	aScripter := self addPictureSnippetAfterTheFirstSnippet.
	
	self typePictureUrl: aScripter.
	self typePictureCaption: aScripter.
	self resizeImage: aScripter.

	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> imageHeight [
	^ 300
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageWithPictureReference [
	<gtExample>
	| aPage aScripter aReferenceButtonQuery |
	aPage := LePictureAnnotationStylerExamples new styleReferenceKeyAndValue.
	aScripter := BlScripter new.
	aScripter model: aPage.
	aScripter element: (aPage asLepiterPagePhlowTool asElementDo: [ :e | e ]).

	aReferenceButtonQuery := aScripter root query // LeTextCoderSnippetElement
			// GtSourceCoderEditorId // BrButton.
	self assert: aReferenceButtonQuery result size equals: 1.
	self
		assert: aReferenceButtonQuery anyOne label asString
		equals: (LePictureAnnotationStyler buttonLabelTemplate format: {1}).

	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> pictureCaption [
	^ 'Glamorous Toolkit overview'
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> pictureTitle [
	^ 'Glamorous Toolkit overview'
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> pictureUrl [
	^ 'https://feenk.com/assets/pictures/gtr-overview-square1.png'
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> resizeImage [
	<gtExample>
	| aScripter |
	aScripter := self addPictureSnippetAfterTheFirstSnippet.

	self resizeImage: aScripter.

	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> resizeImage: aParentStep [
	<gtExample>
	aParentStep
		substeps: 'Resize image'
		do: [ :aStep | 
			aStep
				doStep: [ :s | 
					s
						label: 'Set image height';
						block: [ :anImageElement | (BrResizerElementLength exact: self imageHeight) adjustHeightFor: anImageElement ];
						// LePictureSnippetElement;
						// LePictureSnippetImageContainerElementId;
						/ #imageElement ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert image height';
						value: [ :anImageElement | anImageElement height ]
							equals: [ self imageHeight ];
						// LePictureSnippetElement;
						// LePictureSnippetImageContainerElementId;
						/ #imageElement ] ]
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> typePictureCaption [
	<gtExample>
	| aScripter |
	aScripter := self addPictureSnippetAfterTheFirstSnippet.
	
	self typePictureCaption: aScripter.

	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> typePictureCaption: aParentStep [
	aParentStep
		substeps: 'Type picture caption'
		do: [ :aStep | 
			aStep requestFocus
				// LePictureSnippetElement;
				// LePictureSnippetCaptionEditorElementId;
				play.

			aStep
				typeStep: [ :s | 
					s
						text: self pictureCaption ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert caption editor text';
						value: [ :anCaptionEditor | anCaptionEditor text asString ]
							equals: [ self pictureCaption ];
						// LePictureSnippetElement;
						// LePictureSnippetCaptionEditorElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert snippet caption value';
						value: [ :aPictureElement | aPictureElement snippet caption ]
							equals: [ self pictureCaption ];
						// LePictureSnippetElement ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert caption editor text';
						value: [ :aCaptionLabel | aCaptionLabel text asString ]
							equals: [ self pictureCaption ];
						// LePictureSnippetElement;
						// LePictureSnippetCaptionLabelElementId ] ]
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> typePictureUrl [
	<gtExample>
	| aScripter |
	aScripter := self addPictureSnippetAfterTheFirstSnippet.

	self typePictureUrl: aScripter.

	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> typePictureUrl: aParentStep [
	<gtExample>
	aParentStep
		substeps: 'Type picture URL'
		do: [ :aStep | 
			aStep requestFocus
				// LePictureSnippetElement;
				// LePictureSnippetUrlEditorElementId;
				play.

			aStep
				typeStep: [ :s | 
					s
						text: self pictureUrl ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert URL editor text';
						value: [ :anUrlEditor | anUrlEditor text asString ]
							equals: [ self pictureUrl ];
						// LePictureSnippetElement;
						// LePictureSnippetUrlEditorElementId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert snippet URL value';
						value: [ :aPictureElement | aPictureElement snippet urlString ]
							equals: [ self pictureUrl ];
						// LePictureSnippetElement ] ]
]
