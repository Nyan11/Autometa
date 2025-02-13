Class {
	#name : 'AutometaDescription',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'slotDescriptions'
	],
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'visiting' }
AutometaDescription >> acceptAutometaVisitor: aAutometaVisitor [

	aAutometaVisitor visitDescription: self
]

{ #category : 'testing' }
AutometaDescription >> isFinalType [

	^ self objectClass isAutometaFinal
]

{ #category : 'accessing' }
AutometaDescription >> objectClass [

	^ objectClass
]

{ #category : 'accessing' }
AutometaDescription >> objectClass: anObject [

	objectClass := anObject
]

{ #category : 'as yet unclassified' }
AutometaDescription >> slotDescriptionNamed: aString [

	self
		slotDescriptionNamed: aString
		ifFound: [ :dragonDescription | ^ dragonDescription ]
		ifNotFound: [
			AutometaErrorNoSlotNamed new
				objectClass: self objectClass;
				slotName: aString;
				signal ].
]

{ #category : 'as yet unclassified' }
AutometaDescription >> slotDescriptionNamed: aString ifFound: aBlockClosureFound [

	self slotDescriptionNamed: aString ifFound: aBlockClosureFound ifNotFound: [  ]
]

{ #category : 'as yet unclassified' }
AutometaDescription >> slotDescriptionNamed: aString ifFound: aBlockClosureFound ifNotFound: aBlockClosureNotFound [

	| possibleSolutions |
	possibleSolutions := self slotDescriptions select: [ :desc |
		                     desc name = aString ].
	possibleSolutions ifEmpty: [ ^ aBlockClosureNotFound value ].
	possibleSolutions size > 1 ifTrue: [
		^ AutometaErrorMultipeSlotNamed new
			  objectClass: self objectClass;
			  slotName: aString;
			  signal ].
	^ aBlockClosureFound value: possibleSolutions first
]

{ #category : 'accessing' }
AutometaDescription >> slotDescriptions [

	^ slotDescriptions
]

{ #category : 'accessing' }
AutometaDescription >> slotDescriptions: anObject [

	slotDescriptions := anObject
]
