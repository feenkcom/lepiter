Class {
	#name : #LeWardleyMapSnippetGroup,
	#superclass : #LeSnippetGroup,
	#category : #'Lepiter-Snippets'
}

{ #category : #accessing }
LeWardleyMapSnippetGroup >> gtNodeProfilesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'All nodes';
		items: [ ((self items
				flatCollect: [ :aSnippet | 
					aSnippet wardleyMap nodes
						collect: [ :aNode | 
							LeWardleyMapNodeInSnippet new
								node: aNode;
								wardleyMapSnippet: aSnippet ] ]) groupedBy: [ :each | each node label ])
				associations sorted: [ :a :b | a key asLowercase < b key asLowercase ] ];
		column: 'Label' text: [ :each | each key ];
		column: 'Positions'
			text: [ :association | 
				', '
					join: (association value
							collect: [ :nodeInSnippet | nodeInSnippet node evolution printShowingDecimalPlaces: 2 ]) ];
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
							x: [ :nodeInSnippet | nodeInSnippet node evolution ];
							clipChildren: false;
							constraintsDo: [ :c | c vertical fitContent ];
							markerStyle: [ :anElement :aScaleContext | 
								anElement
									size: 16 @ 16;
									border: (Color white alpha: 0.5);
									background: (Color black alpha: 0.2);
									aptitude: (BrStyleCommonAptitude new
											default: [ :s | s background: (Color black alpha: 0.5) ];
											hovered: [ :s | s background: BrGlamorousColors primaryBorderColor ];
											pressed: [ :s | s background: BrGlamorousColors pressedButtonBorderColor ]);
									when: BlClickEvent
										do: [ :e | 
											e target phlow spawnObject: aScaleContext originalValue.
											e consumed: true ] ];
							values: (association value)) ];
		send: #value
]

{ #category : #accessing }
LeWardleyMapSnippetGroup >> gtNodeProfilesWithMultipleOccurrencesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Node profiles';
		items: [ ((((self items
				flatCollect: [ :aSnippet | 
					aSnippet wardleyMap nodes
						collect: [ :aNode | 
							LeWardleyMapNodeInSnippet new
								node: aNode;
								wardleyMapSnippet: aSnippet ] ]) groupedBy: [ :each | each node label ])
				associations) select: [:each | each value size > 1]) sorted: [ :a :b | a key asLowercase < b key asLowercase ] ];
		column: 'Label' text: [ :each | each key ];
		column: 'Positions'
			text: [ :association | 
				', '
					join: (association value
							collect: [ :nodeInSnippet | nodeInSnippet node evolution printShowingDecimalPlaces: 2 ]) ];
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
							x: [ :nodeInSnippet | nodeInSnippet node evolution ];
							clipChildren: false;
							constraintsDo: [ :c | c vertical fitContent ];
							markerStyle: [ :anElement :aScaleContext | 
								anElement
									size: 16 @ 16;
									border: (Color white alpha: 0.5);
									background: (Color black alpha: 0.2);
									aptitude: (BrStyleCommonAptitude new
											default: [ :s | s background: (Color black alpha: 0.5) ];
											hovered: [ :s | s background: BrGlamorousColors primaryBorderColor ];
											pressed: [ :s | s background: BrGlamorousColors pressedButtonBorderColor ]);
									when: BlClickEvent
										do: [ :e | 
											e target phlow spawnObject: aScaleContext originalValue.
											e consumed: true ] ];
							values: (association value)) ]
]
