Class {
	#name : #LeReferenceMaintenanceSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'page',
		'operation',
		'parameter'
	],
	#category : 'Lepiter-Utilities-Beacon'
}

{ #category : #testing }
LeReferenceMaintenanceSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #accessing }
LeReferenceMaintenanceSignal >> operation [
	^ operation
]

{ #category : #accessing }
LeReferenceMaintenanceSignal >> operation: anObject [
	operation := anObject
]

{ #category : #accessing }
LeReferenceMaintenanceSignal >> page [
	^ page
]

{ #category : #accessing }
LeReferenceMaintenanceSignal >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeReferenceMaintenanceSignal >> parameter [
	^ parameter
]

{ #category : #accessing }
LeReferenceMaintenanceSignal >> parameter: anObject [
	parameter := anObject
]

{ #category : #printing }
LeReferenceMaintenanceSignal >> printOneLineContentsOn: stream [

	stream 
		<< 'Reference maintenance: ';
		print: page;
		<< ': ';
		print: operation;
		<< '(';
		print: parameter;
		<< ')'.
]
