Class {
	#name : #LeExportObjectSpecificationBuilder,
	#superclass : #Object,
	#instVars : [
		'object',
		'specifications',
		'objectSpecifications',
		'objectSpecification'
	],
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #'api - finding' }
LeExportObjectSpecificationBuilder >> find [
	self findSpecifications.
	self pickSpecification.
]

{ #category : #'api - finding' }
LeExportObjectSpecificationBuilder >> findSpecifications [
	objectSpecifications := specifications
			collect: [ :each | each objectSpecificationFor: self newObjectContext ]
			thenReject: #isNil
]

{ #category : #'gt - extensions' }
LeExportObjectSpecificationBuilder >> gtObjectSpecificationsFor: aView [
	<gtView>
	objectSpecifications ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Object specifications';
		priority: 15;
		items: [ objectSpecifications asArray ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Object' text: #object;
		column: 'Specification' text: #specification;
		column: 'Priority' text: #priority width: 50;
		column: 'Picked' text: [ :aObjectSpecification | 
			(objectSpecification == aObjectSpecification)
						ifTrue: [ 'picked' ]
						ifFalse: [ '' ]  ] width: 50
]

{ #category : #'gt - extensions' }
LeExportObjectSpecificationBuilder >> gtSpecificationsFor: aView [
	<gtView>
	specifications ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Specifications';
		priority: 10;
		items: [ specifications asArray ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Name' text: #yourself;
		column: 'Possibility' text: [ :aSpecification | 
			objectSpecifications ifNotNil: [ :aCollection | 
				aCollection 
					detect: [ :anObjectSpecification | 
						anObjectSpecification specification = aSpecification ] 
					ifFound: [ :anObjectSpecification | 'possible' ]
					ifNone: [ 
						aCollection 
							detect: [ :each | 
								| isInvolved |
								isInvolved := false.
								each objectSpecificationsDo: [ :anObjectSpecification |
									anObjectSpecification specification = aSpecification
										ifTrue: [ isInvolved := true ] ].
								isInvolved ]
							ifFound: [ :anObjectSpecification | 'involved' ] 
							ifNone: [ '' ]
					 ] ] ] width: 70;
		column: 'Priority' text: [ :aSpecification | 
			objectSpecifications ifNotNil: [ :aCollection | 
				aCollection 
					detect: [ :anObjectSpecification | 
						anObjectSpecification specification = aSpecification ] 
					ifFound: [ :anObjectSpecification | anObjectSpecification priority ]
					ifNone: [ '' ] ] ] width: 50;
		column: 'Picked' text: [ :aSpecification | 
			(objectSpecification specification == aSpecification)
						ifTrue: [ 'picked' ]
						ifFalse: [ '' ]  ] width: 50;
		send: [ :aSpecification |
			objectSpecifications ifNotNil: [ :aCollection | 
				aCollection 
					detect: [ :anObjectSpecification | 
						anObjectSpecification specification = aSpecification ] 
					ifFound: [ :anObjectSpecification | anObjectSpecification ]
					ifNone: [  
						aCollection 
							detect: [ :each | 
								| isInvolved |
								isInvolved := false.
								each objectSpecificationsDo: [ :anObjectSpecification |
									anObjectSpecification specification = aSpecification
										ifTrue: [ isInvolved := true ] ].
								isInvolved ]
							ifFound: [ :anObjectSpecification | anObjectSpecification ] 
							ifNone: [ aSpecification ]
					  ] ] ]
]

{ #category : #'private - finding' }
LeExportObjectSpecificationBuilder >> newObjectContext [
	^ LeExportObjectSpecificationContext new
		specifications: specifications;
		object: object
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> object [
	^ object
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> object: anObject [
	object := anObject
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> objectSpecification [
	<return: #TLeExportObjectSpecification>
	^ objectSpecification
]

{ #category : #'private - finding' }
LeExportObjectSpecificationBuilder >> pickSpecification [
	objectSpecifications ifEmpty: [ ^ self ].
	objectSpecification := objectSpecifications detectMin: #priority
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> specifications [
	<return: #TLeExportSpecifications>
	^ specifications
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> specifications: anObject [
	specifications := anObject
]
