Class {
	#name : #BaselineOfLepiterTextSnippet,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterTextSnippet
}

{ #category : #accessing }
BaselineOfLepiterTextSnippet class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterTextSnippet >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Snippet-Text' with: [
					spec requires: #( 'LepiterEngineCore' ) ] ]
]
