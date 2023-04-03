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
			aStep click
				// LePictureSnippetElement;
				// LePictureSnippetAcceptUrlElementId;
				play ]
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
			aStep do
				label: 'Set image height';
				block: [ :anImageElement | (BrResizerElementLength exact: self imageHeight) adjustHeightFor: anImageElement ];
				// LePictureSnippetElement;
				// LePictureSnippetImageContainerElementId;
				/ #imageElement;
				play.

			aStep assert
				label: 'Assert image height';
				value: [ :anImageElement | anImageElement height ]
					equals: [ self imageHeight ];
				// LePictureSnippetElement;
				// LePictureSnippetImageContainerElementId;
				/ #imageElement;
				play ]
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

			aStep type
				text: self pictureCaption;
				play.

			aStep assert
				label: 'Assert caption editor text';
				value: [ :anCaptionEditor | anCaptionEditor text asString ]
					equals: [ self pictureCaption ];
				// LePictureSnippetElement;
				// LePictureSnippetCaptionEditorElementId;
				play.

			aStep assert
				label: 'Assert snippet caption value';
				value: [ :aPictureElement | aPictureElement snippet caption ]
					equals: [ self pictureCaption ];
				// LePictureSnippetElement;
				play.

			aStep assert
				label: 'Assert caption editor text';
				value: [ :aCaptionLabel | aCaptionLabel text asString ]
					equals: [ self pictureCaption ];
				// LePictureSnippetElement;
				// LePictureSnippetCaptionLabelElementId;
				play ]
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

			aStep type
				text: self pictureUrl;
				play.

			aStep assert
				label: 'Assert URL editor text';
				value: [ :anUrlEditor | anUrlEditor text asString ]
					equals: [ self pictureUrl ];
				// LePictureSnippetElement;
				// LePictureSnippetUrlEditorElementId;
				play.

			aStep assert
				label: 'Assert snippet URL value';
				value: [ :aPictureElement | aPictureElement snippet urlString ]
					equals: [ self pictureUrl ];
				// LePictureSnippetElement;
				play ]
]
