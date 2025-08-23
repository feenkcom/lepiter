Class {
	#name : #BaselineOfLepiterTopics,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterTopics
}

{ #category : #'as yet unclassified' }
BaselineOfLepiterTopics >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'Lepiter-Topics' with: [ spec requires: #('Lepiter-Core') ] ]
]
