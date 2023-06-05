Class {
	#name : #LeHtmlVisitorHolder,
	#superclass : #LeExportVisitorHolder,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #'gt - extensions' }
LeHtmlVisitorHolder >> gtStreamStateFor: aView [
	<gtView>
	visitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'HTML';
		priority: 10;
		object: [ visitor ];
		view: #gtStreamStateFor:
]
