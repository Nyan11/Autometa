Class {
	#name : 'AutometaDescriptionBuilder',
	#superclass : 'Object',
	#instVars : [
		'classesToGenerate',
		'packageToGenerate',
		'verboseLevel'
	],
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder class >> buildClassAndSubClassDescriptions: aClass inPackage: aPackage [

	self
		buildClassDescriptions: aClass withAllSubclasses
		inPackage: aPackage
		withVerboseLevel: AutometaVerboseLevel new
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder class >> buildClassAndSuperClassDescriptions: aClass inPackage: aPackage [

	(aClass = Object or: [ aClass = ProtoObject ]) ifTrue: [
		^ Error signal: 'cannot do that !' ].
	self
		buildClassDescriptions: aClass withAllSuperclasses
		inPackage: aPackage
		withVerboseLevel: AutometaVerboseLevel new
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder class >> buildClassDescriptionInPackage: aClassPackage inPackage: aPackage [

	self
		buildClassDescriptions: aClassPackage classes
		inPackage: aPackage
		withVerboseLevel: AutometaVerboseLevel new
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder class >> buildClassDescriptions: aCollectionOfClasses inPackage: aPackage withVerboseLevel: aDragonVerboseLevel [

	| builder |
	builder := self new
		           packageToGenerate: aPackage;
		           classesToGenerate: aCollectionOfClasses;
		           verboseLevel: aDragonVerboseLevel;
		           yourself.

	[ builder build ] fork
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder class >> removeClassDescriptionInPackage: aPackage [

	aPackage classes do: [ :cls | cls removeDragonDescription ]. 
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder class >> removeClassDescriptionInPackage: aPackage if: aBlock [

	aPackage classes do: [ :cls | cls removeDragonDescriptionIf: aBlock ]
]

{ #category : 'building' }
AutometaDescriptionBuilder >> build [

	| allClassesToDo |
	allClassesToDo := (self classesToGenerate flatCollect:
		                   #withAllSuperclasses) asSet difference: {
			                  Object.
			                  ProtoObject }.
	allClassesToDo := allClassesToDo , (allClassesToDo flatCollect: #traits).
	allClassesToDo asSet difference: {
			                  Object.
			                  ProtoObject }.
	self verboseLevel startBuilding: allClassesToDo.
	allClassesToDo do: [ :cls | "self buildSlotsFor: cls."
		self verboseLevel startClass: cls.
		self buildAccessorsFor: cls.
		self verboseLevel endClass: cls ].
	self verboseLevel endBuilding
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> buildAccessorsDescriptionForSelector: aSelector andInstances: aCollectionOfObject andClass: aClass [

	| allValues allValueTypes description multiplicity |
	(aClass package name beginsWith: 'Collection') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Display') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Text') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Graphics') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'System') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Kernel') ifTrue: [ ^ self ].
	allValues := aCollectionOfObject collect: [ :inst |
		             [ inst perform: aSelector ]
			             on: Error
			             do: [ ^ self ] ].
	allValueTypes := self reduceAllValuesToTypeValues: allValues.
	allValueTypes ifEmpty: [ ^ self ].
	multiplicity := self multiplicityFromValues: allValues.

	description := AutometaPropertyDescription new
		               name: aSelector;
		               possibleGetterSelectors: { aSelector };
		               possibleSetterSelectors: { aSelector asMutator };
		               knownTypeValues: allValueTypes;
		               multiplicity: multiplicity;
		               yourself.

	self installAutometaDescription: description onClass: aClass
]

{ #category : 'building' }
AutometaDescriptionBuilder >> buildAccessorsFor: aClass [

	| allInstances |
	"We check for each class all instances and subinstances that could contains the value for each slot."
	allInstances := aClass isTrait
		                ifTrue: [ aClass users flatCollect: #allInstances ]
		                ifFalse: [
		                aClass withAllSubclasses flatCollect: #allInstances ].
	aClass methods do: [ :method |
		method numArgs = 0 and: [
			method protocol isNotNil and: [
				(method protocol name beginsWith: 'private') not and: [
					(aClass methods anySatisfy: [ :each |
						 each selector = method selector asMutator ]) ifTrue: [
						self
							buildAccessorsDescriptionForSelector: method selector
							andInstances: allInstances
							andClass: aClass ] ] ] ] ]
]

{ #category : 'building' }
AutometaDescriptionBuilder >> buildSlotsFor: aClass [

	| allInstances |
	"We check for each class all instances and subinstances that could contains the value for each slot."
	allInstances := aClass withAllSubclasses flatCollect: #allInstances.
	aClass slots do: [ :slot |
		| allValues allValueTypes description matcherSetter matcherGetter possibleSetterSelectors possibleGetterSelectors |
		allValues := allInstances collect: [ :inst | slot read: inst ].
		allValueTypes := self reduceAllValuesToTypeValues: allValues.
		"We need to find all possible setters for each slot.
		We recover all method that are using this slot and select only the one with one argument."
		matcherSetter := RBParseTreeSearcher setterMethod: slot name.
		matcherGetter := RBParseTreeSearcher getterMethod: slot name.
		possibleSetterSelectors := OrderedCollection new.
		possibleGetterSelectors := OrderedCollection new.
		slot usingMethods do: [ :method |
			| parseTree |
			parseTree := method parseTree.
			method numArgs = 1 ifTrue: [
				matcherSetter executeTree: parseTree.
				matcherSetter answer ifNotNil: [
					possibleSetterSelectors add: method selector ] ].
			method numArgs = 0 ifTrue: [
				matcherGetter executeTree: parseTree.
				matcherGetter answer ifNotNil: [
					possibleGetterSelectors add: method selector ] ] ].
		description := AutometaPropertyDescription new
			               name: slot name;
			               possibleSetterSelectors: possibleSetterSelectors;
			               possibleGetterSelectors: possibleGetterSelectors;
			               knownTypeValues: allValueTypes;
			               yourself.
		self installAutometaDescription: description ]
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> classToGenerate: aClass [

	classesToGenerate := { aClass }
]

{ #category : 'accessing' }
AutometaDescriptionBuilder >> classesToGenerate [

	^ classesToGenerate
]

{ #category : 'accessing' }
AutometaDescriptionBuilder >> classesToGenerate: aCollection [

	classesToGenerate := aCollection
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> commonSuperClassBetween: aClass1 and: aClass2 [

	| class1Collection class2Collection |
	aClass1 = aClass2 ifTrue: [ ^ aClass1 ].
	((class1Collection := aClass1 withAllSuperclasses) includes: aClass2)
		ifTrue: [ ^ aClass2 ].
	((class2Collection := aClass2 withAllSuperclasses) includes: aClass1)
		ifTrue: [ ^ aClass1 ].
	class1Collection do: [ :each | (class2Collection includes: each) ifTrue: [ ^ each ] ].
	^ Object
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> commonSuperClassExceptObjectBetween: aClass1 and: aClass2 [

	| clazz |
	"Return the common super class between the 2 classes. If it is Object return nil"
	clazz := self commonSuperClassBetween: aClass1 and: aClass2.
	clazz = Object ifTrue: [ ^ nil ].
	^ clazz
]

{ #category : 'building' }
AutometaDescriptionBuilder >> initialize [


	super initialize .
	verboseLevel := AutometaNoVerboseLevel new.
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> installAutometaDescription: aAutometaPropertyDescription onClass: aClass [

	| methodSelector methodString knownTypeValuesString possibleGetterSelectorsString possibleSetterSelectorsString protocol |
	aClass autometaInstanceDescription
		slotDescriptionNamed: aAutometaPropertyDescription name
		ifFound: [ :description |
			(description knownTypeValues includesAll:
				 aAutometaPropertyDescription knownTypeValues) ifTrue: [ ^ self ].
			aAutometaPropertyDescription combineWithSlotDescription:
				description ].
	aAutometaPropertyDescription knownTypeValues:
		(self reduceAllTypeValues:
			 aAutometaPropertyDescription knownTypeValues).

	methodString := 'autometa<1s><r><r><t>%<autometaDescription><r><t>^ AutometaPropertyDescription new name: #<2s>; knownTypeValues: { <3s> }; possibleGetterSelectors: { <4s> }; possibleSetterSelectors: { <5s> }; multiplicity: ((<6s>) -> (<7s>));yourself'.

	knownTypeValuesString := String streamContents: [ :s |
		                         aAutometaPropertyDescription
			                         knownTypeValues
			                         do: [ :each | s << each name ]
			                         separatedBy: [ s << ' . ' ] ].
	possibleGetterSelectorsString := String streamContents: [ :s |
		                                 aAutometaPropertyDescription
			                                 possibleGetterSelectors
			                                 do: [ :each | s << '#' << each ]
			                                 separatedBy: [ s << ' . ' ] ].
	possibleSetterSelectorsString := String streamContents: [ :s |
		                                 aAutometaPropertyDescription
			                                 possibleSetterSelectors
			                                 do: [ :each | s << '#' << each ]
			                                 separatedBy: [ s << ' . ' ] ].

	methodSelector := aClass compile:
		                  (methodString expandMacrosWithArguments: {
				                   aAutometaPropertyDescription name capitalized.
				                   aAutometaPropertyDescription name.
				                   knownTypeValuesString.
				                   possibleGetterSelectorsString.
				                   possibleSetterSelectorsString.
				                   aAutometaPropertyDescription multiplicity key
					                   asCodeString.
				                   aAutometaPropertyDescription multiplicity value
					                   asCodeString }).
	self packageToGenerate
		ifNil: [ protocol := 'dragon meta description' ]
		ifNotNil: [ protocol := '*' , self packageToGenerate name ].
	(aClass methodNamed: methodSelector) protocol: protocol
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> multiplicityFromValues: aCollectionOfObjects [

	| min max allCollection collectionClass |
	min := (aCollectionOfObjects includes: nil)
		       ifTrue: [ AutometaZeroMultiplicity new ]
		       ifFalse: [ AutometaOneMultiplicity new ].
	allCollection := (aCollectionOfObjects select: #isCollection)
		                 reject: #isString.

	allCollection ifEmpty: [ ^ min -> AutometaOneMultiplicity new ].

	
	collectionClass := (self reduceAllTypeValues: (allCollection collect: #class)).
	collectionClass ifEmpty: [ self halt. "Error should have one class." ].
	collectionClass size > 1 ifTrue: [ self halt. "Error should have only one type of collection." ].
	collectionClass := collectionClass first.
	max := (allCollection reduce: [ :a :b |
		        'a' repeat: (a size max: b size) ]) size.
	^ min -> (AutometaCollectionMultiplicity new foundSize: max; collectionClass: collectionClass; yourself).
]

{ #category : 'accessing' }
AutometaDescriptionBuilder >> packageToGenerate [

	^ packageToGenerate
]

{ #category : 'accessing' }
AutometaDescriptionBuilder >> packageToGenerate: anObject [

	packageToGenerate := anObject
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> reduceAllTypeValues: aCollectionOfClass [

	| refinedClasses |
	refinedClasses := OrderedCollection new.
	aCollectionOfClass do: [ :classToAdd |
		refinedClasses ifEmpty: [ refinedClasses add: classToAdd ].
		refinedClasses do: [ :refinedClass |
			(self
				 commonSuperClassExceptObjectBetween: classToAdd
				 and: refinedClass)
				ifNil: [ refinedClasses add: classToAdd ]
				ifNotNil: [ :newClass |
					refinedClasses remove: refinedClass.
					refinedClasses add: newClass ] ] ].
	^ refinedClasses asArray
]

{ #category : 'as yet unclassified' }
AutometaDescriptionBuilder >> reduceAllValuesToTypeValues: aCollectionOfObjects [

	| allClasses |
	allClasses := (aCollectionOfObjects collect: #asAutometaType) flattened
		              asSet.
	allClasses := allClasses reject: [ :each | each = UndefinedObject ].
	^ self reduceAllTypeValues: allClasses
]

{ #category : 'accessing' }
AutometaDescriptionBuilder >> verboseLevel [

	^ verboseLevel
]

{ #category : 'accessing' }
AutometaDescriptionBuilder >> verboseLevel: anObject [

	verboseLevel := anObject
]
