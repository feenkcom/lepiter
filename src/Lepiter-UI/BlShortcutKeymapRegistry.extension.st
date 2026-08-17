Extension { #name : #BlShortcutKeymapRegistry }

{ #category : #'*Lepiter-UI' }
BlShortcutKeymapRegistry >> lepiter [
	<gtKeymapRegistry>
	
	^ self ensureRegistryCategoryOfType: LeKeymapRegistry 
]
