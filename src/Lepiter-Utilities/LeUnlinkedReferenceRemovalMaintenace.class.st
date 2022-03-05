"
LeUnlinkedReferenceRemovalMaintenace takes care of removing incoming unreferenced links when a block is deleted.

As a scan of all pages in the database is required, this is typically submitted as a background process.


 
## Internal Representation and Key Implementation Points.

### Instance Variables
	database:				<LeDatabase>
	sourceSnippet:		<LeSnippet>


### Implementation Points

"
Class {
	#name : #LeUnlinkedReferenceRemovalMaintenace,
	#superclass : #Object,
	#instVars : [
		'database',
		'sourceSnippet'
	],
	#category : #'Lepiter-Utilities-Utilities'
}

{ #category : #'instance creation' }
LeUnlinkedReferenceRemovalMaintenace class >> forSnippet: snippet database: database [

	^ self new
		sourceSnippet: snippet;
		database: database.
]

{ #category : #'instance creation' }
LeUnlinkedReferenceRemovalMaintenace class >> submitForSnippet: aLeSnippet database: aLeDatabase [

	(aLeSnippet isNil or: [ aLeDatabase isNil ]) ifTrue: [ ^ self ].
	^ (self forSnippet: aLeSnippet database: aLeDatabase) submit
]

{ #category : #accessing }
LeUnlinkedReferenceRemovalMaintenace >> database [
	^ database
]

{ #category : #accessing }
LeUnlinkedReferenceRemovalMaintenace >> database: anObject [
	database := anObject
]

{ #category : #running }
LeUnlinkedReferenceRemovalMaintenace >> run [
	"Update the unlinked references from sourcePage"

	LeReferenceMaintenanceSignal new 
		page: sourceSnippet;
		operation: #run;
		parameter: #start;
		emit.
	self scanForLinks.
	LeReferenceMaintenanceSignal new 
		page: sourceSnippet;
		operation: #run;
		parameter: #done;
		emit.

]

{ #category : #private }
LeUnlinkedReferenceRemovalMaintenace >> scanForLinks [
	"Iterate over all pages in the receiver's database and remove any incoming unlinked references from the receiver's block"

	self database do: [ :page |
		self scanPage: page ]
]

{ #category : #private }
LeUnlinkedReferenceRemovalMaintenace >> scanPage: page [
	"Remove any incoming unlinked references from the receiver's snippet from the supplied page"
	| matches incomingLinks |

	(page = sourceSnippet page or: [ page hasIncomingUnlinked not ]) ifTrue: [ ^ self ].

	incomingLinks := page incomingUnlinked.
	matches := incomingLinks select: [ :each | each origin = sourceSnippet ].
	page incomingUnlinked removeAll: matches.

]

{ #category : #accessing }
LeUnlinkedReferenceRemovalMaintenace >> sourceSnippet [
	^ sourceSnippet
]

{ #category : #accessing }
LeUnlinkedReferenceRemovalMaintenace >> sourceSnippet: anObject [
	sourceSnippet := anObject
]

{ #category : #running }
LeUnlinkedReferenceRemovalMaintenace >> submit [ 
	"Submit the receiver for processing in the low priority non-UI single pool"

	BlUseAsyncFeatures 
		ifEnabledDo: [ [ self run ] asAsyncFuture await: (AsyncFutureExecutionConfiguration new customGroup: #Lepiter) ]
		otherwise: [ self run ]
]
