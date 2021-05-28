Class {
	#name : #BaselineOfLepiterElementSnippet,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterElementSnippet
}

{ #category : #accessing }
BaselineOfLepiterElementSnippet class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterElementSnippet >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterPharo' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Snippet-Element' with: [
					spec requires: #( 'LepiterEngineCore' 'LepiterPharo') ] ]
]
