Class {
	#name : #LePageCardElementExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-IncomingReferences-Examples'
}

{ #category : #'examples - showroom' }
LePageCardElementExamples >> pageCardElement [
	<gtExample>
	| anElement aPage |

	aPage := LeIncomingReferencesForUIExamples new pageThreeOfDatabaseWithLinkedReferencesAmongPages.

	anElement := LePageCardElement new.
	anElement pageViewModel: (LePageViewModel new pageModel: aPage).

	self assert: anElement containerElement label characters equals: aPage title.

	^ anElement
]
