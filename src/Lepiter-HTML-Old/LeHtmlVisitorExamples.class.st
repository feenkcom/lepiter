Class {
	#name : #LeHtmlVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Old-! New - Examples'
}

{ #category : #'examples - incoplete visitor' }
LeHtmlVisitorExamples >> elementSnippet_IncompleteVisitor [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeElementSnippet
			code: BrExamplesShowroom name , ' new ' , #glamorousBreadcrumb asString.
	html := String
			streamContents: [ :stream | 
				snippet
					acceptVisitor: (visitor := LeHtmlIncopleteVisitor new
								context: (context := LeHtmlContextOld new
											resources: (resources := LeExportResources2 new);
											stream: stream)) ].
											
	self 
		assert: html isEmpty 
		description: [ 'HTML output must be empty'].
	self 
		assert: resources asArray isEmpty
		description: [ 'Resources must be empty.' ].
	self 
		assert: context log asArray size = 1
		description: [ 'Log must NOT be empty.' ].
	self 
		assert: context log asArray first isProblemLog
		description: [ 'Log item must be a problem.' ].

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_InexistentMethod [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeElementSnippet 
		code: LeHtmlVisitorExamples name, ' new inexistentMethod'.
	html := String streamContents: [ :stream | 
		snippet acceptVisitor: (visitor := LeHtmlVisitor new
			context: (context := LeHtmlContextOld new
				resources: (resources := LeExportResources2 new);
				stream: stream)) ].
	
	self 
		assert: html isNotEmpty 
		description: [ 'HTML output must be non-empty'].
	
	self assert: (html includesSubstring: '<figure class="snippet picture-snippet').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>').
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady not
		description: [ 'Resource must NOT be ready.' ].

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_InexistentMethod_PrepareResources [
	<gtExample>
	| resources visitor context |
	visitor := self elementSnippet_InexistentMethod.
	context := visitor context.
	resources := context resources.
	context assembler assemble.
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady not
		description: [ 'Resource must be ready.' ].

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_PresenterSlideShow [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeElementSnippet 
		code: GtPresenterSlideShow name, ' ', #create: asString, ' ', GtTour name, ' new'.
	html := String streamContents: [ :stream | 
		snippet acceptVisitor: (visitor := LeHtmlVisitor new
			context: (context := LeHtmlContextOld new
				resources: (resources := LeExportResources2 new);
				stream: stream)) ].
	

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_Successful [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeElementSnippet 
		code: BrExamplesShowroom name, ' new ', #glamorousBreadcrumb asString.
	html := String streamContents: [ :stream | 
		snippet acceptVisitor: (visitor := LeHtmlVisitor new
			context: (context := LeHtmlContextOld new
				resources: (resources := LeExportResources2 new);
				stream: stream)) ].
	
	self 
		assert: html isNotEmpty 
		description: [ 'HTML output must be non-empty'].
	
	self assert: (html includesSubstring: '<figure class="snippet picture-snippet').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>').
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady not
		description: [ 'Resource must NOT be ready.' ].

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_Successful_PrepareResources [
	<gtExample>
	| resources visitor context |
	visitor := self elementSnippet_Successful.
	context := visitor context.
	resources := context resources.
	context assembler assemble.
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady
		description: [ 'Resource must be ready.' ].

	^ visitor
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureFile_ExistingOne [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit-demos' 
		/ 'data' 
		/ 'faceapi' 
		/ '1280px-Einstein-with-habicht-and-solovine.jpg') asUrl asString
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureFile_MissingOne [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit' 
		/ 'data' 
		/ 'inexistent-image-file.jpg') asUrl asString
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippet_SuccessfulWithFileReference [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LePictureSnippet new urlString: self pictureFile_ExistingOne.
	html := String streamContents: [ :stream | 
		snippet acceptVisitor: (visitor := LeHtmlVisitor new
			context: (context := LeHtmlContextOld new
				resources: (resources := LeExportResources2 new);
				stream: stream)) ].
				
	self assert: (html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>').
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady
		description: [ 'Resource must be ready.' ].

	^ visitor
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippet_SuccessfulWithHttp [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LePictureSnippet new urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png'.
	html := String streamContents: [ :stream | 
		snippet acceptVisitor: (visitor := LeHtmlVisitor new
			context: (context := LeHtmlContextOld new
				resources: (resources := LeExportResources2 new);
				stream: stream)) ].
				
	self assert: (html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="https://gtoolkit.com/assets/pictures/use-case-rest-api.png"/>').
	
	self assert: resources asArray size equals: 0.

	^ visitor
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippet_SuccessfulWithMissingFileReference [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LePictureSnippet new urlString: self pictureFile_MissingOne.
	html := String streamContents: [ :stream | 
		snippet acceptVisitor: (visitor := LeHtmlVisitor new
			context: (context := LeHtmlContextOld new
				resources: (resources := LeExportResources2 new);
				stream: stream)) ].
				
	self assert: (html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>').
	
	self assert: resources asArray size equals: 1.
	self 
		assert: resources asArray first state isReady not
		description: [ 'Resource must NOT be ready.' ].
	self 
		assert: resources asArray first state isFailure
		description: [ 'Resource must be a failure.' ].

	^ visitor
]
