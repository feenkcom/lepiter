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
				spec repository: 'github://feenkcom/lepiter:v0.6.2949/src' ].
		spec
			baseline: 'GToolkit4DockerEngine' with: [
				spec repository: 'github://feenkcom/gt4dockerengine:v0.5.133/src' ].
		spec
			baseline: 'Gt4JSLink' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote-javascript:v0.5.711/src' ].
		spec
			baseline: 'Gt4ChromeDevTools' with: [
				spec repository: 'github://feenkcom/gtoolkit-chrome:v0.5.219/src' ].
		spec
			baseline: 'Gt4PythonBridge' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote-python:v0.5.402/src' ].
		spec
			baseline: 'Gt4DebugAdapterProtocol' with: [
				spec repository: 'github://feenkcom/gtoolkit-debugadapterprotocol:v0.5.391/src' ].
		spec
			baseline: 'Gt4PharoLink' with: [
				spec repository: 'github://feenkcom/gtoolkit-remote:v0.8.1972/src' ].
		spec
			baseline: 'GToolkitVisualizer' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.8.2214/src' ].
		spec
			baseline: 'LepiterYoutube' with: [
				spec repository: 'github://feenkcom/lepiter:v0.6.2949/src' ].
		spec
			baseline: 'GToolkit4LSP' with: [
				spec repository: 'github://feenkcom/gt4lsp:v0.6.660/src' ].

		spec package: 'Lepiter-Pharo' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-Example' with: [
			spec requires: #(#LepiterEngineCore #'Lepiter-Pharo') ].
		spec package: 'Lepiter-Snippet-Element' with: [
			spec requires: #(#LepiterEngineCore #'Lepiter-Pharo') ].
		spec package: 'Lepiter-Snippet-Picture' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-Words' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-GitHub' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-WardleyMap' with: [
			spec requires: #(#LepiterEngineCore #GToolkitVisualizer) ].
		spec package: 'Lepiter-Snippet-Changes' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-Jenkins' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-Docker' with: [
			spec requires: #(#LepiterEngineCore #GToolkit4DockerEngine) ].
		spec package: 'Lepiter-JavaScript' with: [
			spec requires: #(#LepiterEngineCore #Gt4JSLink #Gt4ChromeDevTools) ].
		spec package: 'Lepiter-Python' with: [
			spec requires: #(#LepiterEngineCore #Gt4PythonBridge #GToolkit4LSP) ].
		spec package: 'Lepiter-Snippet-PharoLink' with: [
			spec requires: #(#LepiterEngineCore #Gt4PharoLink) ].
		spec package: 'Lepiter-Snippet-Pharo-Rewrites' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-SmaCC-Rewrites' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-String' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-File' with: [
			spec requires: #(#LepiterEngineCore) ].
		spec package: 'Lepiter-Snippet-Shell' with: [
			spec requires: #(#LepiterEngineCore) ].
	]
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
