"
! How to create a custom snippet
!! Snippet Element
!!! Snippet Element instantiation
All snippet elements should be instantiatable by sending ${method:Behavior>>#new|label=new}$ to the class of the snippet element. Once a snippet element is instantiated it should be provided with a valid instance of ${class:LeContentViewModel}$ via ${method:LeContentElement>>#contentUIModel:}$.
It is important to not provide accessor methods to set ${method:LeContentElement>>#content|label=content}$ directly without involving a ${class:LeContentViewModel}$.
!!! Reacting to changes in a View Model
When a new UI Model (${class:LeContentViewModel}$) is set, a snippet element receives ${method:LeContentElement>>#onContentUIModelChanged}$ which should usually be overriden by a custom snippet element. All changes to the UI-related state should be instantly propagated to the current ${method:LeContentElement>>#contentUIModel}$.
!!! Handling focus
${class:LeSnippetElement}$ and its corresponding ${class:LeSnippetViewModel}$ already provide focus support. By default, ${class:LeSnippetElement}$ subscribes to focus in/out events (${method:LeSnippetElement>>#registerFocusEventHandlers}$) and updates the state in the ${class:LeSnippetViewModel}$. This also works the other way around, whenever the focus state changes in ${class:LeSnippetViewModel}$ it should also be updated in the ${class:LeSnippetElement}$. To properly handle focus, custom snippet elements are required to override ${method:LeSnippetElement>>#onContentUIModelFocused:}$ and give focus to itself or to one of the children, depending on the element composition and concrete snippet implementation. The synchronise the focus state a UI model announces ${class:LeSnippetFocusChanged}$ which is handled and processed by ${method:LeSnippetElement>>#onFocusChangedAnnouncement:}$. To break potential circular updates all ${class:LeSnippetFocusChanged}$ announcements know the ${method:LeSnippetFocusChanged>>#source|label=source}$ object which triggered the focus state update.
!!! Listening to updates from a snippet (content)
To subscribe to the announcements from the snippet override both ${method:LeContentElement>>#subscribeToContent}$ and ${method:LeContentElement>>#unsubscribeFromContent}$
"
Class {
	#name : #LeCustomSnippetHowToGuide,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Docs'
}

{ #category : #examples }
LeCustomSnippetHowToGuide >> snippetsStructure [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :eachHierarchy |
			BrVerticalPane new
				alignTopCenter;
				fitContent;
				cellSpacing: 10;
				border: (BlBorder paint: Color gray width: 1);
				padding: (BlInsets left: 20 right: 20);
				addChildren: {
					BrLabel new
						aptitude: BrGlamorousLabelAptitude new;
						text: eachHierarchy value.

					BlElement new
						in: [ :e | e graph beChildrenContainer: #default ];
						constraintsDo: [ :c |
							c horizontal fitContent.
							c vertical fitContent ]
				}
		];
		with: { 
			LeSnippet -> 'Domain Models'.
			LeAbstractSnippetViewModel -> 'View Models'.
			LeSnippetElement -> 'Views'.
		};
		forEach: [ :eachHierarchy |
			view nodes
				shape: [ :eachClass |
					| aShortClassName |

					aShortClassName := eachClass name gtRemovePrefix: 'Le'.
					(eachClass = LeAbstractSnippetViewModel or: [ eachClass = LeSnippetElement or: [ aShortClassName = 'Snippet' ] ])
						ifFalse: [ aShortClassName := aShortClassName copyReplaceAll: 'Snippet' with: '' ].
					
					aShortClassName := aShortClassName asRopedText.
					
					eachClass isAbstract
						ifTrue: [ aShortClassName := aShortClassName asRopedText italic ].
						
					eachClass isDeprecated
						ifTrue: [ aShortClassName := aShortClassName asRopedText decorationDo: [ :d | d lineThrough ] ].
					
					((eachClass inheritsFrom: LeSnippetElement) and: [ aShortClassName asString endsWith: 'Element' ])
						ifTrue: [
							(aShortClassName from: aShortClassName size + 1 - 'Element' size to: aShortClassName size)
								foreground: Color gray ].
							
					((eachClass inheritsFrom: LeAbstractSnippetViewModel) and: [ aShortClassName asString endsWith: 'ViewModel' ])
						ifTrue: [
							(aShortClassName from: aShortClassName size + 1 - 'ViewModel' size to: aShortClassName size)
								foreground: Color gray ].
					
					BrLabel new
						beSmallSize;
						aptitude: BrGlamorousLabelAptitude new;
						text: aShortClassName.
				];
				with: (eachHierarchy key withAllSubclasses sorted: [ :a :b | a name < b name ]).
			
			view edges
				fromRightCenter;
				toLeftCenter;
				connectFrom: #superclass.
			
			view layout horizontalTree nodeDistance: 10
	].

	view edges 
			shape: [ :x |
				BlLineElement new
					border: (BlBorder paint: (Color blue alpha: 0.3) width: 2) ];
			passive;
			fromRightCenter;
			toLeftCenter;
			connect: (LeSnippet withAllSubclasses
				select: [ :each | each includesSelector: #asSnippetViewModel ]
				thenCollect: [ :each | each -> (each >> #asSnippetViewModel) referencedClasses ] ) from: #key toAll: #value.

	view edges 
			shape: [ :x |
				BlLineElement new
					border: (BlBorder paint: (Color green muchDarker alpha: 0.3) width: 2) ];
			passive;
			fromRightCenter;
			toLeftCenter;
			connect: (LeAbstractSnippetViewModel withAllSubclasses
				select: [ :each | each includesSelector: #snippetElementClass ]
				thenCollect: [ :each | each -> (each >> #snippetElementClass) referencedClasses ] ) from: #key toAll: #value.

	view layout horizontal cellSpacing: 50.
	^ view
]
