"
I add a title and all other action buttons to a header.
I am used by {{gtClass:LePageToolContentElement}} in {{gtMethod:LePageToolContentElement>>#withTitleAndAllActionButtons|label=#selector}}.
1. # Example

{{gtExample:LeUIExamples>>#pageToolContentElement_TitleAndAllActionButtons|previewExpanded|codeExpanded=false}}


"
Class {
	#name : #LePageHeaderWithAllItemsBuilder,
	#superclass : #LePageHeaderBuilder,
	#category : #'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderWithAllItemsBuilder >> build [
	self removeAllItems.
	self addTitle.
	self addRemovePageButton.
	self addFlexibleSeparator.
	self addRemoteLinkToClipboardButton.
	self addInspectButton.
]
