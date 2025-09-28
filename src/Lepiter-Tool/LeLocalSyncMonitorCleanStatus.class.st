Class {
	#name : #LeLocalSyncMonitorCleanStatus,
	#superclass : #LeLocalSyncMonitorStatus,
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #accessing }
LeLocalSyncMonitorCleanStatus >> gtViewIconFor: aView [
	<gtView>
	^ aView explicit
		title: 'Icon';
		stencil: [
			self statusIcon asElement
				margin: (BlInsets all: 20) ]
]

{ #category : #accessing }
LeLocalSyncMonitorCleanStatus >> shortName [
	^ 'Synchronized'
]

{ #category : #accessing }
LeLocalSyncMonitorCleanStatus >> statusColor [
	^ Color green muchDarker
]

{ #category : #accessing }
LeLocalSyncMonitorCleanStatus >> statusIcon [
	^ BrGlamorousVectorIcons greencircle
]
