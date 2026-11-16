"
I exemplify how a `gtPictureReference` annotation ({{gtClass:LePictureAnnotationNode}}) finds its picture snippet with {{gtMethod:LePictureSnippetReference class>>#forReference:inPage:}}.
The editor ({{gtMethod:LeSnippetStyler>>#pictureSnippetWithReference:}}) and the HTML export use the same lookup, so both show the same label ({{gtMethod:LePictureSnippetReference>>#label}}), for example ""Figure 1"" or ""Figure <caption>"".
Pictures are numbered across the database in table of contents order, or across the page if the page has no database, see {{gtExample:LePictureSnippetReferenceExamples>>#referenceInPageWithoutDatabase}}.
"
Class {
	#name : #LePictureSnippetReferenceExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #'examples - database' }
LePictureSnippetReferenceExamples >> databaseWithPictures [
	"A database with two pages.
	The page named 'Pictures' has two picture snippets, 'fig1' without a caption and 'fig2' with a caption.
	The page named 'Other page' has no pictures."

	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPicturesPage anOtherPage |
	aDatabase := LeDatabase new.

	aPicturesPage := LePage named: self picturesPageTitle.
	aDatabase addPage: aPicturesPage.
	aPicturesPage
		addSnippet: (LePictureSnippet new
				urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
				reference: 'fig1').
	aPicturesPage
		addSnippet: (LePictureSnippet new
				urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
				caption: 'Glamorous Toolkit';
				reference: 'fig2').

	anOtherPage := LePage named: self otherPageTitle.
	aDatabase addPage: anOtherPage.
	anOtherPage addSnippet: (LeTextSnippet string: 'No pictures here').

	self assert: (aDatabase pageNamed: self picturesPageTitle) equals: aPicturesPage.
	self assert: (aDatabase pageNamed: self otherPageTitle) equals: anOtherPage.

	^ aDatabase

]

{ #category : #'examples - database' }
LePictureSnippetReferenceExamples >> otherPageTitle [
	^ 'Other page'

]

{ #category : #'examples - without database' }
LePictureSnippetReferenceExamples >> pageWithoutDatabase [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := LePage named: 'Pictures without database'.
	aPage
		addSnippet: (LePictureSnippet new
				urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
				reference: 'fig1').
	aPage addSnippet: (LeTextSnippet string: 'See {{gtPictureReference:missing}} here').

	self assert: aPage database isDatabase not.

	^ aPage

]

{ #category : #'examples - database' }
LePictureSnippetReferenceExamples >> picturesPageTitle [
	^ 'Pictures'

]

{ #category : #'examples - snippet' }
LePictureSnippetReferenceExamples >> referenceForSnippet [
	"A picture snippet knows its own number, the same one gtPictureReference annotations show"

	<gtExample>
	<return: #LePictureSnippetReference>
	| aDatabase aPage aSnippet aReference |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: self picturesPageTitle.
	aSnippet := aPage children second.

	aReference := LePictureSnippetReference forSnippet: aSnippet.

	self assert: aReference notNil.
	self assert: aReference snippetModel equals: aSnippet.
	self assert: aReference reference equals: 'fig2'.
	self assert: aReference index equals: 2.
	self assert: aReference numberLabel equals: 'Figure 2'.
	self assert: aReference label equals: 'Figure Glamorous Toolkit'.
	self assert: aSnippet figureNumberLabel equals: 'Figure 2'.

	^ aReference

]

{ #category : #'examples - snippet' }
LePictureSnippetReferenceExamples >> referenceForSnippetInPageWithoutDatabase [
	"Without a database, pictures are numbered across the page"

	<gtExample>
	<return: #LePictureSnippetReference>
	| aPage aSnippet aReference |
	aPage := LePage named: self picturesPageTitle.
	aPage
		addSnippet: (LePictureSnippet new
				urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png').
	aSnippet := LePictureSnippet new
			urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
			reference: 'fig2'.
	aPage addSnippet: aSnippet.

	aReference := LePictureSnippetReference forSnippet: aSnippet.

	self assert: aReference notNil.
	self assert: aReference index equals: 2.
	self assert: aSnippet figureNumberLabel equals: 'Figure 2'.

	^ aReference

]

{ #category : #'examples - snippet' }
LePictureSnippetReferenceExamples >> referenceForSnippetWithoutPage [
	"A picture snippet that is not in a page has no number"

	<gtExample>
	<return: #LePictureSnippet>
	| aSnippet |
	aSnippet := LePictureSnippet new
			urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
			reference: 'fig1'.

	self assert: (LePictureSnippetReference forSnippet: aSnippet) isNil.
	self assert: aSnippet figureNumberLabel isNil.

	^ aSnippet

]

{ #category : #'examples - without database' }
LePictureSnippetReferenceExamples >> referenceInPageWithoutDatabase [
	"Pages without a database (LeNullDatabase) number only their own pictures"

	<gtExample>
	<return: #LePictureSnippetReference>
	| aPage aReference |
	aPage := self pageWithoutDatabase.

	aReference := LePictureSnippetReference forReference: 'fig1' inPage: aPage.

	self assert: aReference notNil.
	self assert: aReference snippetModel equals: aPage children first.
	self assert: aReference index equals: 1.
	self assert: aReference label equals: 'Figure 1'.

	^ aReference

]

{ #category : #'examples - database' }
LePictureSnippetReferenceExamples >> referenceOnOtherPage [
	"The picture is on another page of the same database"

	<gtExample>
	<return: #LePictureSnippetReference>
	| aDatabase aPicturesPage anOtherPage aReference |
	aDatabase := self databaseWithPictures.
	aPicturesPage := aDatabase pageNamed: self picturesPageTitle.
	anOtherPage := aDatabase pageNamed: self otherPageTitle.

	aReference := LePictureSnippetReference forReference: 'fig1' inPage: anOtherPage.

	self assert: aReference notNil.
	self assert: aReference snippetModel equals: aPicturesPage children first.
	self assert: aReference page equals: aPicturesPage.
	self assert: aReference index equals: 1.
	self assert: aReference label equals: 'Figure 1'.

	^ aReference

]

{ #category : #'examples - database' }
LePictureSnippetReferenceExamples >> referenceOnSamePage [
	<gtExample>
	<return: #LePictureSnippetReference>
	| aDatabase aPage aReference |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: self picturesPageTitle.

	aReference := LePictureSnippetReference forReference: 'fig1' inPage: aPage.

	self assert: aReference notNil.
	self assert: aReference reference equals: 'fig1'.
	self assert: aReference snippetModel equals: aPage children first.
	self assert: aReference page equals: aPage.
	self assert: aReference index equals: 1.
	self assert: aReference hasCaption not.
	self assert: aReference label equals: 'Figure 1'.

	^ aReference

]

{ #category : #'examples - database' }
LePictureSnippetReferenceExamples >> referenceWithCaptionOnSamePage [
	<gtExample>
	<return: #LePictureSnippetReference>
	| aDatabase aPage aReference |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: self picturesPageTitle.

	aReference := LePictureSnippetReference forReference: 'fig2' inPage: aPage.

	self assert: aReference notNil.
	self assert: aReference snippetModel equals: aPage children second.
	self assert: aReference index equals: 2.
	self assert: aReference hasCaption.
	self assert: aReference label equals: 'Figure Glamorous Toolkit'.

	^ aReference

]

{ #category : #'examples - styler' }
LePictureSnippetReferenceExamples >> stylerReferenceWithCaption [
	"The editor styler answers the same reference and label as the shared lookup"

	<gtExample>
	<return: #LePictureSnippetReference>
	| aDatabase aPage aTextSnippet aStyler aReference |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: self picturesPageTitle.
	aTextSnippet := LeTextSnippet string: 'See {{gtPictureReference:fig2}} here'.
	aPage addSnippet: aTextSnippet.
	aStyler := LeSnippetStyler new snippetViewModel: aTextSnippet asSnippetViewModel.

	aReference := aStyler pictureSnippetWithReference: 'fig2'.

	self assert: aReference snippetModel equals: aPage children second.
	self assert: aReference index equals: 2.
	self assert: aReference label equals: 'Figure Glamorous Toolkit'.
	self
		assert: (LePictureAnnotationStyler buttonLabelTemplate format: { aReference caption })
		equals: aReference label.

	^ aReference

]

{ #category : #'examples - without database' }
LePictureSnippetReferenceExamples >> stylerUnresolvedReferenceInPageWithoutDatabase [
	"The editor styler uses the same lookup"

	<gtExample>
	<return: #LeSnippetStyler>
	| aPage aStyler |
	aPage := self pageWithoutDatabase.
	aStyler := LeSnippetStyler new snippetViewModel: aPage children second asSnippetViewModel.

	self assert: (aStyler pictureSnippetWithReference: 'missing') isNil.
	self assert: (aStyler pictureSnippetWithReference: 'fig1') index equals: 1.

	^ aStyler

]

{ #category : #'examples - database' }
LePictureSnippetReferenceExamples >> unresolvedReference [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self databaseWithPictures.

	self
		assert: (LePictureSnippetReference
				forReference: 'missing'
				inPage: (aDatabase pageNamed: self picturesPageTitle)) isNil.
	self
		assert: (LePictureSnippetReference
				forReference: 'missing'
				inPage: (aDatabase pageNamed: self otherPageTitle)) isNil.
	self
		assert: (LePictureSnippetReference
				forReference: nil
				inPage: (aDatabase pageNamed: self picturesPageTitle)) isNil.
	self
		assert: (LePictureSnippetReference forReference: 'fig1' inPage: nil) isNil.

	^ aDatabase

]

{ #category : #'examples - without database' }
LePictureSnippetReferenceExamples >> unresolvedReferenceInPageWithoutDatabase [
	"An unresolved reference in a page without a database answers nil,
	it must not ask the null database for its snippets"

	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := self pageWithoutDatabase.

	self assert: (LePictureSnippetReference forReference: 'missing' inPage: aPage) isNil.

	^ aPage

]
