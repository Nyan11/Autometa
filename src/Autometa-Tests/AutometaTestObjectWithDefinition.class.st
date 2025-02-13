Class {
	#name : 'AutometaTestObjectWithDefinition',
	#superclass : 'Object',
	#instVars : [
		'slot'
	],
	#category : 'Autometa-Tests',
	#package : 'Autometa-Tests'
}

{ #category : 'dragon meta description' }
AutometaTestObjectWithDefinition >> autometaSlot [

	<autometaDescription>
	^ AutometaPropertyDescription new
		  name: #slot;
		  knownTypeValues: { String };
		  possibleGetterSelectors: { #hello };
		  possibleSetterSelectors: { #hello: };
		  yourself
]

{ #category : 'as yet unclassified' }
AutometaTestObjectWithDefinition >> slot [

	^ slot
]

{ #category : 'as yet unclassified' }
AutometaTestObjectWithDefinition >> slot: anObject [

	slot := anObject
]
