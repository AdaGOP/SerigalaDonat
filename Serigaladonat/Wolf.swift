//
//  Wolf.swift
//  Serigaladonat
//
//  Created by David Gunawan on 09/06/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import SceneKit

enum WolfState {
    case idle,running,walking
}

class Wolf: SCNNode {
    
    private var wolfNodeWalking: SCNNode = SCNNode()
    private var wolfNodeRunning: SCNNode = SCNNode()
    private var wolfNodeIdle: SCNNode = SCNNode()
    private var activeNode: SCNNode?
    
    override init() {
        super.init()
        loadWolfState()
        setWolf(state: .idle)
    }
    
    private func loadWolfState() {
        guard
            let wolfSceneWalking = SCNScene(named: "art.scnassets/Wolf/Wolf_Walking.scn"),
            let wolfSceneRunning = SCNScene(named: "art.scnassets/Wolf/Wolf_Running.scn"),
            let wolfSceneIdle = SCNScene(named: "art.scnassets/Wolf/Wolf_Idle.scn")
        else {
            fatalError("Wolf Scene is missing")
        }
        self.wolfNodeWalking.addChildNode(wolfSceneWalking.rootNode)
        self.wolfNodeRunning.addChildNode(wolfSceneRunning.rootNode)
        self.wolfNodeIdle.addChildNode(wolfSceneIdle.rootNode)
    }
    
    public func setWolf(state: WolfState) {
        activeNode?.removeFromParentNode()
        activeNode = nil
        switch state {
        case .idle:
            activeNode = wolfNodeIdle
        case .walking:
            activeNode = wolfNodeWalking
        case .running:
            activeNode = wolfNodeRunning
        }
        addChildNode(activeNode!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
