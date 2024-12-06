Class {
	#name : #BaselineOfLepiterEngineCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterEngineCore
}

{ #category : #baseline }
BaselineOfLepiterEngineCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:v0.8.1368/src' ].
		spec
			baseline: 'GToolkitFileUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.348/src' ].
		spec
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.8.2468/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.1884/src' ].
		spec
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:v0.6.1938/src' ].
		spec
			baseline: 'GToolkit4Json' with: [
				spec repository: 'github://feenkcom/gt4json:v0.6.1214/src' ].
		spec
			baseline: 'GToolkitReleaser' with: [
				spec repository: 'github://feenkcom/gtoolkit-releaser:v0.8.254/src' ].
		spec
			baseline: 'LepiterXDoc' with: [
				spec repository: 'github://feenkcom/lepiter:v0.6.2723/src' ].
		spec
			baseline: 'SmaCCRuntime' with: [
				spec repository: 'github://j-brant/SmaCC:v3.0.89' ].
		spec
			baseline: 'JSONParser' with: [
				spec repository: 'github://j-brant/SmaCC:v3.0.89' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:797b7b2ea8b46039b7c30cd3e21129ec79477903/repository' ].
		spec
			baseline: 'JSONWebToken' with: [
				spec repository: 'github://feenkcom/JSONWebToken:v0.5.149/source' ].
		spec
			baseline: 'ZincHTTPComponentsRest' with: [
				spec repository: 'github://feenkcom/zinc:v3.0.61/repository' ].

		spec package: 'Lepiter-Parser' with: [
			spec requires: #(#SmaCCRuntime) ].
		spec package: 'Lepiter-History' with: [
			spec requires: #(#Brick #GToolkitFileUtility) ].
		spec package: 'Lepiter-Core' with: [
			spec requires: #(#'Lepiter-Parser' #JSONParser #'Lepiter-History' #Brick #GToolkitCoder #GToolkit4Pharo) ].
		spec package: 'Lepiter-Utilities' with: [
			spec requires: #(#'Lepiter-Core') ].
		spec package: 'Lepiter-Store' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-Utilities' #GToolkit4Json) ].
		spec package: 'Lepiter-Store-Class' with: [
			spec requires: #(#'Lepiter-Store') ].
		spec package: 'Lepiter-Translator-Roam' with: [
			spec requires: #(#'Lepiter-Store') ].
		spec package: 'Lepiter-Translator-JupyterNotebook' with: [
			spec requires: #(#'Lepiter-Core') ].
		spec package: 'Lepiter-UI-Core' with: [
			spec requires: #(#'Lepiter-Core' #GToolkitInspector #Brick) ].
		spec package: 'Lepiter-UI-Snippet' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-UI-Core' #'Lepiter-Parser') ].
		spec package: 'Lepiter-UI-Page' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-UI-Core' #'Lepiter-UI-Snippet') ].
		spec package: 'Lepiter-UI-IncomingReferences' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-UI-Core' #'Lepiter-UI-Page' #'Lepiter-UI-Snippet') ].
		spec package: 'Lepiter-UI-Utilities'.
		spec package: 'Lepiter-UI' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-Parser' #'Lepiter-UI-Core' #'Lepiter-UI-Snippet' #'Lepiter-UI-Page' #'Lepiter-UI-IncomingReferences' #'Lepiter-UI-Utilities' #'Lepiter-Utilities' #'Lepiter-Store' #'Lepiter-Translator-Roam') ].
		spec package: 'Lepiter-Extensions' with: [
			spec requires: #(#LepiterXDoc #Brick #'Lepiter-Core' #'Lepiter-Store' #'Lepiter-UI' #'Lepiter-UI-Page') ].
		spec package: 'Lepiter-Snippet-Text' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-UI') ].
		spec package: 'Lepiter-ToC' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-UI') ].
		spec package: 'Lepiter-Export' with: [
			spec requires: #(#Brick #'Lepiter-Core' #LepiterXDoc #SmaCCRuntime #'Lepiter-UI-Snippet' #'Lepiter-Store' #'Lepiter-Snippet-Text') ].
		spec package: 'Lepiter-HTML' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-Parser' #'Lepiter-Export' #LepiterXDoc #GToolkitReleaser) ].
		spec package: 'Lepiter-Playground' with: [
			spec requires: #(#'Lepiter-Core' #'Lepiter-Store' #'Lepiter-UI') ].
		spec package: 'Lepiter-Core-Examples' with: [
			spec requires: #(#'Lepiter-Snippet-Text' #'Lepiter-Store-Class' #'Lepiter-Utilities') ].
		spec package: 'Lepiter-BasicServer' with: [
			spec requires: #(#Beacon #JSONWebToken #ZincHTTPComponentsRest) ].
	]
]
