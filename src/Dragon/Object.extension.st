Extension { #name : 'Object' }

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
Object class >> removeDragonDescription [

	(Pragma allNamed: #dragonDescription in: self) do: [ :pragma |
		self removeSelector: pragma method selector ].
]
