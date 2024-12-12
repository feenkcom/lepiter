Class {
	#name : #LepiterConstants,
	#superclass : #Object,
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'pillar parameter names' }
LepiterConstants class >> alignmentParameterName [
	^ #alignment
]

{ #category : #ui }
LepiterConstants class >> applyButtonIcon [
	^ BrGlamorousVectorIcons accept
]

{ #category : #ui }
LepiterConstants class >> applyButtonLabel [
	^ 'Apply'
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> changesAnnotationName [
	^ #changes
]

{ #category : #files }
LepiterConstants class >> changesFileExtension [
	^ '.ombu'
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> classAnnotationName [
	^ #class
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> classesParameterName [
	^ #classes
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> codeExpandedParameterName [
	^ #codeExpanded
]

{ #category : #ui }
LepiterConstants class >> confluenceButtonIcon [
	^ BrGlamorousIcons cloud
]

{ #category : #ui }
LepiterConstants class >> createButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : #ui }
LepiterConstants class >> createButtonLabel [
	^ 'Create'
]

{ #category : #text }
LepiterConstants class >> cursorNearbyDistance [
	^ 0
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultChangesShowSelector [
	^ #gtPreviewFor:
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultClassShowSelector [
	^ #gtMetaFor:
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultExamplesShowSelector [
	^ #gtExpandableExamplesFor: "#gtExamplesFor:"
]

{ #category : #'file export' }
LepiterConstants class >> defaultExportFigureWidth [
	"Exported figure width without considering the scale factor at ${method:GtDocumentConstants class>>#exportFigureScaleFactor}$"

	^ 1200
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultFigureShowSelector [
	^ #gtFigureFor:
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultInlineValue [
	^ #yourself
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultMethodShowSelector [
	^ #gtBasicSourceFor:
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultPackageShowSelector [
	^ #gtPackageCoderFor:
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultPreviewExpanded [
	^ false
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultPreviewHeight [
	^ 300
]

{ #category : #'pillar parameter default values' }
LepiterConstants class >> defaultShowSelector [
	^ #gtViewsFor:
]

{ #category : #ui }
LepiterConstants class >> documentUserDataKey [
	^ #gtDocument
]

{ #category : #ui }
LepiterConstants class >> editButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : #ui }
LepiterConstants class >> editButtonLabel [
	^ 'Edit'
]

{ #category : #ui }
LepiterConstants class >> editingModeIcon [
	^ BrGlamorousIcons edit 
]

{ #category : #colors }
LepiterConstants class >> errorColor [
	^ BrGlamorousColors errorBorderColor
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> exampleAnnotationName [
	^ #example
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> examplesAnnotationName [
	^ #examples
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> expandedParameterName [
	^ #expanded
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> explanationAnnotationName [
	^ #explanation
]

{ #category : #'file export' }
LepiterConstants class >> exportFigureScaleFactor [
	"Scale factor that is used then exporting to PNG (non-vector) format"
	^ 2
]

{ #category : #files }
LepiterConstants class >> exportedResultsDirectoryName [
	<return: #String>
	^ 'gt-figures'
]

{ #category : #files }
LepiterConstants class >> exportedResultsDirectoryPath [
	<return: #RelativePath>
	^ Path * self exportedResultsDirectoryName
]

{ #category : #files }
LepiterConstants class >> exportedResultsExtension [
	<return: #String>
	^ 'png'
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> fullViewParameterName [
	^ #full
]

{ #category : #margins }
LepiterConstants class >> headerBottomMargin [
	^ self paragraphBottomMargin
]

{ #category : #text }
LepiterConstants class >> headerFontSizeMultiplier [
	^ 1.5
]

{ #category : #text }
LepiterConstants class >> headerLevelStep [
	^ 2
]

{ #category : #margins }
LepiterConstants class >> headerMarginForLevel: aLevelNumber [
	^ BlInsets 
		top: ((6 - (aLevelNumber)) min: 1) * self headerTopMargin 
		left: 0 
		bottom: self headerBottomMargin 
		right: 0
]

{ #category : #margins }
LepiterConstants class >> headerTopMargin [
	^ self paragraphTopMargin * 5
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> heightParameterName [
	^ #height
]

{ #category : #ui }
LepiterConstants class >> horizontalLineHeight [
	^ 1
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> icebergFileAnnotationName [
	^ #icebergFile
]

{ #category : #files }
LepiterConstants class >> icebergRepositoriesLocation [
	<return: #FileReference>
	^ GtResourcesUtility default repositoriesLocation
]

{ #category : #ui }
LepiterConstants class >> infoButtonIcon [
	^ BrGlamorousVectorIcons inspect
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> inlineParameterName [
	self 
		deprecated: 'Please use #labelParameterName instead.'
		transformWith: '`@receiver inlineParameterName' -> '`@receiver labelParameterName'.
	^ self labelParameterName
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> inputFileAnnotationName [
	^ PRInputFileAnnotation tag
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> inputVariablesParameterName [
	^ #variables
]

{ #category : #'changes diff' }
LepiterConstants class >> insertLineIdentificator [
	^ '+ '
]

{ #category : #ui }
LepiterConstants class >> issuesButtonLabel [
	^ 'Issues'
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> labelParameterName [
	^ #label
]

{ #category : #colors }
LepiterConstants class >> linkColor [
	^ BrGlamorousColors linkColor
]

{ #category : #colors }
LepiterConstants class >> linkWithErrorColor [
	^ BrGlamorousColors linkWithErrorColor
]

{ #category : #files }
LepiterConstants class >> localGtDirectory [
	<return: #FileReference>
	^ GtResourcesUtilityConstants localGtDirectory
]

{ #category : #'changes diff' }
LepiterConstants class >> matchLineColor [
	^ Color black
]

{ #category : #'changes diff' }
LepiterConstants class >> matchLineIdentificator [
	^ '  '
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> methodAnnotationName [
	^ #method
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> methodsParameterName [
	^ #methods
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> nameParameterName [
	^ #name
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> noCodeParameterName [
	^ #noCode
]

{ #category : #colors }
LepiterConstants class >> notAvailableColor [
	^ BrGlamorousColors lightBorderColor
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> packagesParameterName [
	^ #packages
]

{ #category : #margins }
LepiterConstants class >> paragraphBottomMargin [
	^ 5
]

{ #category : #margins }
LepiterConstants class >> paragraphMargin [
	^ BlInsets 
		top: self paragraphTopMargin
		left: 0 
		bottom: self paragraphBottomMargin 
		right: 0
]

{ #category : #margins }
LepiterConstants class >> paragraphTopMargin [
	^ 5
]

{ #category : #'pillar annotation names' }
LepiterConstants class >> parametrizedExampleAnnotationName [
	^ #paramExample
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> pathParameterName [
	^ #path
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> previewHeightParameterName [
	^ #previewHeight
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> previewShowParameterName [
	^ #previewShow
]

{ #category : #ui }
LepiterConstants class >> readingModeIcon [
	^ BrGlamorousIcons edit
]

{ #category : #'changes diff' }
LepiterConstants class >> removeLineIdentificator [
	^ '- '
]

{ #category : #ui }
LepiterConstants class >> resultsLabel [
	^ 'Results'
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> returnVariableParameterName [
	^ #return
]

{ #category : #ui }
LepiterConstants class >> runButtonIcon [
	^ BrGlamorousVectorIcons play
]

{ #category : #ui }
LepiterConstants class >> runButtonLabel [
	"Default label used for example for button labels, [[[label=Run]]]"
	^ 'Run'
]

{ #category : #ui }
LepiterConstants class >> saveButtonIcon [
	^ self applyButtonIcon
]

{ #category : #ui }
LepiterConstants class >> saveButtonLabel [
	^ 'Save'
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> showParameterName [
	^ #show
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> slidesAnnotationName [
	^ #slides
]

{ #category : #'pillar parameter names' }
LepiterConstants class >> slidesParameterName [
	^ #list
]

{ #category : #colors }
LepiterConstants class >> subtleColor [
	^ Color gray
]

{ #category : #ui }
LepiterConstants class >> successButtonLabel [
	^ 'Success'
]

{ #category : #colors }
LepiterConstants class >> successColor [
	^ BrGlamorousColors successBorderColor
]

{ #category : #text }
LepiterConstants class >> superscriptFontSize [
	^ 9
]

{ #category : #'variable bindings' }
LepiterConstants class >> thisDocument [
	^ #'thisDocument'
]
