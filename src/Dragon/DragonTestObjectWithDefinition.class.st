Class {
	#name : 'DragonTestObjectWithDefinition',
	#superclass : 'Object',
	#instVars : [
		'slot'
	],
	#category : 'Dragon-Tests',
	#package : 'Dragon',
	#tag : 'Tests'
}

{ #category : 'dragon meta description' }
DragonTestObjectWithDefinition >> dragonSlot [

	<dragonDescription>
	^ DragonSlotDescription new
		  slot: #slot;
		  knownTypeValues: { String };
		  possibleGetterSelectors: { #hello };
		  possibleSetterSelectors: { #hello: };
		  yourself
]

{ #category : 'as yet unclassified' }
DragonTestObjectWithDefinition >> slot [

	^ slot
]

{ #category : 'as yet unclassified' }
DragonTestObjectWithDefinition >> slot: anObject [

	slot := anObject
]
