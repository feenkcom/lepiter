Class {
	#name : #LeUrlLinkContextMenuExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #examples }
LeUrlLinkContextMenuExamples >> copyUrlString [
	<gtExample>
	| aScripter |
	aScripter := self rightClickOnLink.
	aScripter click
		label: 'Click on menu item';
		onSpaceRoot;
		id: #'menu--copy-url';
		play.
	aScripter
		assertStep: [ :s | 
			s
				label: 'Check URL string has been set as the value of the clipboard.';
				value: [ GtClipboard clipboardText asString ]
					equals: 'https://www.gtoolkit.com/' ].
	^ aScripter
]

{ #category : #examples }
LeUrlLinkContextMenuExamples >> inspectUrlString [
	<gtExample>
	| aScripter |
	aScripter := self rightClickOnLink.
	aScripter click
		label: 'Click on menu item';
		onSpaceRoot;
		id: #'menu--inspect-string';
		play.
	aScripter
		assertStep: [ :s | 
			s
				label: 'Check URL string inspector exists';
				value: [ aScripter element pagerModel allFollowingPanes last phlowTool objectHolder
							object ]
					equals: 'https://www.gtoolkit.com/' ].
	^ aScripter
]

{ #category : #examples }
LeUrlLinkContextMenuExamples >> pageWithTextSnippetWithUrlLink [
	<gtExample>
	| aPage aScripter linkText |
	linkText := '[Glamorous Toolkit](https://www.gtoolkit.com) '.
	aPage := LePage new
			addSnippet: (LeTextSnippet new text: linkText asRopedText);
			yourself.
	aScripter := BlScripter new
			element: (GtPagerSettings usedPager createWrappedOn: aPage asPhlowTool).
	aScripter
		substep: 'Hide annotation text'
		do: [ :aStep | 
			| aSnippet |
			aSnippet := (aScripter element query // LeTextCoderSnippetElement) anyOne.
			aSnippet snippetViewModel moveCursorAt: linkText size - 2.
			aStep keyPress: BlKeyboardKey arrowRight.
			aStep
				keyPress: BlKeyboardKey arrowRight;
				play ].
	^ aScripter
]

{ #category : #examples }
LeUrlLinkContextMenuExamples >> rightClickOnLink [
	<gtExample>
	| aScripter |
	aScripter := self pageWithTextSnippetWithUrlLink.
	aScripter secondaryClick
		label: 'Right Click Link';
		id: #'lepiter--external-link';
		play.
	aScripter.
	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert Context Menu Exists';
				onSpaceRoot;
				id: #'menu--copy-url' ].
	^ aScripter
]
