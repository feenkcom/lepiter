"
I add a title and an inspect button to a header.
I am used by {{gtClass:LePageToolContentElement}} in {{gtMethod:LePageToolContentElement>>#withTitleAndInspectButton|label=#selector}}.
## Example
{{gtExample:LeUIExamples>>#pageToolContentElement_TitleAndInspectButton|previewExpanded|codeExpanded=false}}

"
Class {
	#name : #LePageHeaderWithTitleAndInspectButtonBuilder,
	#superclass : #LePageHeaderBuilder,
	#category : 'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderWithTitleAndInspectButtonBuilder >> build [
	self removeAllItems.
	self addTitle.
	self addFlexibleSeparator.
	self addRemoteLinkToClipboardButton.
	self addInspectButton.
]
