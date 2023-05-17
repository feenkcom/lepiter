Class {
	#name : #LePageValidatorMissingReferencesResult,
	#superclass : #Object,
	#instVars : [
		'targetPage',
		'snippetsWithMissingReferences',
		'classAnnotations',
		'methodAnnotations',
		'exampleAnnotations'
	],
	#category : #'Lepiter-Validator-Model'
}

{ #category : #adding }
LePageValidatorMissingReferencesResult >> addMissingClassAnnotation: aClassAnnotation [
	classAnnotations add: aClassAnnotation
]

{ #category : #adding }
LePageValidatorMissingReferencesResult >> addMissingExampleAnnotation: anExampleAnnotation [
	exampleAnnotations add: anExampleAnnotation
]

{ #category : #adding }
LePageValidatorMissingReferencesResult >> addMissingMethodAnnotation: aClassAnnotation [
	methodAnnotations add: aClassAnnotation
]

{ #category : #adding }
LePageValidatorMissingReferencesResult >> addSnippetWithMissingReference: aSnippet [
	snippetsWithMissingReferences add: aSnippet
]

{ #category : #accessing }
LePageValidatorMissingReferencesResult >> asPageValidatorPhlowTool [
	<return: #GtPhlowTool>
	^ self targetPage asPageValidatorPhlowTool
]

{ #category : #accessing }
LePageValidatorMissingReferencesResult >> classAnnotations [
	^ classAnnotations 
]

{ #category : #accessing }
LePageValidatorMissingReferencesResult >> exampleAnnotations [
	^ exampleAnnotations
]

{ #category : #printing }
LePageValidatorMissingReferencesResult >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	targetPage ifNotNil: [ 
		aStream nextPut: $(.
		targetPage gtDisplayOn: aStream.
		aStream nextPut: $) ]
]

{ #category : #accessing }
LePageValidatorMissingReferencesResult >> gtLiveFor: aView [ 
	<gtView>
	^ aView forward
		title: 'Page';
		object: [ targetPage ];
		view: #gtLiveFor:
]

{ #category : #ui }
LePageValidatorMissingReferencesResult >> gtViewMissingClassesListFor: aView [
	<gtView>
	^ aView list
		  title: 'Class annotations';
		  priority: 16;
		  items: [ classAnnotations ];
		  itemText: [ :aClassAnnotation | 
			  aClassAnnotation referencedClassName ]
]

{ #category : #ui }
LePageValidatorMissingReferencesResult >> gtViewMissingExamplesListFor: aView [

	<gtView>
	^ aView list
		  title: 'Example annotations';
		  priority: 14;
		  items: [ exampleAnnotations ];
		  itemText: [ :anExampleAnnotation | 
			  anExampleAnnotation referencedExample gtDisplayString ];
		  send: [ :anExampleAnnotation | 
			  anExampleAnnotation referencedExample ]
]

{ #category : #ui }
LePageValidatorMissingReferencesResult >> gtViewMissingMethodsListFor: aView [
	<gtView>
	^ aView list
		  title: 'Methods';
		  priority: 12;
		  items: [ methodAnnotations ];
		  itemText: [ :aMethodAnnotation | 
			  aMethodAnnotation nameNode className, '>>',aMethodAnnotation nameNode methodName ]
]

{ #category : #ui }
LePageValidatorMissingReferencesResult >> gtViewMissingReferencesInSnippetsFor: aView [

	<gtView>
	^ aView columnedList
		title: 'Snippets';
		priority: 30;
		items: [ snippetsWithMissingReferences ];
		column: 'Type' text: [ :aSnippet | aSnippet class ] width: 200;
		column: 'Content'
			text: [ :aSnippet | aSnippet contentAsString truncateTo: 200 ]
			width: 200
]

{ #category : #ui }
LePageValidatorMissingReferencesResult >> gtViewOverviewFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'Overview';
		  priority: 5;
		  items: [ { 
		  	 'Method Annotations' -> methodAnnotations.
		  	 'Example Annotations' -> classAnnotations.
		  	 'Class Annotations' -> classAnnotations.
		  	 'Other Snippets' -> snippetsWithMissingReferences } ];
		 column: 'Reference type' text: [ :assoc | assoc key ];
		 column: 'Number of missing code references' text: [ :assoc | assoc value size ];
		 send: [ :assoc | assoc value ]
]

{ #category : #initialization }
LePageValidatorMissingReferencesResult >> initialize [
	super initialize.
	classAnnotations := OrderedCollection new.
	methodAnnotations := OrderedCollection new.
	exampleAnnotations := OrderedCollection new.
	snippetsWithMissingReferences := OrderedCollection new.
]

{ #category : #testing }
LePageValidatorMissingReferencesResult >> isNotEmpty [ 
	^ classAnnotations notEmpty or: [ 
		methodAnnotations notEmpty or: [ 
			exampleAnnotations notEmpty or: [ 
				snippetsWithMissingReferences notEmpty ] ] ]
]

{ #category : #accessing }
LePageValidatorMissingReferencesResult >> methodAnnotations [
	^ methodAnnotations 
]

{ #category : #accessing }
LePageValidatorMissingReferencesResult >> targetPage [
	^ targetPage
]

{ #category : #accessing }
LePageValidatorMissingReferencesResult >> targetPage: aPage [
	targetPage := aPage
]
