Class {
	#name : #BaselineOfLepiterChangesSnippet,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterChangesSnippet
}

{ #category : #accessing }
BaselineOfLepiterChangesSnippet class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterChangesSnippet >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Snippet-Changes' with: [
					spec requires: #( 'LepiterEngineCore' ) ] ]
]
