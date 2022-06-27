Class {
	#name : #LeGenericCompositeCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'label'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeGenericCompositeCommand >> execute [ 
	self subcommands do: [ :aSubcommand | aSubcommand execute ]
]

{ #category : #accessing }
LeGenericCompositeCommand >> label [

	^ label
]

{ #category : #accessing }
LeGenericCompositeCommand >> label: aString [

	label := aString
]
