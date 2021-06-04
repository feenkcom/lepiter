"
I add a title and an inspect button to a header.
I am used by ${class:LePageToolContentElement}$ in ${method:LePageToolContentElement>>#withTitleAndInspectButton|label=#selector}$.
!! Example
${example:LeUIExamples>>#pageToolContentElement_TitleAndInspectButton|previewExpanded|codeExpanded=false}$
"
Class {
	#name : #LePageHeaderWithTitleAndInspectButtonBuilder,
	#superclass : #LePageHeaderBuilder,
	#category : #'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderWithTitleAndInspectButtonBuilder >> build [
	self removeAllItems.
	self addTitle.
	self addFlexibleSeparator.
	self addRemoteLinkToClipboardButton.
	self addInspectButton.
]
