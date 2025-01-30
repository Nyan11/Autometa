Class {
	#name : 'DragonTestObject',
	#superclass : 'Object',
	#instVars : [
		'name',
		'otherSlot'
	],
	#category : 'Dragon-Tests',
	#package : 'Dragon',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
DragonTestObject >> dragonName [

	<dragonDescription>
	^ DragonSlotDescription new slot: #name; knownTypeValues: { String }; yourself
]

{ #category : 'as yet unclassified' }
DragonTestObject >> dragonOtherSlot [

	<dragonDescription>
	^ DragonSlotDescription new
		  slot: #otherSlot;
		  knownTypeValues: { UndefinedObject };
		  yourself
]

{ #category : 'as yet unclassified' }
DragonTestObject >> dragonOtherSlot2 [

	<dragonDescription>
	^ DragonSlotDescription new
		  slot: #otherSlot;
		  knownTypeValues: { UndefinedObject };
		  yourself
]
