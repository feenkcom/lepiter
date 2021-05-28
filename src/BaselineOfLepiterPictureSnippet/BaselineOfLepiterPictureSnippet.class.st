Class {
	#name : #BaselineOfLepiterPictureSnippet,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterPictureSnippet
}

{ #category : #accessing }
BaselineOfLepiterPictureSnippet class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterPictureSnippet >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Snippet-Picture' with: [
					spec requires: #( 'LepiterEngineCore' ) ] ]
]
