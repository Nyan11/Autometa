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

	self
		slotDescriptionNamed: aString
		ifFound: [ :dragonDescription | ^ dragonDescription ]
		ifNotFound: [
			DragonErrorNoSlotNamed new
				objectClass: self objectClass;
				slotName: aString;
				signal ].
]

{ #category : 'as yet unclassified' }
DragonDescription >> slotDescriptionNamed: aString ifFound: aBlockClosureFound [

	self slotDescriptionNamed: aString ifFound: aBlockClosureFound ifNotFound: [  ]
]

{ #category : 'as yet unclassified' }
DragonDescription >> slotDescriptionNamed: aString ifFound: aBlockClosureFound ifNotFound: aBlockClosureNotFound [

	| possibleSolutions |
	possibleSolutions := self slotDescriptions select: [ :desc |
		                     desc slot = aString ].
	possibleSolutions ifEmpty: [ ^ aBlockClosureNotFound value ].
	possibleSolutions size > 1 ifTrue: [
		^ DragonErrorMultipeSlotNamed new
			objectClass: self objectClass;
			slotName: aString;
			signal ].
	^ aBlockClosureFound value: possibleSolutions first
]

{ #category : 'accessing' }
DragonDescription >> slotDescriptions [

	^ slotDescriptions
]

{ #category : 'accessing' }
DragonDescription >> slotDescriptions: anObject [

	slotDescriptions := anObject
]
