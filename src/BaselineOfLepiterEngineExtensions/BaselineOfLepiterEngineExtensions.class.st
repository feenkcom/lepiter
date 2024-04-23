Class {
	#name : #BaselineOfLepiterEngineExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterEngineExtensions
}

{ #category : #baseline }
BaselineOfLepiterEngineExtensions >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'LepiterEngineCore' with: [
				spec repository: 'github://feenkcom/lepiter:main/src' ];
			baseline: 'GToolkit4DockerEngine' with: [
				spec repository: 'github://feenkcom/gt4dockerengine:main/src' ];
			baseline: 'Gt4JSLink' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote-javascript:main/src' ];
			baseline: 'Gt4ChromeDevTools' with: [
				spec repository: 'github://feenkcom/gtoolkit-chrome:main/src' ];
			baseline: 'Gt4PythonBridge' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote-python:main/src' ];
			baseline: 'Gt4DebugAdapterProtocol' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugadapterprotocol:main/src' ];
			baseline: 'Gt4PharoLink' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote:main/src' ];
			baseline: 'GToolkitVisualizer' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:main/src' ];
			baseline: 'LepiterYoutube' with: [
				spec repository: 'github://feenkcom/lepiter:main/src' ];
			baseline: 'GToolkit4LSP' with: [
				spec repository: 'github://feenkcom/gt4lsp:main/src' ].
		spec 
			package: 'Lepiter-Pharo' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Example' with: [
				spec requires: #('LepiterEngineCore' 'Lepiter-Pharo' ). ];
			package: 'Lepiter-Snippet-Element' with: [
				spec requires: #('LepiterEngineCore' 'Lepiter-Pharo' ). ];
			package: 'Lepiter-Snippet-Picture' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Words' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-GitHub' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-WardleyMap' with: [
				spec requires: #('LepiterEngineCore' 'GToolkitVisualizer' ). ];
			package: 'Lepiter-Snippet-Changes' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Jenkins' with: [
				spec requires: #('LepiterEngineCore' ). ];
			package: 'Lepiter-Snippet-Docker' with: [
				spec requires: #('LepiterEngineCore' 'GToolkit4DockerEngine' ). ];
			package: 'Lepiter-JavaScript' with: [
				spec requires: #('LepiterEngineCore' 'Gt4JSLink' 'Gt4ChromeDevTools' ). ];
			package: 'Lepiter-Python' with: [
				spec requires: #('LepiterEngineCore' 'Gt4PythonBridge' 'GToolkit4LSP' ). ];
			package: 'Lepiter-Snippet-PharoLink' with: [
				spec requires: #('LepiterEngineCore' 'Gt4PharoLink' ). ];
			package: 'Lepiter-Snippet-Pharo-Rewrites' with: [
				spec requires: #('LepiterEngineCore' ) ];
			package: 'Lepiter-Snippet-SmaCC-Rewrites' with: [
				spec requires: #('LepiterEngineCore' ) ];
			package: 'Lepiter-Snippet-String' with: [
				spec requires: #('LepiterEngineCore' ) ];
			package: 'Lepiter-Snippet-File' with: [
				spec requires: #('LepiterEngineCore' ) ];
			package: 'Lepiter-Snippet-Shell' with: [
				spec requires: #('LepiterEngineCore' ) ] ].

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
