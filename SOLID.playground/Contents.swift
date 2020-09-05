import UIKit

//1. Single Responsebility
// Each class must have only one responsibility.
protocol CanPlayOn {
    func playOn()
}
protocol CanPlayOff {
    func playOff()
}
class Player : CanPlayOn , CanPlayOff {
    private var play = false
    func playOn() {
        play = true
    }
    func playOff() {
        play = false
    }
}
class PlayerOn {
    let player : CanPlayOn
    init(player : CanPlayOn) {
        self.player = player
    }
    func execute() {
        player.playOn()
    }
}
class PlayerOff {
    let player : CanPlayOff
    init(player : CanPlayOff ) {
        self.player = player
    }
    func execute() {
    player.playOff()
    }
}
let player = Player()
let playOn = PlayerOn(player: player)
playOn.execute()
let playerOff = PlayerOff(player: player)
playerOff.execute()

//2. Open Cloce principle
//Objects and functions must be open for expansion and closed for modification.
//We implement a class from a drawing protocol
//Class objects that can draw use the protocol
//paintings.

protocol CanbeDraw {
    func drawing() -> String
}
class PixelArtist : CanbeDraw {
    func drawing() -> String {
        return "Pixel drawing"
    }
}
class Object3DModeler : CanbeDraw {
    func drawing() -> String {
        return "3D Drawing"
    }
}
class GraphicDesigner : CanbeDraw {
    func drawing() -> String {
        return "Corel Draw Drawing"
    }
}
class Team {
    let team : [CanbeDraw]
    init(team : [CanbeDraw]) {
        self.team = team
    }
    func fetchTeam() -> [String] {
        team.map { $0.drawing()}
    }
}
let pixelArtist = PixelArtist()
let modeler3D = Object3DModeler()
let graphicDesigner = GraphicDesigner()
let team = Team(team: [pixelArtist,modeler3D,graphicDesigner])
team.fetchTeam()

//3.Substitute principle Barbara Liskov
//The descendant class should supplement, not change
//the behavior base class
protocol CanJump {
    var jump : Double {get}
}
protocol CanSwim {
    var speedSwim : Double {get}
}
class Bike {
    var name : String
    var color : String
    init(name : String, color : String) {
        self.name = name
        self.color = color
    }
}
class WaterBike : Bike ,CanSwim {
    var speedSwim: Double
    init(name : String ,color : String ,speedSwim : Double) {
        self.speedSwim = speedSwim
        super.init(name : name ,color : color)
    }
}
class JumpBike : Bike , CanJump {
    var jump: Double
     init(name: String, color: String ,jump : Double) {
        self.jump = jump
        super.init(name: name, color: color)
    }
}
let waterBike = WaterBike(name: "Water 750", color: "Blue", speedSwim: 29.0)
let jumpBike = JumpBike(name: "Jump 5", color: "Black", jump: 20.0)

//4. Interface Segrigation
// The principle of separation of interfaces
// Clients should not depend on methods that do not use.

protocol IosDeveloper {
    var swift : Bool {get}
    var objC : Bool {get}
}
protocol WebDeveloper {
    var php : Bool {get}
    var js : Bool {get}
}
protocol UnixDeveloper {
    var cpp : Bool {get}
    var java : Bool {get}
}
class CvIosDeveloper : IosDeveloper {
    var swift: Bool
    var objC: Bool
    init(swift : Bool , objC : Bool) {
        self.swift = swift
        self.objC = objC
    }
}
class CvUnixDeveloper : UnixDeveloper{
    var cpp: Bool
    var java: Bool
    init(cpp : Bool ,java : Bool) {
        self.cpp = cpp
        self.java = java
    }
}
class CvWebDeveloper : WebDeveloper {
    var php: Bool
    var js: Bool
    init(php : Bool, js : Bool) {
        self.php = php
        self.js = js
    }
}
let webDeveloper = CvWebDeveloper(php: true, js: true)
let iosDeveloper = CvIosDeveloper(swift: true, objC: false)
let unixDeveloper = CvUnixDeveloper(cpp: true, java: true)

// 5. Dispencity injection
//The upper level module should not depend on the lower level module.
//Lower level modules must use abstraction.

protocol FoodProveder {
    func getFood() -> String
}
class MacDonalds : FoodProveder {
    func getFood() -> String {
        return "Big Mac"
    }
}
class Mother : FoodProveder {
    func getFood() -> String {
        return "Best Food"
    }
}
class Sister : FoodProveder {
    func getFood() -> String {
           return "Great Food"
    }
}

class LuckyMan {
    let foodProvider : FoodProveder
    var food : String?
    
    init(foodProvider : FoodProveder) {
        self.foodProvider = foodProvider
    }
    
    func eat() -> String {
        food = foodProvider.getFood()
        return food!
    }
}

let oneMan = LuckyMan(foodProvider: Sister())
oneMan.eat()


