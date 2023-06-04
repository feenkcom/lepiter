Class {
	#name : #LeHtmlExporterAnnotationVisitor,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor + TIndentWriter',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait + TIndentWriter classTrait',
	#instVars : [
		'externalPicturesWriter'
	],
	#category : #'Lepiter-HTML-Old-Exporter'
}

{ #category : #html }
LeHtmlExporterAnnotationVisitor >> exportImageTagForPath: filePath forAnnotation: anExampleAnnotation [
	stream
		<< ('<img src="{1}" alt="{2}"/>' format: {
			filePath asHTMLString. 
			filePath asHTMLString });
		cr.

]

{ #category : #accessing }
LeHtmlExporterAnnotationVisitor >> externalPicturesWriter [
	^ externalPicturesWriter
]

{ #category : #accessing }
LeHtmlExporterAnnotationVisitor >> externalPicturesWriter: aDataWriter [
	externalPicturesWriter := aDataWriter
]

{ #category : #accessing }
LeHtmlExporterAnnotationVisitor >> labelStringForAnnotation: anExampleAnnotation [
	| rbMethod example resultObject |
	
	rbMethod := anExampleAnnotation imageObject.
	rbMethod isDefined ifFalse: [ ^ '<method not defined>' ].  
	
	example := rbMethod compiledMethod
		gtExample asExampleWithResult.
	example canBeExecuted 
		ifFalse: [ ^ '<cannot execute>' ].
	example run.
	example hasResult 
		ifFalse: [ ^ '<something failed during example execution>' ].
	
	resultObject := example returnValue.
	^ anExampleAnnotation labelNode 
		labelFor: resultObject
]

{ #category : #generated }
LeHtmlExporterAnnotationVisitor >> visitClassAnnotation: aClassAnnotation [
	| classNameArgument |
	aClassAnnotation hasLabel
		ifTrue: [ ^ self writeClassLabel: aClassAnnotation ].
	classNameArgument := aClassAnnotation nameNode.
	self
		putTag: 'code'
		andAttributes: #('class' 'class_annotation')
		with: [ 
			self putString: classNameArgument value source asHTMLString ]
]

{ #category : #generated }
LeHtmlExporterAnnotationVisitor >> visitExampleAnnotation: anExampleAnnotation [	
	self visitAnnotation: anExampleAnnotation. 
		
	anExampleAnnotation hasLabel ifTrue: [ 
		^ self writeExampleLabelFor: anExampleAnnotation ].
	self writeExampleViewOrCodeFor: anExampleAnnotation
]

{ #category : #generated }
LeHtmlExporterAnnotationVisitor >> visitMethodAnnotation: aMethodAnnotation [
	| methodNameArgument method methodExists |
	methodNameArgument := aMethodAnnotation nameNode.
	method := methodNameArgument imageObject.
	methodExists := method isNotNil.

	self
		putTag: 'code'
		andAttributes: {'class'. 'method_annotation expandable_annotation_label {1}'
				format: {(aMethodAnnotation isExpanded and: [ methodExists ])
							ifTrue: [ 'expanded_annotation_body' ]
							ifFalse: [ 'collapsed_annotation_body' ]}}
		with: [ aMethodAnnotation hasLabel
				ifTrue: [ self putString: aMethodAnnotation label asHTMLString ]
				ifFalse: [ self putString: methodNameArgument fullName asHTMLString ] ].

	self
		putTag: 'div'
		andAttributes: {'class'. 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body {1}'
				format: {(aMethodAnnotation isExpanded and: [ methodExists ])
							ifTrue: [ 'visible_annotation' ]
							ifFalse: [ 'hidden_annotation' ]}}
		with: [ self
				putTag: 'pre'
				andAttributes: #('class' 'no_bottom_margin')
				with: [ 
					methodExists ifTrue: [
						self putPre: method sourceCode asHTMLString ] ] ]
]

{ #category : #'as yet unclassified' }
LeHtmlExporterAnnotationVisitor >> visitWordAnnotation: aLeWordAnnotationNode [
	self flag: #todo
]

{ #category : #html }
LeHtmlExporterAnnotationVisitor >> writeClassLabel: anAnnotation [
	self putTag: 'code' andAttributes: #('class' 'class_label') with: [
		self putString: anAnnotation label
	]
]

{ #category : #html }
LeHtmlExporterAnnotationVisitor >> writeCodeForExample: anExample [
	stream
		<< '<div class="example_definition">';
		<< '<figure class="codeBlock gtexample-src paragraphWidth">';
		<< '<pre>';
		<< '<code class="hljs smalltalk">';
		<< anExample method sourceCode asHTMLString;
		<< '</code>';
		<< '</pre>';
		<< '</figure>';
		<< '</div>'; cr.

]

{ #category : #html }
LeHtmlExporterAnnotationVisitor >> writeExampleLabelFor: anExampleAnnotation [
	stream
		<< '<code class="example_inlined">'
		<< (self labelStringForAnnotation: anExampleAnnotation) asHTMLString;
		<< '</code>'
]

{ #category : #html }
LeHtmlExporterAnnotationVisitor >> writeExampleResultForAnnotation: anExampleAnnotation [
	| filePath |
	self externalPicturesWriter ifNil: [
		stream
			<< '<div class=""example_result"">';
			<< anExampleAnnotation imageObject compiledMethod gtExample result printString trimBoth asHTMLString;
			<< '</div>'; cr.
		^ self ].
	
	filePath := self externalPicturesWriter
		exampleResultReferenceFor: anExampleAnnotation.
		
	stream
		<< ('<figure class="{1}">' format: { anExampleAnnotation alignment ifNil: [ 
			LepiterConstants defaultAlignment ] }); 
		cr.
		
	self 
		exportImageTagForPath: filePath
		forAnnotation:anExampleAnnotation.
	
	stream
		<< '</figure>'; cr

]

{ #category : #html }
LeHtmlExporterAnnotationVisitor >> writeExampleViewOrCodeFor: exampleAnnotation [	
	| rbMethod example |
	rbMethod := exampleAnnotation imageObject.
	rbMethod isDefined ifFalse: [ ^ self ].  
	example := rbMethod compiledMethod gtExample.
	
	stream
		<< '<div class="example_annotation">';
		<< '<div class="example_display">'.
	
	exampleAnnotation noCode ifFalse: [
		self writeCodeForExample: example ].
	
	((exampleAnnotation previewExpanded or: [ 
		exampleAnnotation noCode ]) and: [ 
			example canBeExecuted ]) ifTrue: [
				self writeExampleResultForAnnotation: exampleAnnotation ].
	
	stream
		<< '</div>';
		<< '</div>'; cr.

]
