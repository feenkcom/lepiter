Class {
	#name : #LePageEditHistoryRedoAction,
	#superclass : #LePageEditHistoryAction,
	#category : #'Lepiter-History-Storage'
}

{ #category : #hook }
LePageEditHistoryRedoAction >> applyOn: aPage [
	self editEvent redoOn: aPage.
	self pageHistory 
		addUndoActionForEvent: self editEvent
]

{ #category : #accessing }
LePageEditHistoryRedoAction >> eventDescriptionText [
	^ super eventDescriptionText foreground: Color gray
]

{ #category : #accessing }
LePageEditHistoryRedoAction >> label [
	^ 'Redo'
]

{ #category : #accessing }
LePageEditHistoryRedoAction >> labelText [
	^ super labelText foreground: Color gray
]
