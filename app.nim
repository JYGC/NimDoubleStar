import std/math
import std/strformat

const gravConstant: float = 0.000001
const computeTimeInterval: float = 0.0001
const displayTimeInterval: float = 1

type Mass = object
    name: string
    mass: float
    positionX: float
    positionY: float
    velocityX: float
    velocityY: float
    accelerationX: float
    accelerationY: float

proc computeGravAcceleration(targetMass: Mass, actingMass: Mass): Mass =
    var updatedtargetMass: Mass
    var distanceX: float = targetMass.positionX - actingMass.positionX
    var distanceY: float = targetMass.positionY - actingMass.positionY
    updatedtargetMass = targetMass
    updatedtargetMass.accelerationX += -gravConstant * actingMass.mass * distanceX / pow(pow(distanceX, 2) + pow(distanceY, 2), 1.5)
    updatedtargetMass.accelerationY += -gravConstant * actingMass.mass * distanceY / pow(pow(distanceX, 2) + pow(distanceY, 2), 1.5)
    result = updatedtargetMass

proc computeMovement(targetMass: Mass): Mass =
    var updatedtargetMass: Mass
    updatedtargetMass = targetMass
    updatedtargetMass.velocityX += targetMass.accelerationX * computeTimeInterval
    updatedtargetMass.velocityY += targetMass.accelerationY * computeTimeInterval
    updatedtargetMass.positionX += (targetMass.velocityX + (0.5 * targetMass.accelerationX)) * computeTimeInterval
    updatedtargetMass.positionY += (targetMass.velocityY + (0.5 * targetMass.accelerationY)) * computeTimeInterval
    updatedtargetMass.accelerationX = 0
    updatedtargetMass.accelerationY = 0
    result = updatedtargetMass

when isMainModule:
    var star1 = Mass(name: "star 1",
                     mass: 100,
                     positionX: 3,
                     velocityY: 0.003)

    var star2 = Mass()
    star2.name = "star 2"
    star2.mass = 100
    star2.positionX = -3
    star2.velocityY = -0.003

    var simulationTime: float = 0
    var timeToDisplay: float = 0
    while true:    
        star2 = computeGravAcceleration(star2, star1)
        star1 = computeGravAcceleration(star1, star2)
        star1 = computeMovement(star1)
        star2 = computeMovement(star2)
        simulationTime += computeTimeInterval
        timeToDisplay += computeTimeInterval
        if timeToDisplay >= displayTimeInterval:
            echo fmt"({star1.positionX}, {star1.positionY}), ({star2.positionX}, {star2.positionY})"
            timeToDisplay = 0
