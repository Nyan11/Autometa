Class {
	#name : 'AutometaInspectDescriptionCommand',
	#superclass : 'AutometaCommand',
	#category : 'Autometa-Commands',
	#package : 'Autometa',
	#tag : 'Commands'
}

{ #category : 'activation' }
AutometaInspectDescriptionCommand class >> browserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: AutometaCmdMenuGroup
		  order: 10
		  for: ClyFullBrowserClassContext
]

{ #category : 'accessing' }
AutometaInspectDescriptionCommand >> defaultMenuIconName [

	^ #inspect
]

{ #category : 'accessing' }
AutometaInspectDescriptionCommand >> defaultMenuItemName [

	^ 'Inspect description'
]

{ #category : 'accessing' }
AutometaInspectDescriptionCommand >> description [

	^ 'Show the description of the selected class'
]

{ #category : 'accessing' }
AutometaInspectDescriptionCommand >> execute [

	self selectedClasses size = 1 ifTrue: [
		self selectedClasses first autometaFullDescription inspect.
		^ self ].
	(self selectedClasses collect: #autometaFullDescription) inspect
]
