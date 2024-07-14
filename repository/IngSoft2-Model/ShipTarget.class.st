"
ship target class
"
Class {
	#name : 'ShipTarget',
	#superclass : 'Target',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
ShipTarget >> isValidWith: aCollectionOfShips and: aCardHandler [ 
	
	^(aCollectionOfShips anySatisfy: [ :ship | ship shipName = objective  ])
	
]
