Class {
	#name : #GtAsyncSearchCodeUnitGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : #'Lepiter-Core-Filters'
}

{ #category : #accessing }
GtAsyncSearchCodeUnitGroupStream >> gtItemsFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Items' translated;
		priority: 10;
		stencil: [ 
			BrSimpleList new
				matchParent;
				stream: self asyncSimilarCopy;
				itemType: [ :anItemTypeFactory :aCodeEntity :anItemIndex | 
					aCodeEntity elementTypeForCodeUnitSearch ];
				itemStencil: [  :aCodeEntityItemType :aCodeEntity |
					aCodeEntityItemType createElement ];
				itemDataBinder: [ :aCoderElement :aCodeEntity | 
					aCodeEntity elementTypeForCodeUnitSearch 
						bindElement: aCoderElement
						toEntity: aCodeEntity
						fromFilter: filter  ];
				yourself ]
]
