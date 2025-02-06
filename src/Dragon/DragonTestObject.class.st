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
	^ DragonPropertyDescription new
		  name: #name;
		  knownTypeValues: { String };
		  yourself
]

{ #category : 'as yet unclassified' }
DragonTestObject >> dragonOtherSlot [

	<dragonDescription>
	^ DragonPropertyDescription new
		  name: #otherSlot;
		  knownTypeValues: { UndefinedObject };
		  yourself
]

{ #category : 'as yet unclassified' }
DragonTestObject >> dragonOtherSlot2 [

	<dragonDescription>
	^ DragonPropertyDescription new
		  name: #otherSlot;
		  knownTypeValues: { UndefinedObject };
		  yourself
]
