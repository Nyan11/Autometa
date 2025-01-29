Class {
	#name : 'DragonSlotDescription',
	#superclass : 'Object',
	#instVars : [
		'slot',
		'knownTypeValues'
	],
	#category : 'Dragon',
	#package : 'Dragon'
}

{ #category : 'as yet unclassified' }
DragonSlotDescription >> installDragonDescriptionOn: aClass [

	| methodString knownTypeValuesString |
	methodString := 'dragon<1s><r><r><t>%<dragonDescription><r><t>^ DragonSlotDescription new slot: #<2s>; knownTypeValues: { <3s> }; yourself'.
	knownTypeValuesString := ''.
	self knownTypeValues
		do: [ :class |
			knownTypeValuesString := knownTypeValuesString , class name ]
		separatedBy: [ knownTypeValuesString := knownTypeValuesString , '.' ].
	aClass compile: (methodString
			 expandMacrosWith: self slot capitalized
			 with: self slot
			 with: knownTypeValuesString)
]

{ #category : 'accessing' }
DragonSlotDescription >> knownTypeValues [

	^ knownTypeValues
]

{ #category : 'accessing' }
DragonSlotDescription >> knownTypeValues: anObject [

	knownTypeValues := anObject
]

{ #category : 'accessing' }
DragonSlotDescription >> slot [

	^ slot
]

{ #category : 'accessing' }
DragonSlotDescription >> slot: anObject [

	slot := anObject
]
