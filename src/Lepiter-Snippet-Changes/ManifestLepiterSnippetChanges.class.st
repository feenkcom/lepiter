"
Lepiter snippet that allows users to display .ombu changes file using Epicea
"
Class {
	#name : #ManifestLepiterSnippetChanges,
	#superclass : #PackageManifest,
	#category : #'Lepiter-Snippet-Changes-Manifest'
}

{ #category : #accessing }
ManifestLepiterSnippetChanges class >> model [
"@prefix Le
@package 'Lepiter-Snippet-Changes'
@tag 'Snippet'
@suffix Snippet

changes {
	@derive superclass(name: LeSnippet),
	@derive property(
		name: fileName,
		type: String,
		announcement: LeSnippetContentChanged,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate),
	@derive property(
		name: previewHeight,
		announcement: LeSnippetContentChanged,
		type: Number,
		notifier: ManifestLepiterSnippetExample class>>#notifyChangeTemplate)
}"
]

{ #category : #accessing }
ManifestLepiterSnippetChanges class >> viewModel [
"@prefix Le
@package 'Lepiter-Snippet-Changes'
@tag 'Snippet'
@suffix SnippetViewModel

changes {
	@derive superclass(name: LeSnippetViewModel),
	@derive mirror(name: fileName, behavior: LeChangesSnippet),
	@derive mirror(name: previewHeight, behavior: LeChangesSnippet),
	@derive property(name: changes, type: GtEpicea),
	@derive property(name: fileNameCoderViewModel, type: GtTextCoder)
}"
]
