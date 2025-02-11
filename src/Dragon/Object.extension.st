Extension { #name : 'Object' }

{ #category : '*Dragon' }
Object >> asDragonType [

	^ self class
]

{ #category : '*Dragon' }
Object class >> dragonFullDescription [

	| description |
	description := DragonDescription new objectClass: self.
	description slotDescriptions:
		((Pragma allNamed: #dragonDescription from: self to: Object)
			 collect: [ :pragma | pragma method valueWithReceiver: nil ]).
	^ description
]

{ #category : '*Dragon' }
Object >> dragonFullDescription [

	^ self class dragonFullDescription
]

{ #category : '*Dragon' }
Object class >> dragonInstanceDescription [

	| description |
	description := DragonDescription new objectClass: self.
	description slotDescriptions:
		((Pragma allNamed: #dragonDescription from: self to: self) collect: [ :pragma |
			 pragma method valueWithReceiver: nil ]).
	^ description
]

{ #category : '*Dragon' }
Object >> dragonInstanceDescription [

	^ self class dragonInstanceDescription
]

{ #category : '*Dragon' }
Object >> dragonObjectConstructor [

	<dragonConstructor>
	^ DragonConstructorDescription new
		  constructorArguments: {  };
		  constructorValuable: [ :class | class new ];
		  yourself
]

{ #category : '*Dragon' }
Object class >> generateDragonDescription [

	^ self generateDragonDescriptionInPackage: nil
]

{ #category : '*Dragon' }
Object >> generateDragonDescription [

	^ self class generateDragonDescription
]

{ #category : '*Dragon' }
Object class >> generateDragonDescriptionInPackage: aPackage [

	^ DragonDescriptionBuilder new
		  classToGenerate: self;
		  packageToGenerate: aPackage;
		  build
]

{ #category : '*Dragon' }
Object >> generateDragonDescriptionInPackage: aPackage [

	^ self class generateDragonDescriptionInPackage: aPackage
]

{ #category : '*Dragon' }
Object >> isDragonFinal [

	^ self class isDragonFinal
]

{ #category : '*Dragon' }
Object class >> removeDragonDescription [

	^ self removeDragonDescriptionIf: [ :desc | true ]
]

{ #category : '*Dragon' }
Object >> removeDragonDescription [

	^ self removeDragonDescriptionIf: [ :desc | true ]
]

{ #category : '*Dragon' }
Object class >> removeDragonDescriptionIf: aBlock [

	| selectorRemoved |
	selectorRemoved := OrderedCollection new.
	(Pragma allNamed: #dragonDescription in: self) do: [ :pragma |
		(aBlock value: (pragma method valueWithReceiver: nil)) ifTrue: [
			self removeSelector: pragma method selector.
			selectorRemoved add: pragma method selector ] ].
	^ selectorRemoved asArray
]

{ #category : '*Dragon' }
Object >> removeDragonDescriptionIf: aBlock [

	^ self class removeDragonDescriptionIf: aBlock
]
