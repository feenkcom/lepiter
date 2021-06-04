"
LeUnlinkedReferenceMaintenace updates all unlinked references originating from sourcePage. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	sourcePage:		<LePage>


!!!Implementation Points
"
Class {
	#name : #LeUnlinkedReferenceMaintenace,
	#superclass : #Object,
	#instVars : [
		'newLinksByPage',
		'sourceBlock',
		'sourceString',
		'linkedPages'
	],
	#category : #'Lepiter-Utilities-Utilities'
}

{ #category : #'instance creation' }
LeUnlinkedReferenceMaintenace class >> forBlock: aLeBlock [

	(aLeBlock isNil or: [ aLeBlock database isDatabase not]) ifTrue: [ ^ nil ].
	^ self new sourceBlock: aLeBlock
]

{ #category : #'instance creation' }
LeUnlinkedReferenceMaintenace class >> submitForBlock: aLeBlock [

	^ (self forBlock: aLeBlock) ifNotNil: 
		[ :maintainer | maintainer submit ]
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenace >> database [ 

	^ sourceBlock database
]

{ #category : #initialization }
LeUnlinkedReferenceMaintenace >> initialize [ 

	super initialize.
	newLinksByPage := Dictionary new.
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenace >> linkedPages [ 

	^ linkedPages ifNil: 
		[ linkedPages := (self linkedPagesFrom: sourceBlock) 
			collect: [ :each | each asLowercase] as: Array. ]
]

{ #category : #private }
LeUnlinkedReferenceMaintenace >> linkedPagesFrom: aLeBlock [
	"Answer the titles of all the pages linked from aLeBlock"
	| visitor |

	visitor := LePageLinkVisitor new.
	visitor acceptNode: aLeBlock ast.
	^ visitor linkedPages.
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenace >> logicalDatabase [ 

	^ self database logicalDatabase
]

{ #category : #private }
LeUnlinkedReferenceMaintenace >> newLinksFor: page [
	"Answer the unlinked references to the supplied page"

	^ newLinksByPage at: page title ifAbsent: [ #() ]
]

{ #category : #running }
LeUnlinkedReferenceMaintenace >> run [
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
LeUnlinkedReferenceMaintenace >> scanForLinks [
	"Iterate over the page names and build links for any matches.
	Only take into account named pages."
	
	self logicalDatabase pagesDo: [ :page |
		page type isNamedPageType ifTrue: [ 
			self scanPage: page ] ]
]

{ #category : #private }
LeUnlinkedReferenceMaintenace >> scanPage: page [
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
LeUnlinkedReferenceMaintenace >> sourceBlock [
	^ sourceBlock
]

{ #category : #accessing }
LeUnlinkedReferenceMaintenace >> sourceBlock: aLeBlock [

	sourceBlock := aLeBlock.

]

{ #category : #accessing }
LeUnlinkedReferenceMaintenace >> sourceString [
	^ sourceString
		ifNil: [ sourceString := (sourceBlock isTextSnippet
				ifTrue: [ String
						streamContents: [ :stream | 
							sourceBlock ast
								acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ] ]
				ifFalse: [ sourceBlock contentAsString ]) asLowercase ]
]

{ #category : #running }
LeUnlinkedReferenceMaintenace >> submit [ 
	"Submit the receiver for processing in the low priority non-UI single pool.
	If BlUseAsyncFeatures are disabled, run immediately"

	BlUseAsyncFeatures 
		ifEnabledDo: [ BlTktWorkerProvider nonUISinglePool schedule: 
			([ self run ] asBlTktCommand asBlTktSingleCommand identifier: sourceBlock) ]
		otherwise: [ self run ].
]

{ #category : #private }
LeUnlinkedReferenceMaintenace >> updateDestinationPages [
	"Update all the pages in the database with updated links"

	self logicalDatabase pagesDo: [ :page |
		page type isNamedPageType ifTrue: [ 
			page
				removeAllIncomingUnlinkedSuchThat: [ :link | link origin = sourceBlock ];
				addAllIncomingUnlinked: (self newLinksFor: page) ] ]
]
