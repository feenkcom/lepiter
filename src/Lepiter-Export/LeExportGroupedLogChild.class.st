Class {
	#name : #LeExportGroupedLogChild,
	#superclass : #Object,
	#instVars : [
		'logItem'
	],
	#category : #'Lepiter-Export-Log - Support'
}

{ #category : #accessing }
LeExportGroupedLogChild >> children [
	^ #()
]

{ #category : #accessing }
LeExportGroupedLogChild >> description [
	^ logItem description
]

{ #category : #accessing }
LeExportGroupedLogChild >> label [
	^ logItem label
]

{ #category : #accessing }
LeExportGroupedLogChild >> logItem [
	^ logItem
]

{ #category : #accessing }
LeExportGroupedLogChild >> logItem: anObject [
	logItem := anObject
]

{ #category : #'as yet unclassified' }
LeExportGroupedLogChild >> object [
	^ logItem
]
