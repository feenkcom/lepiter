Class {
	#name : #LeReloadOptimization,
	#superclass : #DynamicVariable,
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #accessing }
LeReloadOptimization class >> disableDuring: aBlock [
	^ self value: false during: aBlock
]

{ #category : #accessing }
LeReloadOptimization class >> enableDuring: aBlock [
	^ self value: true during: aBlock
]

{ #category : #testing }
LeReloadOptimization class >> ifEnabled: anEnabledBlock [
	^ self 
		ifEnabled: anEnabledBlock 
		ifDisabled: [ "do nothing" ]
]

{ #category : #testing }
LeReloadOptimization class >> ifEnabled: anEnabledBlock ifDisabled: aDisabledBlock [
	^ self
		ifEnabled: anEnabledBlock
		ifDisabled: aDisabledBlock
		ifUndefiend: [ LeDatabaseIsReloadNecessaryChecker isReloadAlways
			ifFalse: anEnabledBlock
			ifTrue: aDisabledBlock ]
]

{ #category : #testing }
LeReloadOptimization class >> ifEnabled: anEnabledBlock ifDisabled: aDisabledBlock ifUndefiend: anUndefinedBlock [
	^ self value
		ifNil: anUndefinedBlock 
		ifNotNil: [ :aBoolean | 
			aBoolean
				ifTrue: anEnabledBlock 
				ifFalse: aDisabledBlock ]
]

{ #category : #testing }
LeReloadOptimization class >> isInheritable [
	^ true
]
