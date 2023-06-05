Class {
	#name : #LeExportSlides,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #accessing }
LeExportSlides >> graphicalStackFirstExampleSlideFor: aSlide [
	<gtSlide>
	^ GtTour new graphicalStackFirstExampleSlideFor: aSlide
]

{ #category : #accessing }
LeExportSlides >> multipleViewsForOneObjectExampleSlideFor: aSlide [
	<gtSlide>
	^ GtTour new multipleViewsForOneObjectExampleSlideFor: aSlide
]
