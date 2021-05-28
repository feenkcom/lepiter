Class {
	#name : #BaselineOfLepiterEngineExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterEngineExtensions
}

{ #category : #accessing }
BaselineOfLepiterEngineExtensions class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterEngineExtensions >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterTextSnippet' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterElementSnippet' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterPictureSnippet' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterPharo' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterJavaScript' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterPython' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterWord' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterGitHub' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterJenkins' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterDocker' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterWardleyMap' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterExampleSnippet' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'LepiterChangesSnippet' with: [
					spec repository: 'github://feenkcom/lepiter:main/src' ]
		]
]
