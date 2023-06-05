Class {
	#name : #LeExportUUIDSequencer,
	#superclass : #Object,
	#traits : 'TLeExportSequencer',
	#classTraits : 'TLeExportSequencer classTrait',
	#category : #'Lepiter-Export-Sequencers'
}

{ #category : #accessing }
LeExportUUIDSequencer >> nextId [
	<return: #String>
	^ UUID new asString36
]
