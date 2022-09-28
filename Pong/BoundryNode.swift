//
//  BoundryNode.swift
//  Pong
//
//  Created by Theodore Charts on 9/28/22.
//

import SpriteKit

class BoundryNode: SKSpriteNode {
    
    init(from: CGPoint, to: CGPoint) {
        super.init(texture: nil, color: .clear, size: .zero)
    
        self.physicsBody = SKPhysicsBody(edgeFrom: from, to: to).manualMovement()
        self.physicsBody?.categoryBitMask = PhysicsCategory.boundry
        self.physicsBody?.collisionBitMask = PhysicsCategory.ball
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
