Extension { #name : 'Trait' }

{ #category : '*Dragon' }
Trait >> removeDragonDescription [

	^ self removeDragonDescriptionIf: [ :desc | true ]
]

{ #category : '*Dragon' }
Trait >> removeDragonDescriptionIf: aBlock [
	| selectorRemoved |
	selectorRemoved := OrderedCollection new.
	(Pragma allNamed: #dragonDescription in: self) do: [ :pragma |
		(aBlock value: (pragma method valueWithReceiver: nil)) ifTrue: [
			self removeSelector: pragma method selector.
			selectorRemoved add: pragma method selector ] ].
	^ selectorRemoved asArray
]
