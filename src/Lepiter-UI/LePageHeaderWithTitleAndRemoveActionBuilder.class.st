Class {
	#name : #LePageHeaderWithTitleAndRemoveActionBuilder,
	#superclass : #LePageHeaderBuilder,
	#category : 'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderWithTitleAndRemoveActionBuilder >> build [
	self removeAllItems.
	self addTitle.
	self addFlexibleSeparator.
	self addRemoteLinkToClipboardButton.
	self addRemovePageButton.
	self addTableOfContentsToggle.
	self addExtensionButtons.
]
