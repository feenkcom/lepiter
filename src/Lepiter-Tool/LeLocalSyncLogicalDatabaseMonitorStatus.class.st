Class {
	#name : #LeLocalSyncLogicalDatabaseMonitorStatus,
	#superclass : #LeLocalSyncStatus,
	#instVars : [
		'databaseStatuses'
	],
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #adding }
LeLocalSyncLogicalDatabaseMonitorStatus >> addDatabaseStatus: aMonitorStatus [
	self databaseStatuses add: aMonitorStatus
]

{ #category : #accessing }
LeLocalSyncLogicalDatabaseMonitorStatus >> databaseStatuses [
	^ databaseStatuses
]

{ #category : #accessing }
LeLocalSyncLogicalDatabaseMonitorStatus >> gtViewStatusesFor: aView [
	<gtView>
	^ aView list
		title: 'Statuses';
		items: [ self databaseStatuses ];
		itemText: [ :aStatus | aStatus formattedShortName ]
]

{ #category : #initialization }
LeLocalSyncLogicalDatabaseMonitorStatus >> initialize [
	super initialize.
	databaseStatuses := OrderedCollection new.
]

{ #category : #testing }
LeLocalSyncLogicalDatabaseMonitorStatus >> isErrorStatus [
	^ self databaseStatuses allSatisfy: [ :aMonitorStatus |
		aMonitorStatus isErrorStatus ]
]

{ #category : #testing }
LeLocalSyncLogicalDatabaseMonitorStatus >> isPendingChangesStatus [
	^ self databaseStatuses allSatisfy: [ :aMonitorStatus |
		aMonitorStatus isPendingChangesStatus ]
]

{ #category : #accessing }
LeLocalSyncLogicalDatabaseMonitorStatus >> shortName [

	self isErrorStatus ifTrue: 
		[ ^ 'Error' ].

	self isPendingChangesStatus ifTrue: 
		[ ^ 'Pending changes' ].

	^ 'Synchronized'
]

{ #category : #accessing }
LeLocalSyncLogicalDatabaseMonitorStatus >> statusColor [

	self isErrorStatus ifTrue: 
		[ ^ Color red ].

	self isPendingChangesStatus ifTrue: 
		[ ^ Color yellow muchDarker ].

	^ Color green muchDarker
]

{ #category : #accessing }
LeLocalSyncLogicalDatabaseMonitorStatus >> statusIcon [
	"Answer the icon to display in the receiver's button"

	self isErrorStatus ifTrue: 
		[ ^ BrGlamorousIcons redcircle ].

	self isPendingChangesStatus ifTrue: 
		[ ^ BrGlamorousIcons yellowcircle ].

	^ BrGlamorousIcons greencircle
]
