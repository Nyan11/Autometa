Class {
	#name : 'AutometaDescriptionTest',
	#superclass : 'TestCase',
	#category : 'Autometa-Tests',
	#package : 'Autometa-Tests'
}

{ #category : 'tests' }
AutometaDescriptionTest >> testAutometaDescription1 [

	self
		assert: AutometaTestObject new autometaFullDescription objectClass
		equals: AutometaTestObject.
	self
		assert: AutometaTestObject new autometaFullDescription slotDescriptions size
		equals: 3.
	self
		assert:
			(AutometaTestObject new autometaFullDescription slotDescriptionNamed: #name)
				name
		equals: #name.
	self
		assert:
			(AutometaTestObject new autometaFullDescription slotDescriptionNamed: #name)
				knownTypeValues size
		equals: 1.
	self
		assert:
			(AutometaTestObject new autometaFullDescription slotDescriptionNamed: #name)
				knownTypeValues first
		equals: String
]

{ #category : 'tests' }
AutometaDescriptionTest >> testAutometaDescription2 [

	self
		should: [
			AutometaTestObject new autometaFullDescription slotDescriptionNamed:
				#doNotExist ]
		raise: AutometaErrorNoSlotNamed
]

{ #category : 'tests' }
AutometaDescriptionTest >> testAutometaDescription3 [

	self
		should: [
			AutometaTestObject new autometaFullDescription slotDescriptionNamed:
				#otherSlot ]
		raise: AutometaErrorMultipeSlotNamed
]
