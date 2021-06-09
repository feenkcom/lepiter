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

{ #category : #baseline }
BaselineOfLepiterEngineExtensions >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'LepiterEngineCore' with: [
				spec repository: 'github://feenkcom/lepiter:v0.6.23/src' ];
			baseline: 'GToolkit4DockerEngine' with: [
				spec repository: 'github://feenkcom/gt4dockerengine:v0.5.126/src' ];
			baseline: 'Gt4JSLink' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote-javascript:v0.5.174/src' ];
			baseline: 'Gt4ChromeDevTools' with: [
				spec repository: 'github://feenkcom/gtoolkit-chrome:v0.5.126/src' ];
			baseline: 'Gt4PythonBridge' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote-python:v0.5.143/src' ];
			baseline: 'Gt4DebugAdapterProtocol' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugadapterprotocol:v0.5.142/src' ].
		spec 
			package: 'Lepiter-Snippet-Text' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Pharo' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Element' with: [
				spec requires: #('LepiterEngineCore' 'Lepiter-Pharo' ). ];
			package: 'Lepiter-Snippet-Picture' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Words' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-GitHub' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-WardleyMap' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Example' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Changes' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Jenkins' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Docker' with: [
				spec requires: #('LepiterEngineCore' 'GToolkit4DockerEngine' ). ];
			package: 'Lepiter-JavaScript' with: [
				spec requires: #('LepiterEngineCore' 'Gt4JSLink' 'Gt4ChromeDevTools' ). ];
			package: 'Lepiter-Python' with: [
				spec requires: #('LepiterEngineCore' 'Gt4PythonBridge' ). ]. ].

]

{ #category : #baselines }
BaselineOfLepiterEngineExtensions >> baselineOld: spec [
	spec
		for: #common do: [
			spec
				baseline: 'LepiterTextSnippet' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterElementSnippet' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterPictureSnippet' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterPharo' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterJavaScript' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterPython' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterWord' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterGitHub' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterJenkins' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterDocker' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterWardleyMap' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterExampleSnippet' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ];
				baseline: 'LepiterChangesSnippet' with: [
					spec repository: 'github://feenkcom/lepiter-engine:main/src' ]
		]
]
