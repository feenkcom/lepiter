Class {
	#name : #LeHtmlTextSnippetAnnotationVisitor,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor + TLeExportResourceHelpers + TLeWordParseNodeVisitor',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait + TLeExportResourceHelpers classTrait + TLeWordParseNodeVisitor classTrait',
	#instVars : [
		'context',
		'exportedNodes',
		'snippet'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #accessing }
LeHtmlTextSnippetAnnotationVisitor >> context [
	^ context
]

{ #category : #accessing }
LeHtmlTextSnippetAnnotationVisitor >> context: anObject [
	context := anObject
]

{ #category : #initialization }
LeHtmlTextSnippetAnnotationVisitor >> initialize [
	super initialize.

	exportedNodes := OrderedCollection new
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> logUnsupportedAnnotation: anAnnotation [
	^ context log
		addItem: (LeExportUnsupportedTextSnippetNodeLogItem new
				snippet: snippet;
				node: anAnnotation)
]

{ #category : #accessing }
LeHtmlTextSnippetAnnotationVisitor >> snippet [
	^ snippet
]

{ #category : #accessing }
LeHtmlTextSnippetAnnotationVisitor >> snippet: anObject [
	snippet := anObject
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> visitAnnotation: anAnnotation [
	exportedNodes
		detect: [ :eachNode | eachNode == anAnnotation ]
		ifFound: [ :aNode | "ignore" ]
		ifNone: [ self logUnsupportedAnnotation: anAnnotation ].

	^ self visitAnnotationParse: anAnnotation
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> visitClassAnnotation: aClassAnnotation [
	| classNameArgument |
	aClassAnnotation hasLabel ifTrue: [ 
		context html 
			inlineTag: #code
			attributes: #('class' 'class_label')
			with: aClassAnnotation label.
		^ self ].
	
	classNameArgument := aClassAnnotation nameNode.
	context html 
		inlineTag: 'code'
		attributes: #('class' 'class_annotation')
		with: classNameArgument value source
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> visitExampleAnnotation: anExampleAnnotation [
	| someResources resource |
	someResources := self resourcesFor: anExampleAnnotation.

	"Check available resources"
	someResources
		ifEmpty: [ context logger 
			withoutResourcesAnnotation: anExampleAnnotation 
			snippet: snippet.
			^ self ]
		ifOne: [ :aResource | 
			resource := aResource ]
		ifMore: [ :aCollection | 
			context logger 
				tooManyResources: aCollection
				annotation: anExampleAnnotation 
				snippet: snippet.
				^ self ].
	
	"Write label"
	resource wantsLabelOutput ifTrue: [
		LeHtmlExampleLabelWriter new 
			context: context;
			resource: resource;
			write.
		^ self ].
	
	"Write example code and output preview"
	LeHtmlExampleWriter new 
		html: context html;
		sequencer: context sequencer;
		resource: resource;
		write
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> visitMethodAnnotation: aMethodAnnotation [
	| methodNameArgument method methodExists |
	methodNameArgument := aMethodAnnotation nameNode.
	method := methodNameArgument imageObject.
	methodExists := method isNotNil.

	context html
		inlineTag: 'code'
		attributes: {'class'. 'method_annotation expandable_annotation_label {1}'
				format: {(aMethodAnnotation isExpanded and: [ methodExists ])
							ifTrue: [ 'expanded_annotation_body' ]
							ifFalse: [ 'collapsed_annotation_body' ]}}
		with: (aMethodAnnotation hasLabel
				ifTrue: [ aMethodAnnotation label ]
				ifFalse: [ methodNameArgument fullName ]).
				
	methodExists ifFalse: [ ^ self ].
				
	context html 
		tag: 'div'
		attributes: {'class'. 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body {1}'
				format: {(aMethodAnnotation isExpanded)
							ifTrue: [ 'visible_annotation' ]
							ifFalse: [ 'hidden_annotation' ]}}
		do: [ 
			context html 
				tag: 'pre'
				attributes: #('class' 'no_bottom_margin')
				with: method sourceCode ]
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> visitPackageAnnotation: aPackageAnnotation [
	| nameArgument |
	aPackageAnnotation hasLabel ifTrue: [ 
		context html 
			inlineTag: #code
			attributes: #('package' 'package_label')
			with: aPackageAnnotation label.
		^ self ].
	
	nameArgument := aPackageAnnotation nameNode.
	context html 
		inlineTag: 'code'
		attributes: #('package' 'package_annotation')
		with: nameArgument value source
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> visitPageAnnotation: aPageAnnotation [
	context html
		inlineTag: #span
		attributes: #('page-annotation')
		with: aPageAnnotation pageName
]
