"
make two ships allies, the target ship must help the holder in battle and if they share a tile they will not fight
"
Class {
	#name : 'MercenaryCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
MercenaryCard >> activate: aCardHandler withTarget: aShip [

	target := aShip.
	aCardHandler verifyCoalition: aShip objective.
	aCardHandler addCoalition:
		(ShipCoalition withLeader: holder andMercenary: target objective).
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self
]

{ #category : 'event' }
MercenaryCard >> deactivate: aCardHandler [

	super deactivate: aCardHandler.
	aCardHandler removeCoalitionOf: holder and: target
]
