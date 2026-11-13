"
The outcome of a Pharo rewrite snippet. Holds preview changes and per-method rewrite failures. Each entry in errors is an association from the compiled method to its actual GtParseTreeRewriteError. The Changes view retains the existing apply-changes interface. The Errors view is shown only when failures exist, displays Method and Error columns, and sends the exception itself when a row is selected.
"
Class {
	#name : #LePharoRewriteResult,
	#superclass : #Object,
	#instVars : [
		'changes',
		'errors'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Model'
}

{ #category : #accessing }
LePharoRewriteResult >> addError: anError forMethod: aMethod [
	errors add: aMethod -> anError
]

{ #category : #accessing }
LePharoRewriteResult >> changes [
	^ changes
]

{ #category : #accessing }
LePharoRewriteResult >> changes: aChange [
	changes := aChange
]

{ #category : #accessing }
LePharoRewriteResult >> errors [
	^ errors
]

{ #category : #views }
LePharoRewriteResult >> gtChangesFor: aView [
	<gtView>
	^ aView forward
		title: 'Changes';
		priority: 10;
		object: [ changes ];
		view: #gtApplyingChangesFor:
]

{ #category : #views }
LePharoRewriteResult >> gtErrorsFor: aView [
	<gtView>
	errors ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Errors';
		priority: 20;
		items: [ errors ];
		column: 'Method' text: [ :each | each key gtDisplayString ];
		column: 'Error' text: [ :each | each value messageText ];
		send: [ :each | each value ]
]

{ #category : #initialization }
LePharoRewriteResult >> initialize [
	super initialize.
	changes := RBCompositeRefactoryChange new.
	errors := OrderedCollection new
]
