Class {
	#name : #LeWardleyMapSnippetGroup,
	#superclass : #LeSnippetGroup,
	#category : #'Lepiter-Snippets'
}

{ #category : #accessing }
LeWardleyMapSnippetGroup >> gtNodeProfilesFor: aView [
	<gtView>
	| elements |
	^ aView columnedList
		title: 'Node profiles';
		items: [ ((self items
				flatCollect: [ :aSnippet | aSnippet wardleyMap nodes collect: [ :aNode | aNode -> aSnippet ] ])
				groupedBy: [ :each | each key label ]) associations
				sorted: [ :a :b | a key asLowercase < b key asLowercase ] ];
		column: 'Label' text: [ :each | each key ];
		column: 'Positions'
			text: [ :association | 
				', '
					join: (association value
							collect: [ :innerAssociation | innerAssociation key evolution printShowingDecimalPlaces: 2 ]) ];
		column: 'Profile'
			stencil: [ :association | 
				BrVerticalPane new
					vFitContent;
					hMatchParent;
					padding: (BlInsets
							top: 1
							left: 8
							bottom: 1
							right: 8);
					geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
					border: Color veryVeryLightGray;
					addChild: (GtPlotterMarkersElement new
							scaleX: (GtPlotterLinearScale new domainFrom: 0 to: 1);
							y: [ :each | 0.5 ];
							x: [:assoc | assoc key evolution];
							clipChildren: false;
							constraintsDo: [ :c | c vertical fitContent ];
							markerStyle: [ :anElement :aScaleContext | 
								anElement
									size: 16 @ 16;
									border: (Color white alpha: 0.2);
									background: (Color black alpha: 0.4);
									aptitude: (BrStyleCommonAptitude new
										default: [ :s | s background: (Color black alpha: 0.5) ];
										hovered: [ :s | s background: BrGlamorousColors primaryBorderColor ];
										pressed: [ :s | s background: BrGlamorousColors pressedButtonBorderColor ]);
								when: BlClickEvent
									do: [ :e | 
										e target phlow spawnObject: aScaleContext originalValue value.
										e consumed: true ] ];
							values: (association value
						collect: [ :innerAssociation | innerAssociation]) ) ];
		send: #value
]
