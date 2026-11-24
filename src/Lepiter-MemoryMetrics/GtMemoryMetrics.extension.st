Extension { #name : #GtMemoryMetrics }

{ #category : #'*Lepiter-MemoryMetrics' }
GtMemoryMetrics class >> totalAnalysedSize [
	"Code-related entities, the GT Book database and the space tally history.
	The index of the GT Book is part of both the code-related entities and the GT Book, so we count it once."

	<gtExample>
	<noTest>
	^ self default totalCodeAnalysedSize + GtLepiterMemoryMetrics totalGtBookSize
		- self default totalLepiterGtBookIndexSize
		+ self default totalSpaceTallyHistorySize

]

{ #category : #'*Lepiter-MemoryMetrics' }
GtMemoryMetrics class >> totalNotAnalysedSize [
	"The part of the image in memory that is not analysed: global state of the system 
	(for example fonts and caches), objects created by the UI and the user, and other databases"

	<gtExample>
	<noTest>
	^ self totalImageSizeInMemory - self totalAnalysedSize max: 0
]
