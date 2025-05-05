Extension { #name : #GtWardleyMapDecoratorWithScripterExamples }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithLepiterPageAction [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ GtWardleyMapDecoratorExamples new mapWithLepiterPageAction ]
			element: [ :aMap | 
				GtPager
					createWrappedOn: (GtWardleyMapElement new
							wardleyMapViewModel: (GtWardleyMapViewModel new wardleyMapModel: aMap)) ].

	aScripter
		substeps: 'Assert decorator buttons'
		do: [ :aStep | 
			aStep assert
				label: 'Assert Node A page decorator button';
				exists;
				// GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton wardleyMapNodeViewModel label = 'Node A' ];
				play.

			aStep assert
				label: 'Assert Node B page decorator button';
				exists;
				// GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton wardleyMapNodeViewModel label = 'Node B' ];
				play.

			aStep assert
				label: 'Assert Node C page decorator button';
				exists;
				// GtWardleyMapActionNodeButton;
				@ [ :aButton | aButton wardleyMapNodeViewModel label = 'Node C' ];
				play.

			aStep assert
				label: 'Assert map canvas page decorator button';
				exists;
				// GtWardleyMapCanvasElement;
				/ GtWardleyMapDecoratorContainerElement;
				/ GtWardleyMapActionButton;
				play ].

	^ aScripter
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
GtWardleyMapDecoratorWithScripterExamples >> mapWithLepiterPageAction_ClickOnMapCanvasDecorator [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mapWithLepiterPageAction.

	aScripter click
		label: 'Click on map canvas page decorator button';
		// GtWardleyMapCanvasElement;
		/ GtWardleyMapDecoratorContainerElement;
		/ GtWardleyMapActionButton;
		play.

	aScripter assert exists
		// (GtPagerPageElementId indexed: 2);
		play.

	^ aScripter
]
