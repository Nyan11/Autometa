Extension { #name : 'TEwPtfTrack' }

{ #category : '*Dragon' }
TEwPtfTrack >> dragonAzimuth [

	<dragonDescription>
	^ DragonSlotDescription new slot: #azimuth; knownTypeValues: { UnitValue }; yourself
]

{ #category : '*Dragon' }
TEwPtfTrack >> dragonDistance [

	<dragonDescription>
	^ DragonSlotDescription new slot: #distance; knownTypeValues: { UndefinedObject }; yourself
]

{ #category : '*Dragon' }
TEwPtfTrack >> dragonEmitterTrackTnList [

	<dragonDescription>
	^ DragonSlotDescription new slot: #emitterTrackTnList; knownTypeValues: { OrderedCollection }; yourself
]
