Extension { #name : #GtTreePagerExamples }

{ #category : #'*Lepiter-Pharo' }
GtTreePagerExamples >> pagerWithPharoLepiterPage [
	<gtExample>
	| aPageHolder aPager aPaneModel |
	aPager := self basicPagerModel.
	aPageHolder := LeModelExamples new pageOneWithPageHavingManyPharoSnippets.
	aPaneModel := self basicPaneModel object: aPageHolder page.

	aPager paneModel: aPaneModel.
	aPager optionAt: #pageHolder put: aPageHolder.

	^ aPager
]
