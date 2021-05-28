Class {
	#name : #BaselineOfLepiterExampleSnippet,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterExampleSnippet
}

{ #category : #accessing }
BaselineOfLepiterExampleSnippet class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterExampleSnippet >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Snippet-Example' with: [
					spec requires: #( 'LepiterEngineCore' ) ] ]
]
