Class {
	#name : 'DragonSlotDescription',
	#superclass : 'Object',
	#instVars : [
		'slot',
		'knownTypeValues',
		'possibleSetterSelectors',
		'possibleGetterSelectors'
	],
	#category : 'Dragon',
	#package : 'Dragon'
}

{ #category : 'as yet unclassified' }
DragonSlotDescription >> combineWithSlotDescription: aDragonSlotDescription [

	self slot = aDragonSlotDescription slot ifFalse: [ ^ DragonErrorCombineDifferentSlotDescription new signal ].
	self knownTypeValues: (self knownTypeValues , aDragonSlotDescription knownTypeValues) asSet asArray.
	self possibleGetterSelectors: (self possibleGetterSelectors , aDragonSlotDescription possibleGetterSelectors) asSet asArray.
	self possibleSetterSelectors: (self possibleSetterSelectors , aDragonSlotDescription possibleSetterSelectors) asSet asArray
]

{ #category : 'initialization' }
DragonSlotDescription >> initialize [

	super initialize.
	knownTypeValues := {  }.
	possibleGetterSelectors := {  }.
	possibleSetterSelectors := {  }.
]

{ #category : 'as yet unclassified' }
DragonSlotDescription >> installDragonDescriptionOn: aClass [

	| methodSelector methodString knownTypeValuesString possibleGetterSelectorsString possibleSetterSelectorsString |
	aClass dragonInstanceDescription
		slotDescriptionNamed: self slot
		ifFound: [ :description |
		self combineWithSlotDescription: description ].

	methodString := 'dragon<1s><r><r><t>%<dragonDescription><r><t>^ DragonSlotDescription new slot: #<2s>; knownTypeValues: { <3s> }; possibleGetterSelectors: { <4s> }; possibleSetterSelectors: { <5s> }; yourself'.

	knownTypeValuesString := ''.
	self knownTypeValues
		do: [ :class |
			knownTypeValuesString := knownTypeValuesString , class name ]
		separatedBy: [
		knownTypeValuesString := knownTypeValuesString , ' . ' ].

	possibleGetterSelectorsString := ''.
	self possibleGetterSelectors
		do: [ :getter |
			possibleGetterSelectorsString := possibleGetterSelectorsString
			                                 , '#' , getter ]
		separatedBy: [
			possibleGetterSelectorsString := possibleGetterSelectorsString
			                                 , ' . ' ].

	possibleSetterSelectorsString := ''.
	self possibleSetterSelectors
		do: [ :setter |
			possibleSetterSelectorsString := possibleSetterSelectorsString
			                                 , '#' , setter ]
		separatedBy: [
			possibleSetterSelectorsString := possibleSetterSelectorsString
			                                 , ' . ' ].


	methodSelector := aClass compile:
		                  (methodString expandMacrosWithArguments: {
				                   self slot capitalized.
				                   self slot.
				                   knownTypeValuesString.
				                   possibleGetterSelectorsString.
				                   possibleSetterSelectorsString }).
	(aClass methodNamed: methodSelector) protocol: '*Dragon'
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
DragonSlotDescription >> possibleGetterSelectors [

	^ possibleGetterSelectors
]

{ #category : 'as yet unclassified' }
DragonSlotDescription >> possibleGetterSelectors: aCollection [

	possibleGetterSelectors := aCollection
]

{ #category : 'accessing' }
DragonSlotDescription >> possibleSetterSelectors [
	^ possibleSetterSelectors
]

{ #category : 'as yet unclassified' }
DragonSlotDescription >> possibleSetterSelectors: aCollection [ 
	possibleSetterSelectors := aCollection
]

{ #category : 'accessing' }
DragonSlotDescription >> slot [

	^ slot
]

{ #category : 'accessing' }
DragonSlotDescription >> slot: anObject [

	slot := anObject
]
