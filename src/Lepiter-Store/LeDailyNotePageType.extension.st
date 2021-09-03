Extension { #name : 'LeDailyNotePageType' }

{ #category : '*Lepiter-Store' }
LeDailyNotePageType class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#date -> #date);
		yourself

]

{ #category : '*Lepiter-Store' }
LeDailyNotePageType class >> leJsonV3Name [

	^ 'dailyNote'
]

{ #category : '*Lepiter-Store' }
LeDailyNotePageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#date -> #date);
		yourself

]

{ #category : '*Lepiter-Store' }
LeDailyNotePageType class >> leJsonV4Name [

	^ 'dailyNote'
]
