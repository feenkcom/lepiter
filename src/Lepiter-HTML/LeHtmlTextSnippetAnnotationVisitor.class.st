Class {
	#name : #LeHtmlTextSnippetAnnotationVisitor,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor + TLeExportResourceHelpers',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait + TLeExportResourceHelpers classTrait',
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

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> defaultWidth [
	^ LeSnippetParagraphWidth new
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
	| label theClass theClassExists |
	label := aClassAnnotation hasLabel
			ifTrue: [ aClassAnnotation label trimBoth ]
			ifFalse: [ aClassAnnotation referencedClassName ].
	theClass := aClassAnnotation imageObject.
	theClassExists := theClass isNotNil.
	
	context html
		inlineTag: 'code'
		attributes: {'class'. 'annotation annotation-label annotation-label-class annotation-label-code expandable-annotation-label {1}'
				format: {(aClassAnnotation isExpanded and: [ theClassExists ])
							ifTrue: [ 'annotation-sibling-is-expanded' ]
							ifFalse: [ 'annotation-sibling-is-collapsed' ]}}
		with: label.
		
	theClassExists ifFalse: [ ^ self ].

	context html 
		tag: 'span'
		attributes: {'class'. 'textual-snippet code-snippet pharo-class-definition expandable-annotation-view {1}'
				format: {(aClassAnnotation isExpanded)
							ifTrue: [ 'expanded-annotation-view' ]
							ifFalse: [ 'collapsed-annotation-view' ]}}
		do: [ 
			context html 
				inlineTag: 'code'
				attributes: #('class' '')
				with: theClass definitionString ]
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
		ifOne: [ :aResource | resource := aResource ]
		ifMore: [ :aCollection | resource := aCollection anyOne ].
	
	"Write label"
	resource wantsLabelOutput ifTrue: [
		LeHtmlExampleLabelWriter new 
			context: context;
			resource: resource;
			write.
		^ self ].
	
	"Write example code and output preview"
	context html 
		tag: #div
		do: [
			LeHtmlExampleWriter new 
				html: context html;
				sequencer: context sequencer;
				resources: someResources;
				width: self defaultWidth;
				write ]
]

{ #category : #generated }
LeHtmlTextSnippetAnnotationVisitor >> visitMethodAnnotation: aMethodAnnotation [
	| methodNameArgument method methodExists |
	methodNameArgument := aMethodAnnotation nameNode.
	method := methodNameArgument imageObject.
	methodExists := method isNotNil.

	context html
		inlineTag: 'code'
		attributes: {'class'. 'annotation annotation-label annotation-label-method annotation-label-code expandable-annotation-label {1}'
				format: {(aMethodAnnotation isExpanded and: [ methodExists ])
							ifTrue: [ 'annotation-sibling-is-expanded' ]
							ifFalse: [ 'annotation-sibling-is-collapsed' ]}}
		with: (aMethodAnnotation hasLabel
				ifTrue: [ aMethodAnnotation label ]
				ifFalse: [ methodNameArgument fullName ]).
				
	methodExists ifFalse: [ ^ self ].
				
	context html 
		tag: 'span'
		attributes: {'class'. 'textual-snippet code-snippet pharo-method-snippet expandable-annotation-view {1}'
				format: {(aMethodAnnotation isExpanded)
							ifTrue: [ 'expanded-annotation-view' ]
							ifFalse: [ 'collapsed-annotation-view' ]}}
		do: [ 
			context html 
				inlineTag: 'code'
				attributes: #('class' '')
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
	context pageLinks
		linkTitled: aPageAnnotation pageName
		ifFound: [ :aPageLink | 
			context html
				inlineTag: #a
				attributes: {'href'.
						self context hrefBuilder hrefFromPageLink: aPageLink}
				with: (aPageAnnotation label ifNil: aPageAnnotation pageName) ]
		ifNone: [ context html
				inlineTag: #span
				attributes: #('page-annotation')
				with: aPageAnnotation pageName ]
]
