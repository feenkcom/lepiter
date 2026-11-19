"
I notify the {{gtClass:LeCodeSnippet}} that created a coder about the changes of that coder, so the snippet needs no subscription on the coder's announcer.
I hold the snippet strongly: a snippet and its coder live and die together. See {{gtClass:LeCodeSnippetCoderNotifierExamples}}.
"
Class {
	#name : #LeCodeSnippetCoderNotifier,
	#superclass : #GtTextualCoderNotifier,
	#instVars : [
		'snippet'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeCodeSnippetCoderNotifier class >> snippet: aLeCodeSnippet [
	^ self new snippet: aLeCodeSnippet
]

{ #category : #notifying }
LeCodeSnippetCoderNotifier >> notifyRenameTemporaryRequested: aGtCoderRenameTemporaryRequestedAnnouncement [
	snippet
		onCoderRenameTemporaryRequested: aGtCoderRenameTemporaryRequestedAnnouncement
]

{ #category : #notifying }
LeCodeSnippetCoderNotifier >> notifySourceCodeChanged: aGtCoderSourceCodeChanged [
	snippet onCoderSourceModified: aGtCoderSourceCodeChanged
]

{ #category : #accessing }
LeCodeSnippetCoderNotifier >> snippet [
	<return: #LeCodeSnippet>
	^ snippet
]

{ #category : #accessing }
LeCodeSnippetCoderNotifier >> snippet: aLeCodeSnippet [
	snippet := aLeCodeSnippet
]
