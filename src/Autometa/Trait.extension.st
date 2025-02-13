Extension { #name : 'Trait' }

{ #category : '*Autometa' }
Trait >> autometaRemoveDescription [

	^ self autometaRemoveDescriptionIf: [ :desc | true ]
]

{ #category : '*Autometa' }
Trait >> autometaRemoveDescriptionIf: aBlock [

	| selectorRemoved |
	selectorRemoved := OrderedCollection new.
	(Pragma allNamed: #autometaDescription in: self) do: [ :pragma |
		(aBlock value: (pragma method valueWithReceiver: nil)) ifTrue: [
			self removeSelector: pragma method selector.
			selectorRemoved add: pragma method selector ] ].
	^ selectorRemoved asArray
]
