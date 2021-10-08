"
Lepiter snippet that allows users to link to an existing GToolkit Example.

"
Class {
	#name : #ManifestLepiterSnippetExample,
	#superclass : #PackageManifest,
	#category : 'Lepiter-Snippet-Example-Manifest'
}

{ #category : #'private - templates' }
ManifestLepiterSnippetExample class >> notifyChangeTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self notifyAnnouncement: ({{announcement}} new
		source: self;
		snippet: self;
		{{announcementSetter gtAsReader}}: self {{propertyGetter}}).';
		storageMethod: thisContext method
]

{ #category : #'private - templates' }
ManifestLepiterSnippetExample class >> snippet [
"
@prefix Le
@package 'Lepiter-Snippet-Example'
@tag 'Snippet'
@suffix Snippet

example {
	@derive superclass(name: LeSnippet),
	@derive property(
		name: exampleBehaviorName,
		type: Symbol,
		announcement: LeExampleSnippetContentChanged,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate),
	@derive property(
		name: exampleSelector,
		announcement: LeExampleSnippetContentChanged,
		type: Symbol,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate),
	@derive property(
		name: codeExpanded,
		announcement: LeExampleSnippetContentChanged,
		type: Boolean,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate),
	@derive property(
		name: noCode,
		announcement: LeExampleSnippetContentChanged,
		type: Boolean,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate),
	@derive property(
		name: previewExpanded,
		announcement: LeExampleSnippetContentChanged,
		type: Boolean,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate),
	@derive property(
		name: previewShowSelector,
		announcement: LeExampleSnippetContentChanged,
		type: Symbol,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate),
	@derive property(
		name: previewHeight,
		announcement: LeExampleSnippetContentChanged,
		type: Number,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate)
}
"
]

{ #category : #'private - templates' }
ManifestLepiterSnippetExample class >> snippetViewModel [
"
@prefix Le
@package 'Lepiter-Snippet-Example'
@tag 'Snippet'
@suffix SnippetViewModel

example {
	@derive superclass(name: LeSnippetViewModel),
	@derive mirror(name: exampleBehaviorName, behavior: LeExampleSnippet),
	@derive mirror(name: exampleSelector, behavior: LeExampleSnippet),
	@derive mirror(name: codeExpanded, behavior: LeExampleSnippet),
	@derive mirror(name: noCode, behavior: LeExampleSnippet),
	@derive mirror(name: previewExpanded, behavior: LeExampleSnippet),
	@derive mirror(name: previewShowSelector, behavior: LeExampleSnippet),
	@derive mirror(name: previewHeight, behavior: LeExampleSnippet),
	@derive property(name: annotationCoderViewModel, type: GtTextCoder)
}
"
]
