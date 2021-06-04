"
A LePharoSnippet is an executable piece of Pharo code, i.e. a script.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
1. # Internal Representation and Key Implementation Points.


1. ## Instance Variables

	code:		<String>


1. # Implementation Points


"
Class {
	#name : #LePharoSnippet,
	#superclass : #LeCodeSnippet,
	#category : #'Lepiter-Pharo-Snippet'
}

{ #category : #'instance creation' }
LePharoSnippet class >> code: aString [

	^ self new code: aString
]

{ #category : #accessing }
LePharoSnippet class >> contextMenuItemSpefication [
	<leSnippetSpecification>

	^ LeContextMenuItemSpecification new
		priority: 2;
		snippetClass: self;
		title: 'Pharo'
]

{ #category : #factory }
LePharoSnippet class >> empty [ 

	^ self new
]

{ #category : #accessing }
LePharoSnippet class >> leJsonV3Name [

	^ 'pharoSnippet'
]

{ #category : #accessing }
LePharoSnippet class >> leJsonV4Name [

	^ 'pharoSnippet'
]

{ #category : #visiting }
LePharoSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitPharoSnippet: self
]

{ #category : #accessing }
LePharoSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LePharoSnippetViewModel new snippetModel: self
]

{ #category : #initialization }
LePharoSnippet >> newCoder [
	^ GtPharoSnippetCoder new
]
