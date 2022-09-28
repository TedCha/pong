//
//  PaddleNode.swift
//  Pong
//
//  Created by Theodore Charts on 9/25/22.
//

import SpriteKit

class PaddleNode: SKSpriteNode {
    let maxBounceAngle = CGFloat(60).degreesToRadians()
    let side: Side
    
    init(_ side: Side) {
        self.side = side
        super.init(texture: nil, color: .white, size: CGSizeMake(20, 150))
    
        self.physicsBody = SKPhysicsBody(rectangleOf: size).manualMovement()
        self.physicsBody?.categoryBitMask = PhysicsCategory.paddle
        self.physicsBody?.collisionBitMask = PhysicsCategory.ball
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        guard let parentFrame = parent?.frame else { fatalError("node must be added to tree to use") }
                
        switch (side) {
        case .right:
            self.position = CGPointMake(parentFrame.maxX - (size.width/2), parentFrame.midY)
        case .left:
            self.position = CGPointMake(parentFrame.minX + (size.width/2), parentFrame.midY)
        case .none:
            fatalError("node must be .left or .right")
        }
        
        let movementConstraint = SKConstraint.positionY(
            SKRange(
                lowerLimit: parentFrame.minY + size.height/2,
                upperLimit: parentFrame.maxY - size.height/2
            )
        )
        self.constraints = [movementConstraint]
    }

    // https://gamedev.stackexchange.com/a/4255
    func getContactReflectionVector(atContactPoint: CGPoint) -> CGVector {
        let convertedPoint = convert(atContactPoint, from: parent!)
        let relIntersectY = anchorPoint.y - convertedPoint.y
        let normRelIntersectY = relIntersectY / (size.height / 2)
        
        var bounceAngle = normRelIntersectY * maxBounceAngle
        if self.side == .right {
            bounceAngle = CGFloat.pi - bounceAngle
        }
        
        let ballVx = 400 * cos(bounceAngle);
        let ballVy = 400 * -sin(bounceAngle);
        
        return CGVectorMake(ballVx, ballVy)
    }
}
