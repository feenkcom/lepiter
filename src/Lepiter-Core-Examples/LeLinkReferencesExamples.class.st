Class {
	#name : #LeLinkReferencesExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #accessing }
LeLinkReferencesExamples >> databaseOneUuid [
	^ UUID fromString: '916c7567-3b38-4938-8dc6-b567dbeb5bcd'
]

{ #category : #accessing }
LeLinkReferencesExamples >> databaseTwoUuid [
	^ UUID fromString: 'fdcb3a74-c539-4f85-8914-d8eb5ff7c7c9'
]

{ #category : #accessing }
LeLinkReferencesExamples >> pageOneUuid [
	^ UUID fromString: '7da384ea-e510-4913-9694-12fc22c1b8bd'
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByTitle [
	<gtExample>
	<return: #LeLinkPageTextualTitleReference>
	| reference title |
	title := 'Page1'.
	reference := LeLinkPageTextualTitleReference forPageTitle: title.

	self assert: reference targetId equals: title.
	self assert: reference isPageReference.
	self assert: reference isSnippetReference not.
	self assert: reference isResolved not.
	^ reference
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByTitleWithDatabaseUuid [
	<gtExample>
	<return: #LeLinkPageTextualTitleReference>
	| reference databseUuid |
	databseUuid := self databaseOneUuid.
	reference := self pageReferenceByTitle.
	reference targetDatabaseUUID: databseUuid asString36.

	self assert: reference targetDatabaseUUID equals: databseUuid asString36.
	self assert: reference isResolved not.
	^ reference
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByTitleWithDatabaseUuid_equality [
	<gtExample>
	<return: #LeLinkPageTextualTitleReference>
	| referenceA referenceB |
	referenceA := self pageReferenceByTitleWithDatabaseUuid.
	referenceB := LeLinkPageTextualTitleReference forPageTitle: 'Page1'.
	referenceB targetDatabaseUUID: self databaseTwoUuid asString36.

	self assert: (referenceA matches: referenceA).
	self assert: (referenceA matches: self pageReferenceByTitleWithDatabaseUuid).
	self deny: (referenceA matches: referenceB).

	^ referenceA
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByTitle_equality [
	<gtExample>
	<return: #LeLinkPageTextualTitleReference>
	| referenceA referenceB |
	referenceA := self pageReferenceByTitle.
	referenceB := LeLinkPageTextualTitleReference forPageTitle: 'Page2'.

	self assert: (referenceA matches: referenceA).
	self assert: (referenceA matches: self pageReferenceByTitle).
	self deny: (referenceA matches: referenceB).
	self deny: (referenceA matches: self pageReferenceByTitleWithDatabaseUuid).
	self deny: (referenceA matches: self snippetReferenceWithDatabaseUuid).

	^ referenceA
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByUid [
	<gtExample>
	<return: #LeLinkPageUidReference>
	| reference |
	reference := LeLinkPageUidReference forPageUid: self pageOneUuid.

	self assert: reference targetId equals: self pageOneUuid.
	self assert: reference isPageReference.
	self assert: reference isSnippetReference not.
	self assert: reference isResolved not.
	^ reference
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByUidNotEqualToReferenceByTitleWhenTitleIsUUIDString [
	<gtExample>
	<return: #LeLinkPageUidReference>
	| referenceA referenceB |
	referenceA := LeLinkPageUidReference forPageUid: self pageOneUuid.
	referenceB := LeLinkPageTextualTitleReference
			forPageTitle: self pageOneUuid asString.

	self assert: referenceA targetId asString equals: referenceB targetId asString.
	self deny: referenceA targetId = referenceB targetId.
	self deny: (referenceA matches: referenceB).

	^ referenceA
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByUidWithDatabaseUuid [
	<gtExample>
	<return: #LeLinkPageUidReference>
	| reference databseUuid |
	databseUuid := self databaseOneUuid.
	reference := self pageReferenceByUid.
	reference targetDatabaseUUID: databseUuid asString36.

	self assert: reference targetDatabaseUUID equals: databseUuid asString36.
	self assert: reference isResolved not.
	^ reference
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByUidWithDatabaseUuid_equality [
	<gtExample>
	<return: #LeLinkPageUidReference>
	| referenceA referenceB |
	referenceA := self pageReferenceByUidWithDatabaseUuid.
	referenceB := LeLinkPageUidReference forPageUid: self pageOneUuid.
	referenceB targetDatabaseUUID: self databaseTwoUuid asString36.

	self assert: (referenceA matches: referenceA).
	self assert: (referenceA matches: self pageReferenceByUidWithDatabaseUuid).
	self deny: (referenceA matches: self pageReferenceByTitleWithDatabaseUuid).
	self deny: (referenceA matches: referenceB).

	^ referenceA
]

{ #category : #examples }
LeLinkReferencesExamples >> pageReferenceByUid_equality [
	<gtExample>
	<return: #LeLinkPageUidReference>
	| referenceA referenceB uidB |
	referenceA := self pageReferenceByUid.
	uidB := UUID fromString: '10a0de05-c698-40b6-9188-30433363c74f'.
	referenceB := LeLinkPageUidReference forPageUid: uidB.

	self assert: (referenceA matches: referenceA).
	self assert: (referenceA matches: self pageReferenceByUid).
	self deny: (referenceA matches: referenceB).
	self deny: (referenceA matches: self pageReferenceByUidWithDatabaseUuid).

	^ referenceA
]

{ #category : #examples }
LeLinkReferencesExamples >> snippetReference [
	<gtExample>
	<return: #LeLinkSnippetUidReference>
	| reference uid |
	uid := LeUID new uidString: 'txSE1CFVRYu2vAcF6O7o8g=='.
	reference := LeLinkSnippetUidReference forSnippetUid: uid.

	self assert: reference targetId equals: uid.
	self assert: reference isSnippetReference.
	self assert: reference isPageReference not.
	self assert: reference isResolved not.
	^ reference
]

{ #category : #examples }
LeLinkReferencesExamples >> snippetReferenceWithDatabaseUuid [
	<gtExample>
	<return: #LeLinkSnippetUidReference>
	| reference databseUuid |
	databseUuid := self databaseOneUuid.
	reference := self snippetReference.
	reference targetDatabaseUUID: databseUuid asString36.

	self assert: reference targetDatabaseUUID equals: databseUuid asString36.
	self assert: reference isResolved not.
	^ reference
]

{ #category : #examples }
LeLinkReferencesExamples >> snippetReferenceWithDatabaseUuid_equality [
	<gtExample>
	<return: #LeLinkSnippetUidReference>
	| referenceA referenceB |
	referenceA := self snippetReferenceWithDatabaseUuid.
	referenceB := LeLinkSnippetUidReference
			forSnippetUid: (LeUID new uidString: 'NlHHOQGADQCAkgvfCO2heg==').
	referenceB targetDatabaseUUID: self databaseTwoUuid asString36.

	self assert: (referenceA matches: referenceA).
	self assert: (referenceA matches: self snippetReferenceWithDatabaseUuid).
	self deny: (referenceA matches: referenceB).

	^ referenceA
]

{ #category : #examples }
LeLinkReferencesExamples >> snippetReference_equality [
	<gtExample>
	<return: #LeLinkSnippetUidReference>
	| referenceA referenceB |
	referenceA := self snippetReference.
	referenceB := LeLinkSnippetUidReference
			forSnippetUid: (LeUID new uidString: 'txSE1CFVRYu2vA8F6O7o8g==').

	self assert: (referenceA matches: referenceA).
	self assert: (referenceA matches: self snippetReference).
	self deny: (referenceA matches: referenceB).
	self deny: (referenceA matches: self snippetReferenceWithDatabaseUuid).

	^ referenceA
]
