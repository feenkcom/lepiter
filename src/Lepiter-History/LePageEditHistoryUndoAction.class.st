Class {
	#name : #LePageEditHistoryUndoAction,
	#superclass : #LePageEditHistoryAction,
	#category : #'Lepiter-History-Storage'
}

{ #category : #actions }
LePageEditHistoryUndoAction >> applyOn: aPage [
	| undoResult |
	undoResult := self editEvent undoOn: aPage.
	
	self pageHistory 
		addRedoActionForEvent: self editEvent.
		
	^ undoResult
]

{ #category : #accessing }
LePageEditHistoryUndoAction >> label [
	^ 'Undo'
]
