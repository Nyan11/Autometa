Class {
	#name : 'AutometaSlotDescriptionTest',
	#superclass : 'TestCase',
	#category : 'Autometa-Tests',
	#package : 'Autometa',
	#tag : 'Tests'
}

{ #category : 'running' }
AutometaSlotDescriptionTest >> tearDown [

	super tearDown.
	AutometaTestObjectNoDefinition autometaRemoveDescription.
	AutometaTestObjectNoDefinitionSubclass autometaRemoveDescription.
	AutometaTestObjectNoDefinitionSubclassSublClass
		autometaRemoveDescription.
	AutometaTestObjectWithDefinitionButNoSlot removeSelector: #autometaTest.
	AutometaTestObjectWithDefinition compile: 'autometaSlot

	<autometaDescription>
	^ AutometaPropertyDescription new
		  name: #slot;
		  knownTypeValues: { String };
		  possibleGetterSelectors: { #hello };
		  possibleSetterSelectors: { #hello: };
		  yourself'.
	Smalltalk garbageCollect
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testCombineWithSlotDescription1 [

	| desc1 desc2 |
	desc1 := AutometaPropertyDescription new
		         name: #hello;
		         yourself.
	desc2 := AutometaPropertyDescription new
		         name: #hello;
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self assert: true
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testCombineWithSlotDescription2 [

	| desc1 desc2 |
	desc1 := AutometaPropertyDescription new
		         name: #hello;
		         yourself.
	desc2 := AutometaPropertyDescription new
		         name: #goodbye;
		         yourself.
	self
		should: [ desc1 combineWithSlotDescription: desc2 ]
		raise: AutometaErrorCombineDifferentSlotDescription
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testCombineWithSlotDescription3 [

	| desc1 desc2 |
	desc1 := AutometaPropertyDescription new
		         name: #hello;
		         possibleSetterSelectors: { #setter1. #setter2 } yourself.
	desc2 := AutometaPropertyDescription new
		         name: #hello;
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self
		assertCollection: desc1 possibleSetterSelectors
		includesAll: { #setter1. #setter2 }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testCombineWithSlotDescription4 [

	| desc1 desc2 |
	desc1 := AutometaPropertyDescription new
		         name: #hello;
		         yourself.
	desc2 := AutometaPropertyDescription new
		         name: #hello;
		         possibleSetterSelectors: { #setter1. #setter2 };
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self
		assertCollection: desc1 possibleSetterSelectors
		includesAll: { #setter1. #setter2 }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testCombineWithSlotDescription5 [

	| desc1 desc2 |
	desc1 := AutometaPropertyDescription new
		         name: #hello;
		         possibleSetterSelectors: { #setter1 };
		         yourself.
	desc2 := AutometaPropertyDescription new
		         name: #hello;
		         possibleSetterSelectors: { #setter2 };
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self
		assertCollection: desc1 possibleSetterSelectors
		includesAll: { #setter1. #setter2 }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testCombineWithSlotDescription6 [

	| desc1 desc2 |
	desc1 := AutometaPropertyDescription new
		         name: #hello;
		         possibleSetterSelectors: { #setter1. #setter2 };
		         yourself.
	desc2 := AutometaPropertyDescription new
		         name: #hello;
		         possibleSetterSelectors: { #setter2. #setter3 };
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self
		assertCollection: desc1 possibleSetterSelectors
		includesAll: { #setter1. #setter2. #setter3 }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testInstallDragonDescriptionOn1 [

	| object1 |
	object1 := AutometaTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	self assertEmpty: object1 autometaFullDescription slotDescriptions.
	object1 autometaGenerateDescription.
	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 1.
	self
		assert: (object1 autometaFullDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { String }.
	self
		assert: (object1 autometaFullDescription slotDescriptionNamed: #slot)
				possibleSetterSelectors
		equals: { #slot: }.
	self
		assert: (object1 autometaFullDescription slotDescriptionNamed: #slot)
				possibleGetterSelectors
		equals: { #slot }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testInstallDragonDescriptionOn2 [

	| object1 object2 |
	object1 := AutometaTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := AutometaTestObjectNoDefinition new
		           slot: 'Goodbye World !';
		           yourself.
	self assertEmpty: object1 autometaFullDescription slotDescriptions.
	object1 autometaGenerateDescription.
	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 1.
	self
		assert: (object1 autometaFullDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { String }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testInstallDragonDescriptionOn3 [

	| object1 object2 |
	object1 := AutometaTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := AutometaTestObjectNoDefinition new
		           slot: 5;
		           yourself.
	self assertEmpty: object1 autometaFullDescription slotDescriptions.
	object1 autometaGenerateDescription.
	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 1.
	self
		assertCollection:
			(object1 autometaFullDescription slotDescriptionNamed: #slot)
				knownTypeValues
		includesAll: {
				Integer.
				String }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testInstallDragonDescriptionOn4 [

	| object1 |
	object1 := AutometaTestObjectNoDefinitionSubclass new
		           slot: 'Hello World !';
		           subclassSlot: 4;
		           yourself.
	self assertEmpty: object1 autometaFullDescription slotDescriptions.
	object1 autometaGenerateDescription.
	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 2.
	self
		assert: (object1 autometaFullDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { String }.
	self
		assert: (object1 autometaFullDescription slotDescriptionNamed: #slot)
				possibleSetterSelectors
		equals: { #slot: }.
	self
		assert:
			(object1 autometaFullDescription slotDescriptionNamed: #subclassSlot)
				possibleSetterSelectors
		equals: { #subclassSlot: }.
	self
		assert:
			(object1 autometaFullDescription slotDescriptionNamed: #subclassSlot)
				knownTypeValues
		equals: { Integer }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testInstallDragonDescriptionOn5 [

	| object1 descriptionSlot |
	object1 := AutometaTestObjectWithDefinition new
		           slot: 5;
		           yourself.

	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 1.
	descriptionSlot := object1 autometaFullDescription
		                   slotDescriptionNamed: #slot.
	self assert: descriptionSlot knownTypeValues size equals: 1.
	self
		assertCollection: descriptionSlot knownTypeValues
		includesAll: { String }.
	self assert: descriptionSlot possibleGetterSelectors size equals: 1.
	self
		assertCollection: descriptionSlot possibleGetterSelectors
		includesAll: { #hello }.
	self assert: descriptionSlot possibleSetterSelectors size equals: 1.
	self
		assertCollection: descriptionSlot possibleSetterSelectors
		includesAll: { #hello: }.

	object1 autometaGenerateDescription.

	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 1.
	descriptionSlot := object1 autometaFullDescription
		                   slotDescriptionNamed: #slot.
	self assert: descriptionSlot knownTypeValues size equals: 2.
	self
		assertCollection: descriptionSlot knownTypeValues
		includesAll: {
				String.
				Integer }.
	self assert: descriptionSlot possibleGetterSelectors size equals: 2.
	self
		assertCollection: descriptionSlot possibleGetterSelectors
		includesAll: { #hello. #slot }.
	self assert: descriptionSlot possibleSetterSelectors size equals: 2.
	self
		assertCollection: descriptionSlot possibleSetterSelectors
		includesAll: { #hello:. #slot: }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testInstallDragonDescriptionOn6 [

	| object1 descriptionSlot |
	object1 := AutometaTestObjectWithDefinitionButNoSlot new.

	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 0.

	object1 autometaGenerateDescription.

	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 1.
	descriptionSlot := object1 autometaFullDescription slotDescriptionNamed:
		                   #test.
	self assert: descriptionSlot knownTypeValues size equals: 1.
	self
		assertCollection: descriptionSlot knownTypeValues
		includesAll: {
				Symbol }.
	self assert: descriptionSlot possibleGetterSelectors size equals: 1.
	self
		assertCollection: descriptionSlot possibleGetterSelectors
		includesAll: { #test }.
	self assert: descriptionSlot possibleSetterSelectors size equals: 1.
	self
		assertCollection: descriptionSlot possibleSetterSelectors
		includesAll: { #test: }
]

{ #category : 'tests' }
AutometaSlotDescriptionTest >> testInstallDragonDescriptionOn7 [

	| object1 object2 |
	object1 := AutometaTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := AutometaTestObjectNoDefinition new
		           slot: #test;
		           yourself.
	self assertEmpty: object1 autometaFullDescription slotDescriptions.
	object1 autometaGenerateDescription.
	self
		assert: object1 autometaFullDescription slotDescriptions size
		equals: 1.
	self
		assertCollection:
			(object1 autometaFullDescription slotDescriptionNamed: #slot)
				knownTypeValues
		includesAll: { String }
]
