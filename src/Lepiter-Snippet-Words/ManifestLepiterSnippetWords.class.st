"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser

"
Class {
	#name : #ManifestLepiterSnippetWords,
	#superclass : #PackageManifest,
	#category : 'Lepiter-Snippet-Words-Manifest'
}

{ #category : #'code-critics' }
ManifestLepiterSnippetWords class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#LeWordExplanationTextBuilder #buildMeanings #false)) #'2021-02-05T08:57:44.581995-03:00') )
]
