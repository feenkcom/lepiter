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
				sorted: [ :a :b | a key < b key ] ];
		column: 'Label' text: [ :each | each key ];
		column: 'Positions'
			text: [ :association | 
				', '
					join: (association value
							collect: [ :innerAssociation | innerAssociation key evolution printShowingDecimalPlaces: 2 ]) ];
		column: 'Profile'
			stencil: [ :association | 
				elements := association value
						collect: [ :innerAssociation | 
							BlElement new
								size: 10 @ 10;
								aptitude: (BrStyleCommonAptitude new
										default: [ :s | 
											s background: (Color black alpha: 0.2) ];
										hovered: [ :s | 
											s background: BrGlamorousColors primaryBorderColor. ];
										pressed: [ :s | 
											s background: BrGlamorousColors pressedButtonBorderColor ]);
								when: BlClickEvent
									do: [ :e | 
										e target phlow spawnObject: innerAssociation value.
										e consumed: true ];
								geometry: BlCircleGeometry new;
								background: (Color black alpha: 0.2);
								relocate: (innerAssociation key evolution * 100 + 5) @ 5 ].
				BlElement new
					size: 110 @ 20;
					geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
					border: Color veryVeryLightGray;
					addChildren: elements ]
			width: 120
]
