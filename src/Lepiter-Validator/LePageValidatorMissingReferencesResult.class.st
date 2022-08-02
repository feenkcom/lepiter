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

{ #category : #ui }
LePageValidatorMissingReferencesResult >> gtViewMissingClassesListFor: aView [
	<gtView>
	^ aView list
		  title: 'Classes';
		  items: [ classAnnotations ];
		  itemText: [ :aClassAnnotation | 
			  aClassAnnotation referencedClassName ]
]

{ #category : #ui }
LePageValidatorMissingReferencesResult >> gtViewMissingExamplesListFor: aView [

	<gtView>
	^ aView list
		  title: 'Examples';
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
		  items: [ methodAnnotations ];
		  itemText: [ :aMethodAnnotation | 
			  aMethodAnnotation nameNode className, '>>',aMethodAnnotation nameNode methodName ]
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
