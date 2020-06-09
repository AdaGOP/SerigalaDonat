//
//  HUD.swift
//  Serigaladonat
//
//  Created by David Gunawan on 09/06/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import SpriteKit

class HUD {
    private var _scene: SKScene!
    var joyStick: AnalogJoystick!
    
    var scene: SKScene {
        return _scene
    }
    
    init(size: CGSize) {
        _scene = SKScene(size: size)
        joyStick = AnalogJoystick(diameter: size.width / 2, colors: nil, images: (substrate: #imageLiteral(resourceName: "jSubstrate"), stick: #imageLiteral(resourceName: "jStick")))
        joyStick.position = CGPoint(x: size.width / 2, y: size.width / 2)
        scene.addChild(joyStick)
    }
}
