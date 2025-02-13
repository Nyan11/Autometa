Class {
	#name : 'AutometaGenerateDescriptionCommand',
	#superclass : 'AutometaCommand',
	#category : 'Autometa-Commands',
	#package : 'Autometa',
	#tag : 'Commands'
}

{ #category : 'activation' }
AutometaGenerateDescriptionCommand class >> browserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: AutometaCmdMenuGroup
		  order: 20
		  for: ClyFullBrowserClassContext
]

{ #category : 'accessing' }
AutometaGenerateDescriptionCommand >> defaultMenuIconName [

	^ #add
]

{ #category : 'accessing' }
AutometaGenerateDescriptionCommand >> defaultMenuItemName [

	^ 'Generate description'
]

{ #category : 'accessing' }
AutometaGenerateDescriptionCommand >> description [

	^ 'Generate the description of the selected class'
]

{ #category : 'execution' }
AutometaGenerateDescriptionCommand >> execute [

	(self selectedClasses do: #autometaGenerateDescription)
]
