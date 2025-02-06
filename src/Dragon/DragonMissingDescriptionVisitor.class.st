Class {
	#name : 'DragonMissingDescriptionVisitor',
	#superclass : 'DragonVisitor',
	#instVars : [
		'knownClasses',
		'missingDescription',
		'emptyProperties'
	],
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'accessing' }
DragonMissingDescriptionVisitor >> emptyProperties [

	^ emptyProperties
]

{ #category : 'visiting' }
DragonMissingDescriptionVisitor >> initialize [

	super initialize.
	knownClasses := Set new.
	missingDescription := Set new.
	emptyProperties := OrderedCollection new.
]

{ #category : 'visiting' }
DragonMissingDescriptionVisitor >> knownClasses [

	^ knownClasses
]

{ #category : 'accessing' }
DragonMissingDescriptionVisitor >> missingDescription [

	^ missingDescription
]

{ #category : 'visiting' }
DragonMissingDescriptionVisitor >> visitDescription: aDragonDescription [

	(self knownClasses includes: aDragonDescription objectClass) ifTrue: [
		^ self ].
	self knownClasses add: aDragonDescription objectClass.

	aDragonDescription slotDescriptions ifEmpty: [
		aDragonDescription isFinalType ifFalse: [
			self missingDescription add: aDragonDescription ].
		^ self ].
	aDragonDescription slotDescriptions do: [ :each |
		each acceptDragonVisitor: self ]
]

{ #category : 'visiting' }
DragonMissingDescriptionVisitor >> visitPropertyDescription: aDragonPropertyDescription [

	| allTypeDescriptions |
	aDragonPropertyDescription knownTypeValues ifEmpty: [ self emptyProperties add: aDragonPropertyDescription. ^ self ].
	(aDragonPropertyDescription knownTypeValues size = 1 and: [ aDragonPropertyDescription knownTypeValues anyOne = UndefinedObject ]) ifTrue: [ self emptyProperties add: aDragonPropertyDescription. ^ self ].
	
	allTypeDescriptions := aDragonPropertyDescription knownTypeValues collect: [ :each | each dragonFullDescription ].
	allTypeDescriptions do: [ :each | each acceptDragonVisitor: self ].
]
