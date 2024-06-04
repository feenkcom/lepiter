Class {
	#name : #GtPythonCoderViewModel,
	#superclass : #GtSourceCoderViewModel,
	#instVars : [
		'selfObject'
	],
	#category : #'Lepiter-Python-Coder'
}

{ #category : #'as yet unclassified' }
GtPythonCoderViewModel >> allowSaveDueTo: aGtLSPRenameAction [ 
]

{ #category : #accessing }
GtPythonCoderViewModel >> preventSaveDueTo: anObject [
	"do nothing"
]

{ #category : #accessing }
GtPythonCoderViewModel >> selfObject [
	^ selfObject
]

{ #category : #accessing }
GtPythonCoderViewModel >> selfObject: anObject [
	selfObject := anObject
]
