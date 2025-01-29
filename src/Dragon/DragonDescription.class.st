Class {
	#name : 'DragonDescription',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'slotDescriptions'
	],
	#category : 'Dragon',
	#package : 'Dragon'
}

{ #category : 'accessing' }
DragonDescription >> objectClass [

	^ objectClass
]

{ #category : 'accessing' }
DragonDescription >> objectClass: anObject [

	objectClass := anObject
]

{ #category : 'as yet unclassified' }
DragonDescription >> slotDescriptionNamed: aString [

	| possibleSolutions |
	possibleSolutions := self slotDescriptions select: [ :desc | desc slot = aString ].
	possibleSolutions ifEmpty: [ DragonErrorNoSlotNamed new objectClass: self objectClass; slotName: aString; signal ].
	possibleSolutions size > 1 ifTrue: [ DragonErrorMultipeSlotNamed new objectClass: self objectClass; slotName: aString; signal ].
	^ possibleSolutions first
]

{ #category : 'accessing' }
DragonDescription >> slotDescriptions [

	^ slotDescriptions
]

{ #category : 'accessing' }
DragonDescription >> slotDescriptions: anObject [

	slotDescriptions := anObject
]
