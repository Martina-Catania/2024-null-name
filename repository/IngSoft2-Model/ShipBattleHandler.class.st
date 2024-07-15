"
handles battles between ships and determines who participates
"
Class {
	#name : 'ShipBattleHandler',
	#superclass : 'Object',
	#instVars : [
		'dice',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'events' }
ShipBattleHandler class >> withDice: aCollectionOfDice withShips: aCollectionOfShips [

	^ self new
		  initializeWithShips: aCollectionOfShips
		  withDice: aCollectionOfDice
]

{ #category : 'initialization' }
ShipBattleHandler >> checkShipBattle: currentTurnShip withCardHandler: gameCardHandler [

	| shipsInSamePosition |
	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
				                       ((gameCardHandler mercenariesOf:
					                         currentTurnShip) includes:
					                        aShip shipName) not ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self
			resolveBattleBetween: currentTurnShip
			and: aShipInSamePosition
			with: gameCardHandler ]
]

{ #category : 'initialization' }
ShipBattleHandler >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
]

{ #category : 'event' }
ShipBattleHandler >> resolveBattleBetween: aShip and: anotherShip with: aCardHandler [

	| aShipDiceRoll anotherShipDiceRoll loserShipArmy aShipArmy anotherShipArmy |
	aShipArmy := self shipsNames: (aCardHandler mercenariesOf: aShip).
	anotherShipArmy := self shipsNames:
		                   (aCardHandler mercenariesOf: anotherShip).

	aShipDiceRoll := 0.
	anotherShipDiceRoll := 0.
	aShipArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := aCardHandler movementCardsActivated: aShipInArmy.
		aShipDiceRoll + dice throw + cardMovement ].

	anotherShipArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := aCardHandler movementCardsActivated: aShipInArmy.
		aShipDiceRoll + dice throw + cardMovement ].
	
	loserShipArmy := aShipDiceRoll > anotherShipDiceRoll
		                 ifTrue: [ anotherShipArmy ]
		                 ifFalse: [ aShipArmy ].
	loserShipArmy do: [ :aShipInArmy |
		aShip loseOneShield.
		aShip moveToFirstTile ]
]

{ #category : 'event' }
ShipBattleHandler >> shipWithName: aShipName [

	^ ships detect: [ :ship | ship shipName = aShipName ]
]

{ #category : 'event' }
ShipBattleHandler >> shipsNames: aShipsNameCollection [
	
	^ aShipsNameCollection collect: [ :shipName | self shipWithName: shipName  ].
]
