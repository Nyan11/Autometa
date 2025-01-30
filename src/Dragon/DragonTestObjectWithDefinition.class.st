Class {
	#name : 'DragonTestObjectWithDefinition',
	#superclass : 'Object',
	#instVars : [
		'slot'
	],
	#category : 'Dragon',
	#package : 'Dragon'
}

{ #category : 'as yet unclassified' }
DragonTestObjectWithDefinition >> dragonSlot [

	<dragonDescription>
	^ DragonSlotDescription new
		  slot: #slot;
		  knownTypeValues: { String };
		  possibleGetterSelectors: { #hello };
		  possibleSetterSelectors: { #hello: };
		  yourself
]

{ #category : 'accessing' }
DragonTestObjectWithDefinition >> slot [

	^ slot
]

{ #category : 'accessing' }
DragonTestObjectWithDefinition >> slot: anObject [

	slot := anObject
]
