"
I exemplify how `gtPictureReference` annotations ({{gtClass:LePictureAnnotationNode}}) are processed by the text export, the HTML export and the HTML post-abstract visitors.
The HTML export writes the label the editor shows ({{gtMethod:LePictureSnippetReference>>#label}}) as a link to the picture: on the same page, see {{gtExample:LePictureAnnotationExportExamples>>#htmlTextSnippetWithPictureAnnotationOnSamePage}}, on another page, see {{gtExample:LePictureAnnotationExportExamples>>#htmlTextSnippetWithPictureAnnotationOnOtherPage}}.
An unresolved reference is written as a span and logged, see {{gtExample:LePictureAnnotationExportExamples>>#htmlTextSnippetWithPictureAnnotation}}.
The text export creates no resources for them, the picture snippets create their own.
"
Class {
	#name : #LePictureAnnotationExportExamples,
	#superclass : #Object,
	#traits : 'TLeHtmlContentAssertions',
	#classTraits : 'TLeHtmlContentAssertions classTrait',
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #'examples - database' }
LePictureAnnotationExportExamples >> databaseWithPictures [
	<gtExample>
	<return: #LeDatabase>
	^ LePictureSnippetReferenceExamples new databaseWithPictures

]

{ #category : #examples }
LePictureAnnotationExportExamples >> exportTextSnippetWithPictureAnnotation [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor |
	snippet := self textSnippetWithPictureAnnotation.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: LeExportMemoryStore new).

	snippet acceptVisitor: visitor.

	self assert: resources size equals: 0.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #private }
LePictureAnnotationExportExamples >> htmlFor: aSnippet context: aContext [
	| aResources |
	aResources := LeExportResources new.
	aSnippet
		acceptVisitor: (LeExportVisitor new
				context: (LeExportContext new
						resources: aResources;
						fileStore: LeExportMemoryStore new)).
	self assert: aResources size equals: 0.

	aContext resources: aResources.
	^ LeHtmlVisitor new
		context: aContext;
		contentsFor: aSnippet

]

{ #category : #private }
LePictureAnnotationExportExamples >> htmlForPage: aPage context: aContext [
	"Export the resources of aPage (its pictures) and answer the HTML of aPage"

	| aResources |
	aResources := LeExportResources new.
	aPage
		acceptVisitor: (LeExportVisitor new
				context: (LeExportContext new
						resources: aResources;
						fileStore: LeExportMemoryStore new)).

	aContext resources: aResources.
	^ LeHtmlVisitor new
		context: aContext;
		contentsFor: aPage

]

{ #category : #'examples - figure caption' }
LePictureAnnotationExportExamples >> htmlPictureOnOtherPageWithDatabaseFigureNumber [
	"Pictures are numbered across the database, so the first picture of a page may have a higher number"

	<gtExample>
	<return: #LeHtmlContext>
	| aDatabase aPage aContext html |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new otherPageTitle.
	aPage
		addSnippet: (LePictureSnippet new
				urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
				caption: 'Third <picture>';
				reference: 'fig3').
	aContext := LeHtmlContext new
			page: aPage;
			database: aDatabase.

	html := self htmlForPage: aPage context: aContext.

	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption"><span class="picture-snippet-caption-label">Figure 3</span>: Third &lt;picture></figcaption>'.

	^ aContext

]

{ #category : #'examples - figure caption' }
LePictureAnnotationExportExamples >> htmlPictureWithReferenceInPageWithoutDatabase [
	"Without a database, the figure number counts the pictures of the page"

	<gtExample>
	<return: #LeHtmlContext>
	| aPage aContext html |
	aPage := LePage named: 'Pictures without database'.
	aPage
		addSnippet: (LePictureSnippet new
				urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png').
	aPage
		addSnippet: (LePictureSnippet new
				urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
				reference: 'fig2').
	aContext := LeHtmlContext new page: aPage.

	html := self htmlForPage: aPage context: aContext.

	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption"><span class="picture-snippet-caption-label">Figure 2</span></figcaption>'.
	self assert: (html allRangesOfSubstring: '<figcaption') size equals: 1.

	^ aContext

]

{ #category : #'examples - figure caption' }
LePictureAnnotationExportExamples >> htmlPictureWithoutReferenceHasNoFigureNumber [
	"A picture without a reference cannot be referenced, so its caption has no figure number"

	<gtExample>
	<return: #LeHtmlContext>
	| aDatabase aPage aSnippet aContext html |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new otherPageTitle.
	aSnippet := LePictureSnippet new
			urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
			caption: 'Unreferenced'.
	aPage addSnippet: aSnippet.
	self assert: aSnippet hasReference not.
	aContext := LeHtmlContext new
			page: aPage;
			database: aDatabase.

	html := self htmlForPage: aPage context: aContext.

	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption">Unreferenced</figcaption>'.
	self assert: (html includesSubstring: 'picture-snippet-caption-label') not.

	^ aContext

]

{ #category : #'examples - figure caption' }
LePictureAnnotationExportExamples >> htmlPicturesPageWithFigureNumbers [
	"Pictures with a reference show 'Figure N' in their caption, followed by the caption if they have one.
	A gtPictureReference annotation on the same page links to the figure with the same number."

	<gtExample>
	<return: #LeHtmlContext>
	| aDatabase aPage aContext html |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new picturesPageTitle.
	aPage addSnippet: (LeTextSnippet string: 'See {{gtPictureReference:fig1}} here').
	aContext := LeHtmlContext new
			page: aPage;
			database: aDatabase.

	html := self htmlForPage: aPage context: aContext.

	self
		assertHtml: html
		includes: '<figure id="figure-fig1" class="snippet picture-snippet '.
	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption"><span class="picture-snippet-caption-label">Figure 1</span></figcaption>'.
	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption"><span class="picture-snippet-caption-label">Figure 2</span>: Glamorous Toolkit</figcaption>'.
	self
		assertHtml: html
		includes: 'See <a class="annotation annotation-label annotation-label-picture" href="#figure-fig1">Figure 1</a> here'.
	self assert: aContext log asArray size equals: 0.

	^ aContext

]

{ #category : #examples }
LePictureAnnotationExportExamples >> htmlTextSnippetWithPictureAnnotation [
	"The picture3 reference does not exist: the reference is written as a span and the export logs it"

	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| holder snippet context visitor html |
	holder := self exportTextSnippetWithPictureAnnotation.
	snippet := holder snippet.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: holder resources).
	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: 'See <span class="annotation annotation-label annotation-label-picture annotation-label-missing">picture3</span> here'.
	self assert: context log asArray size equals: 1.
	self
		assert: (context log asArray
				allSatisfy: [ :each | each class = LeExportUnresolvedAnnotationLogItem ]).

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - database' }
LePictureAnnotationExportExamples >> htmlTextSnippetWithPictureAnnotationOnOtherPage [
	"The link to a picture on another page uses the page link of that page"

	<gtExample>
	<return: #LeHtmlContext>
	| aDatabase aPicturesPage anOtherPage aSnippet aContext html aPageHref |
	aDatabase := self databaseWithPictures.
	aPicturesPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new picturesPageTitle.
	anOtherPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new otherPageTitle.
	aSnippet := LeTextSnippet string: 'See {{gtPictureReference:fig2}} here'.
	anOtherPage addSnippet: aSnippet.
	aContext := LeHtmlContext new
			page: anOtherPage;
			database: aDatabase.

	html := self htmlFor: aSnippet context: aContext.

	aPageHref := aContext pageLinks
			linkForPage: aPicturesPage
			ifFound: [ :aPageLink | aContext hrefBuilder hrefFromPageLink: aPageLink ]
			ifNone: [ nil ].
	self assert: aPageHref notNil.
	self assert: (aPageHref endsWith: '.html').
	self
		assertHtml: html
		includes: 'See <a class="annotation annotation-label annotation-label-picture" href="'
				, aPageHref , '#figure-fig2">Figure Glamorous Toolkit</a> here'.
	self assert: aContext log asArray size equals: 0.

	^ aContext

]

{ #category : #'examples - database' }
LePictureAnnotationExportExamples >> htmlTextSnippetWithPictureAnnotationOnPageWithoutPageLink [
	"The page of the picture is not exported (it has no page link), so the label is not a link"

	<gtExample>
	<return: #LeHtmlContext>
	| aDatabase anOtherPage aSnippet aContext html |
	aDatabase := self databaseWithPictures.
	anOtherPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new otherPageTitle.
	aSnippet := LeTextSnippet string: 'See {{gtPictureReference:fig1}} here'.
	anOtherPage addSnippet: aSnippet.
	aContext := LeHtmlContext new
			page: anOtherPage;
			database: aDatabase.
	aContext
		pageLinks: (LeExportPageLinksBuilder new
				pages: {anOtherPage};
				mainPage: anOtherPage;
				sequencer: aContext sequencer;
				html;
				build;
				links).

	html := self htmlFor: aSnippet context: aContext.

	self
		assertHtml: html
		includes: 'See <span class="annotation annotation-label annotation-label-picture">Figure 1</span> here'.
	self assert: aContext log asArray size equals: 0.

	^ aContext

]

{ #category : #'examples - database' }
LePictureAnnotationExportExamples >> htmlTextSnippetWithPictureAnnotationOnSamePage [
	"The link to a picture on the same page has no page file name"

	<gtExample>
	<return: #LeHtmlContext>
	| aDatabase aPage aSnippet aContext html |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new picturesPageTitle.
	aSnippet := LeTextSnippet string: 'See {{gtPictureReference:fig1}} here'.
	aPage addSnippet: aSnippet.
	aContext := LeHtmlContext new
			page: aPage;
			database: aDatabase.

	html := self htmlFor: aSnippet context: aContext.

	self
		assertHtml: html
		includes: 'See <a class="annotation annotation-label annotation-label-picture" href="#figure-fig1">Figure 1</a> here'.
	self assert: aContext log asArray size equals: 0.

	^ aContext

]

{ #category : #'examples - database' }
LePictureAnnotationExportExamples >> htmlTextSnippetWithUnresolvedPictureAnnotationInDatabase [
	<gtExample>
	<return: #LeHtmlContext>
	| aDatabase aPage aSnippet aContext html aLogItem |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new picturesPageTitle.
	aSnippet := LeTextSnippet string: 'See {{gtPictureReference:missing}} here'.
	aPage addSnippet: aSnippet.
	aContext := LeHtmlContext new
			page: aPage;
			database: aDatabase.

	html := self htmlFor: aSnippet context: aContext.

	self
		assertHtml: html
		includes: 'See <span class="annotation annotation-label annotation-label-picture annotation-label-missing">missing</span> here'.
	self assert: aContext log asArray size equals: 1.
	aLogItem := aContext log asArray first.
	self assert: aLogItem class equals: LeExportUnresolvedAnnotationLogItem.
	self assert: aLogItem snippet equals: aSnippet.
	self assert: aLogItem annotation class equals: LePictureAnnotationNode.
	self assert: aLogItem isProblemLog.
	self assert: (aLogItem description includesSubstring: 'missing').

	^ aContext

]

{ #category : #examples }
LePictureAnnotationExportExamples >> postAbstractTextSnippetWithPictureAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor html |
	snippet := self textSnippetWithPictureAnnotation.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: LeHtmlContext new;
			snippet: snippet.
	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'See picture3 here'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - database' }
LePictureAnnotationExportExamples >> postAbstractTextSnippetWithResolvedPictureAnnotation [
	<gtExample>
	<return: #LeHtmlTextSnippetPostAbstractVisitor>
	| aDatabase aPage aSnippet visitor html |
	aDatabase := self databaseWithPictures.
	aPage := aDatabase pageNamed: LePictureSnippetReferenceExamples new otherPageTitle.
	aSnippet := LeTextSnippet string: 'See {{gtPictureReference:fig1}} and {{gtPictureReference:fig2}} here'.
	aPage addSnippet: aSnippet.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: (LeHtmlContext new
					page: aPage;
					database: aDatabase);
			snippet: aSnippet.
	html := visitor contentsFor: aSnippet.

	self assertHtml: html equals: 'See Figure 1 and Figure Glamorous Toolkit here'.

	^ visitor

]

{ #category : #'examples - database' }
LePictureAnnotationExportExamples >> registrationIsIdempotent [
	<gtExample>
	<return: #Array>
	| registries before |
	registries := {
		LeHtmlTextSnippetVisitor componentVisitorClasses -> LePictureAnnotationHtmlVisitor.
		LeHtmlTextSnippetPostAbstractVisitor componentVisitorClasses -> LePictureAnnotationHtmlPostAbstractVisitor }.
	before := registries collect: [ :each | each key copy ].
	[ LePictureAnnotationHtmlVisitor
		initialize;
		initialize.
	LePictureAnnotationHtmlPostAbstractVisitor
		initialize;
		initialize.
	registries
		do: [ :each | self assert: (each key occurrencesOf: each value) equals: 1 ] ]
		ensure: [ registries
				with: before
				do: [ :each :classes |
					each key
						removeAll;
						addAll: classes ] ].
	^ registries

]

{ #category : #examples }
LePictureAnnotationExportExamples >> textSnippetWithPictureAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	^ LeTextSnippet string: 'See {{gtPictureReference:picture3}} here'

]
