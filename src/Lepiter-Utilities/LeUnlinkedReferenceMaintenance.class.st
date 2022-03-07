"
LeUnlinkedReferenceMaintenace updates all unlinked references originating from sourceBlock (LeSnippet). 
Since this is cpu expensive (it requires scanning all pages titles for a match), updates are typically submitted to the nonUISinglePool pool.

It uses an ""eventually correct"" model - updates to snippets are processed as soon as the snippet is modified, however new pages will only be indexed as snippets are updated.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	sourceBlock:		<LeSnippet>


### Implementation Points

"
Class {
	#name : #LeUnlinkedReferenceMaintenance,
	#superclass : #Object,
	#instVars : [
		'newLinksByPage',
		'sourceBlock',
		'sourceString',
		'linkedPages',
		'runningPromise'
	],
	#category : #'Lepiter-Utilities-Utilities'
}

{ #category : #'instance creation' }
LeUnlinkedReferenceMaintenance class >> forBlock: aLeBlock [

	(aLeBlock isNil or: [ aLeBlock database isDatabase not]) ifTrue: [ ^ nil ].
	^ self new sourceBlock: aLeBlock
]

{ #category : #'instance creation' }
LeUnlinkedReferenceMaintenance class >> submitForBlock: aLeBlock [

	^ (self forBlock: aLeBlock) ifNotNil: 
		[ :maintainer | maintainer submit ]
]

{ #category : #'instance creation' }
LeUnlinkedReferenceMaintenance class >> synchronouslyUpdateDatabase: aLeDatabase [
	"Update all snippets in the supplied database in the calling process.
	This is normally only used for example methods where we want to be sure that the unlinked references are in a known state."

	BlUseAsyncFeatures disableDuring: 
		[ self updateDatabase: aLeDatabase ]

]

{ #category : #'instance creation' }
LeUnlinkedReferenceMaintenance class >> updateDatabase: aLeDatabase [
	"Update all snippets in the supplied database.
	This is normally only used for example methods where we want to be sure that the unlinked references are in a known state."

	aLeDatabase snippetsDo: [ :aLeSnippet |
		self submitForBlock: aLeSnippet ]
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenance >> database [ 

	^ sourceBlock database
]

{ #category : #initialization }
LeUnlinkedReferenceMaintenance >> initialize [ 

	super initialize.
	newLinksByPage := Dictionary new.
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenance >> linkedPages [ 

	^ linkedPages ifNil: 
		[ linkedPages := (self linkedPagesFrom: sourceBlock) 
			collect: [ :each | each asLowercase] as: Array. ]
]

{ #category : #private }
LeUnlinkedReferenceMaintenance >> linkedPagesFrom: aLeBlock [
	"Answer the titles of all the pages linked from aLeBlock"
	| visitor |

	visitor := LePageLinkVisitor new.
	visitor acceptNode: aLeBlock ast.
	^ visitor linkedPages.
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenance >> logicalDatabase [ 

	^ self database logicalDatabase
]

{ #category : #private }
LeUnlinkedReferenceMaintenance >> newLinksFor: page [
	"Answer the unlinked references to the supplied page"

	^ newLinksByPage at: page title ifAbsent: [ #() ]
]

{ #category : #running }
LeUnlinkedReferenceMaintenance >> run [
	"Update the unlinked references from sourcePage"

	LeReferenceMaintenanceSignal new 
		page: sourceBlock;
		operation: #run;
		parameter: #start;
		emit.
	self scanForLinks.
	self updateDestinationPages.
	LeReferenceMaintenanceSignal new 
		page: sourceBlock;
		operation: #run;
		parameter: #done;
		emit.

]

{ #category : #private }
LeUnlinkedReferenceMaintenance >> scanForLinks [
	"Iterate over the page names and build links for any matches.
	Only take into account named pages."
	
	self logicalDatabase pagesDo: [ :page |
		page type isNamedPageType ifTrue: [ 
			self scanPage: page ] ]
]

{ #category : #private }
LeUnlinkedReferenceMaintenance >> scanPage: page [
	"Scan the block to see if it has unlinked references the supplied page.
	If it also has linked references it doesn't count."
	| matches title |

	page = sourceBlock page ifTrue: [ ^ self ].
	title := page title asLowercase.
	"This is a match if the sourceBlock doesn't have an explicit link to the page and 
	the title is included in the source block"
	matches := (self linkedPages includes: title) not and:
		[ (self sourceString indexOfSubCollection: title) > 0 ].
	matches ifTrue:
			[ (newLinksByPage at: page title ifAbsentPut: [ OrderedCollection new ]) add:
				(LeImplicitPageLink new 
					title: page title;
					origin: sourceBlock;
					target: page) ].
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenance >> sourceBlock [
	^ sourceBlock
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenance >> sourceBlock: aLeBlock [

	sourceBlock := aLeBlock.

]

{ #category : #accessing }
LeUnlinkedReferenceMaintenance >> sourceString [
	^ sourceString
		ifNil: [ sourceString := (sourceBlock isTextSnippet
				ifTrue: [ String
						streamContents: [ :stream | 
							sourceBlock ast
								acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ] ]
				ifFalse: [ sourceBlock contentAsString ]) asLowercase ]
]

{ #category : #running }
LeUnlinkedReferenceMaintenance >> submit [

	"Submit the receiver for processing in the low priority non-UI single pool.
	If BlUseAsyncFeatures are disabled, run immediately"

	runningPromise ifNotNil: [ runningPromise cancelSoft ].

	BlUseAsyncFeatures
		ifEnabledDo: [
			runningPromise := [ self run ] asAsyncFuture
				await: (AsyncFutureExecutionConfiguration new customGroup: #Lepiter) ]
		otherwise: [ self run ]
]

{ #category : #private }
LeUnlinkedReferenceMaintenance >> updateDestinationPages [
	"Update all the pages in the database with updated links"

	self logicalDatabase pagesDo: [ :page |
		page type isNamedPageType ifTrue: [ 
			page
				removeAllIncomingUnlinkedSuchThat: [ :link | link origin = sourceBlock ];
				addAllIncomingUnlinked: (self newLinksFor: page) ] ]
]
