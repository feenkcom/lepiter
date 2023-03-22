Class {
	#name : #BaselineOfLepiterEngineCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterEngineCore
}

{ #category : #accessing }
BaselineOfLepiterEngineCore class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baseline }
BaselineOfLepiterEngineCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.8.1548/src' ].
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.894/src' ].
		spec
			baseline: 'GToolkit4Json' with: [
				spec repository: 'github://feenkcom/gt4json:v0.6.274/src' ].
		spec
			baseline: 'LepiterXDoc' with: [
				spec repository: 'github://feenkcom/lepiter:v0.6.1394/src' ].

		spec package: 'Lepiter-Parser'.
		spec package: 'Lepiter-History'.
		spec package: 'Lepiter-Core' with: [
			spec requires: #('Lepiter-Parser') ].
		spec package: 'Lepiter-Utilities' with: [
			spec requires: #('Lepiter-Core') ].
		spec package: 'Lepiter-Store' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-Utilities' 'GToolkit4Json') ].
		spec package: 'Lepiter-Translator-Roam' with: [
			spec requires: #('Lepiter-Store') ].
		spec package: 'Lepiter-Translator-JupyterNotebook' with: [
			spec requires: #('Lepiter-Core') ].
		spec package: 'Lepiter-UI-Core' with: [
			spec requires: #('Lepiter-Core' 'GToolkitInspector' 'Brick') ].
		spec package: 'Lepiter-UI-Snippet' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-Parser') ].
		spec package: 'Lepiter-UI-Page' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet') ].
		spec package: 'Lepiter-UI-IncomingReferences' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Page' 'Lepiter-UI-Snippet') ].
		spec package: 'Lepiter-UI-Utilities'.
		spec package: 'Lepiter-UI' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-Parser' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet' 'Lepiter-UI-Page' 'Lepiter-UI-IncomingReferences' 'Lepiter-UI-Utilities' 'Lepiter-Utilities' 'Lepiter-Store' 'Lepiter-Translator-Roam') ].
		spec package: 'Lepiter-Extensions' with: [
			spec requires: #('LepiterXDoc') ].
		spec package: 'Lepiter-Snippet-Text' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-UI') ].
		spec package: 'Lepiter-ToC' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-UI') ].
		spec package: 'Lepiter-HTML' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-Parser' 'LepiterXDoc') ].
		spec package: 'Lepiter-Playground' with: [
			spec requires: #('Lepiter-Core' 'Lepiter-Store' 'Lepiter-UI') ].
		spec package: 'Lepiter-Core-Examples' with: [
			spec requires: #('Lepiter-Snippet-Text') ].
	]
]
