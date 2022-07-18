Class {
	#name : #LeLocalSyncConcreteDatabaseMonitorStatus,
	#superclass : #LeLocalSyncStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #accessing }
LeLocalSyncConcreteDatabaseMonitorStatus >> databaseName [
	^ self database databaseName
]

{ #category : #'gt-extensions' }
LeLocalSyncConcreteDatabaseMonitorStatus >> statusWidget [
	| container |
	container := BrHorizontalPane new 
		fitContent;
		alignCenter.
	container addChild: (BrLabel new 
		text: self formattedShortName; 
		aptitude: BrGlamorousLabelAptitude new).
	^ container
]
