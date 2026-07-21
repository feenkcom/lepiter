Class {
	#name : #LeRenameAction,
	#superclass : #GtRenameAction,
	#category : 'Lepiter-UI-Snippet-Text actions'
}

{ #category : #private }
LeRenameAction >> addRenameAttributes [
	super addRenameAttributes.
	self clearAdornments
]

{ #category : #private }
LeRenameAction >> clearAdornments [
	renameAttributes
		do: [ :each | 
			each text
				clearAttributes: [ :attr | 
					(attr isKindOf: BrTextAdornmentAttribute)
						or: [ attr isKindOf: BrTextEventHandlerAttribute ] ] ]
]

{ #category : #actions }
LeRenameAction >> updateName: blText [
	super updateName: blText.
	self clearAdornments
]

{ #category : #private }
LeRenameAction >> updateSource [
	"Renaming is handled through the model"
]
