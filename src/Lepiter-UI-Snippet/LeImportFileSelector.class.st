Class {
	#name : #LeImportFileSelector,
	#superclass : #BrFileSelector,
	#instVars : [
		'importTypeButton',
		'importType',
		'importTypes',
		'importTypeLabels'
	],
	#category : 'Lepiter-UI-Snippet-Text actions'
}

{ #category : #private }
LeImportFileSelector >> createOkButton [
	| alignedButton |

	alignedButton := super createOkButton.
	importTypeButton := BrButton new 
		aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude;
		label: self currentLabel;
		action: [ self toggleType ];
		yourself.
	alignedButton addChildFirst: importTypeButton.
	^alignedButton
]

{ #category : #'private - accessing' }
LeImportFileSelector >> currentLabel [

	^ importTypeLabels at: importType 
]

{ #category : #'private - accessing' }
LeImportFileSelector >> currentType [

	^ importTypes at: importType 
]

{ #category : #initialization }
LeImportFileSelector >> initialize [ 

	importType := 1.
	importTypes := #(copy move inplace).
	importTypeLabels := #('Copy file to database: ' 'Move file to database: ' 'Leave in place: ').
	"Call super initialize last as it depends on the instance variables above being initialised"
	super initialize.

]

{ #category : #private }
LeImportFileSelector >> toggleType [

	importType := importType + 1.
	importType > importTypes size ifTrue: 
		[ importType := 1 ].
	importTypeButton label: self currentLabel.
]
