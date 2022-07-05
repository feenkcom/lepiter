Class {
	#name : #LePageEditHistoryUndoAction,
	#superclass : #LePageEditHistoryAction,
	#category : #'Lepiter-History-Storage'
}

{ #category : #actions }
LePageEditHistoryUndoAction >> applyOn: aPage [
	self editEvent undoOn: aPage.
	self pageHistory 
		addRedoActionForEvent: self editEvent
]

{ #category : #accessing }
LePageEditHistoryUndoAction >> label [
	^ 'Undo'
]
