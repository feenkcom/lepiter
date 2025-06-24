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
	<return: #BlScripter>
	| aScripter |
	aScripter := LeUIByScripterExamples new emptyPageElement.

	LeUIByScripterExamples addSnippetNamed: 'Picture' step: aScripter.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> assertScripter: aScripter pictureReference: aPictureSnippet [
	| aReferenceButtonQuery |
	aReferenceButtonQuery := (aScripter root query // LeTextCoderSnippetElement
			// GtSourceCoderEditorId // BrButton)
			@ [ :eachButton | 
				eachButton label asString
					= (LePictureAnnotationStyler buttonLabelTemplate format: {aPictureSnippet caption}) ].
	self assert: aReferenceButtonQuery result size equals: 1
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
	<return: #BlScripter>
	| aScripter |
	aScripter := self addPictureSnippetAfterTheFirstSnippet.

	self typePictureUrl: aScripter.
	self typePictureCaption: aScripter.
	self resizeImage: aScripter.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> findPictureReference: aReference inDatabase: aDatabase [
	| aPictureSnippet |
	aPictureSnippet := nil.
	aDatabase snippetsIterator
		snippetsDo: [ :eachSnippet | 
			(eachSnippet isPictureSnippetWithReference: aReference)
				ifTrue: [ self
						assert: aPictureSnippet isNil
						description: [ 'Picture reference is duplicated: {1}' format: {aReference} ].
					aPictureSnippet := eachSnippet ] ].
	self
		assert: aPictureSnippet isNotNil
		description: [ 'Cannot find `{2}` picture reference in database {2}'
				format: {aReference.
						aDatabase} ].

	^ aPictureSnippet
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> imageHeight [
	^ 300
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_reference3 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageOneWithTwoAttachmentPictures_definedReferenceIds.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture3'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture3}} is on [[Page one]].'.
	aPage addFirstSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_reference4 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageOneWithTwoAttachmentPictures_definedReferenceIds.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture4'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture4}} is on [[Page two]].'.
	aPage addFirstSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_toc1_reference3 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageOneWithTwoAttachmentPictures_definedReferenceIds_toc1.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture3'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture3}} is on [[Page one]].'.
	aPage addFirstSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_toc1_reference4 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageOneWithTwoAttachmentPictures_definedReferenceIds_toc1.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture4'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture4}} is on [[Page two]].'.
	aPage addFirstSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_toc2_reference3 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageOneWithTwoAttachmentPictures_definedReferenceIds_toc2.
	aPage := aPageHolder page.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture3}} is on [[Page one]].'.
	aPage addFirstSnippet: aSnippet.
	aPictureSnippet := self
			findPictureReference: 'picture4'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture4}} is on [[Page two]].'.
	aPage addFirstSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_toc2_reference4 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageOneWithTwoAttachmentPictures_definedReferenceIds_toc2.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture4'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture4}} is on [[Page two]].'.
	aPage addFirstSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_reference3 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageTwoWithOneAttachmentPictures_definedReferenceIds.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture3'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture3}} is on [[Page one]].'.
	aPage addSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_reference4 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageTwoWithOneAttachmentPictures_definedReferenceIds.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture4'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture4}} is on [[Page one]].'.
	aPage addSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_toc1_reference3 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageTwoWithOneAttachmentPictures_definedReferenceIds_toc1.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture3'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture3}} is on [[Page one]].'.
	aPage addSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_toc1_reference4 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageTwoWithOneAttachmentPictures_definedReferenceIds_toc1.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture4'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture4}} is on [[Page two]].'.
	aPage addSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_toc2_reference3 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageTwoWithOneAttachmentPictures_definedReferenceIds_toc2.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture3'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture3}} is on [[Page one]].'.
	aPage addSnippet: aSnippet.
	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.
	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_toc2_reference4 [
	<gtExample>
	<return: #BlScripter>
	| aPageHolder aPage aSnippet aScripter aPictureSnippet |
	aPageHolder := LeModelExamples new
			pageTwoWithOneAttachmentPictures_definedReferenceIds_toc2.
	aPage := aPageHolder page.
	aPictureSnippet := self
			findPictureReference: 'picture4'
			inDatabase: aPage database.
	aSnippet := LeTextSnippet new
			string: '{{gtPictureReference:picture4}} is on [[Page two]].'.
	aPage addSnippet: aSnippet.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

	^ aScripter
]

{ #category : #'examples - reference' }
LePictureByScripterExamples >> pageWithPictureReference [
	<gtExample>
	<return: #BlScripter>
	| aPage aScripter aPictureSnippet |
	aPage := LePictureAnnotationStylerExamples new styleReferenceKeyAndValue.
	aPictureSnippet := self
			findPictureReference: 'fig123'
			inDatabase: aPage database.

	aScripter := self scripterWithPage: aPage.
	self assertScripter: aScripter pictureReference: aPictureSnippet.

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
	<return: #BlScripter>
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

{ #category : #'examples - reference' }
LePictureByScripterExamples >> scripterWithPage: aPage [
	| aScripter |
	aScripter := BlScripter new.
	aScripter model: aPage.
	aScripter element: (aPage asLepiterPagePhlowTool asElementDo: [ :e | e ]).
	^ aScripter
]

{ #category : #'examples - ui' }
LePictureByScripterExamples >> typePictureCaption [
	<gtExample>
	<return: #BlScripter>
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
	<return: #BlScripter>
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
