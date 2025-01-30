Class {
	#name : 'DragonSlotDescriptionTest',
	#superclass : 'TestCase',
	#category : 'Dragon-Tests',
	#package : 'Dragon',
	#tag : 'Tests'
}

{ #category : 'running' }
DragonSlotDescriptionTest >> tearDown [

	super tearDown.
	DragonTestObjectNoDefinition removeDragonDescription.
	DragonTestObjectNoDefinitionSubclass removeDragonDescription.
	DragonTestObjectNoDefinitionSubclassSublClass removeDragonDescription.
	DragonTestObjectWithDefinitionButNoSlot removeSelector: #dragonTest.
	DragonTestObjectWithDefinition compile: 'dragonSlot

	<dragonDescription>
	^ DragonSlotDescription new
		  slot: #slot;
		  knownTypeValues: { String };
		  possibleGetterSelectors: { #hello };
		  possibleSetterSelectors: { #hello: };
		  yourself'
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testCombineWithSlotDescription1 [

	| desc1 desc2 |
	desc1 := DragonSlotDescription new
		         slot: #hello;
		         yourself.
	desc2 := DragonSlotDescription new
		         slot: #hello;
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self assert: true
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testCombineWithSlotDescription2 [

	| desc1 desc2 |
	desc1 := DragonSlotDescription new
		         slot: #hello;
		         yourself.
	desc2 := DragonSlotDescription new
		         slot: #goodbye;
		         yourself.
	self
		should: [ desc1 combineWithSlotDescription: desc2 ]
		raise: DragonErrorCombineDifferentSlotDescription.
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testCombineWithSlotDescription3 [

	| desc1 desc2 |
	desc1 := DragonSlotDescription new
		         slot: #hello;
		         possibleSetterSelectors: { #setter1 . #setter2 }
		         yourself.
	desc2 := DragonSlotDescription new
		         slot: #hello;
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self assertCollection: desc1 possibleSetterSelectors includesAll: { #setter1 . #setter2 }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testCombineWithSlotDescription4 [

	| desc1 desc2 |
	desc1 := DragonSlotDescription new
		         slot: #hello;
		         yourself.
	desc2 := DragonSlotDescription new
		         slot: #hello;
		         possibleSetterSelectors: { #setter1 . #setter2 };
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self assertCollection: desc1 possibleSetterSelectors includesAll: { #setter1 . #setter2 }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testCombineWithSlotDescription5 [

	| desc1 desc2 |
	desc1 := DragonSlotDescription new
		         slot: #hello;
		 possibleSetterSelectors: { #setter1 };
		         yourself.
	desc2 := DragonSlotDescription new
		         slot: #hello;
		         possibleSetterSelectors: { #setter2 };
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self assertCollection: desc1 possibleSetterSelectors includesAll: { #setter1 . #setter2 }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testCombineWithSlotDescription6 [

	| desc1 desc2 |
	desc1 := DragonSlotDescription new
		         slot: #hello;
		 possibleSetterSelectors: { #setter1 . #setter2 };
		         yourself.
	desc2 := DragonSlotDescription new
		         slot: #hello;
		         possibleSetterSelectors: { #setter2 . #setter3 };
		         yourself.
	desc1 combineWithSlotDescription: desc2.
	self assertCollection: desc1 possibleSetterSelectors includesAll: { #setter1 . #setter2 . #setter3 }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testInstallDragonDescriptionOn1 [

	| object1 |
	object1 := DragonTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { ByteString }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				possibleSetterSelectors
		equals: { #slot: }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				possibleGetterSelectors
		equals: { #slot }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testInstallDragonDescriptionOn2 [

	| object1 object2 |
	object1 := DragonTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := DragonTestObjectNoDefinition new
		           slot: 'Goodbye World !';
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { ByteString }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testInstallDragonDescriptionOn3 [

	| object1 object2 |
	object1 := DragonTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := DragonTestObjectNoDefinition new
		           slot: 5;
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	self
		assertCollection:
			(object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		includesAll: {
				SmallInteger.
				ByteString }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testInstallDragonDescriptionOn4 [

	| object1 |
	object1 := DragonTestObjectNoDefinitionSubclass new
		           slot: 'Hello World !';
		           subclassSlot: 4;
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 2.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { ByteString }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				possibleSetterSelectors
		equals: { #slot: }.
	self
		assert:
			(object1 dragonDescription slotDescriptionNamed: #subclassSlot)
				possibleSetterSelectors
		equals: { #subclassSlot: }.
	self
		assert:
			(object1 dragonDescription slotDescriptionNamed: #subclassSlot)
				knownTypeValues
		equals: { SmallInteger }
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testInstallDragonDescriptionOn5 [

	| object1 descriptionSlot |
	object1 := DragonTestObjectWithDefinition new
		           slot: 5;
		           yourself.

	self assert: object1 dragonDescription slotDescriptions size equals: 1.
	descriptionSlot := object1 dragonDescription slotDescriptionNamed: #slot.
	self assert: descriptionSlot knownTypeValues size equals: 1.
	self assertCollection: descriptionSlot knownTypeValues includesAll: { String }.
	self assert: descriptionSlot possibleGetterSelectors size equals: 1.
	self assertCollection: descriptionSlot possibleGetterSelectors includesAll: { #hello }.
	self assert: descriptionSlot possibleSetterSelectors size equals: 1.
	self assertCollection: descriptionSlot possibleSetterSelectors includesAll: { #hello: }.
	
	object1 generateDragonDescription.
	
	self assert: object1 dragonDescription slotDescriptions size equals: 1.
	descriptionSlot := object1 dragonDescription slotDescriptionNamed: #slot.
	self assert: descriptionSlot knownTypeValues size equals: 2.
	self assertCollection: descriptionSlot knownTypeValues includesAll: { String . SmallInteger }.
	self assert: descriptionSlot possibleGetterSelectors size equals: 2.
	self assertCollection: descriptionSlot possibleGetterSelectors includesAll: { #hello . #slot }.
	self assert: descriptionSlot possibleSetterSelectors size equals: 2.
	self assertCollection: descriptionSlot possibleSetterSelectors includesAll: { #hello: . #slot: }.
]

{ #category : 'tests' }
DragonSlotDescriptionTest >> testInstallDragonDescriptionOn6 [

	| object1 descriptionSlot |
	object1 := DragonTestObjectWithDefinitionButNoSlot new.

	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 0.

	object1 generateDragonDescription.

	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	descriptionSlot := object1 dragonDescription slotDescriptionNamed:
		                   #test.
	self assert: descriptionSlot knownTypeValues size equals: 1.
	self
		assertCollection: descriptionSlot knownTypeValues
		includesAll: {
				UndefinedObject }.
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
DragonSlotDescriptionTest >> testInstallDragonDescriptionOn7 [

	| object1 object2 |
	object1 := DragonTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := DragonTestObjectNoDefinition new
		           slot: #test;
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	self
		assertCollection:
			(object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		includesAll: {
				String }
]
