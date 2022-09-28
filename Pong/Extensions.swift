//
//  Extensions.swift
//  Pong
//
//  Created by Theodore Charts on 9/25/22.
//

import Foundation
import SpriteKit

extension CGFloat {
    func degreesToRadians() -> CGFloat {
        return self * CGFloat.pi / 180
    }
}

// https://app-o-mat.com/article/sprite-kit/physics-body
extension SKPhysicsBody {
    /// Makes the physics body an ideal object without friction or drag
    /// or energy losses due to collisions
    /// - returns: self, but with body set up to be ideal. Useful for chaining.
    func ideal() -> SKPhysicsBody {
        self.friction = 0
        self.linearDamping = 0
        self.angularDamping = 0
        self.restitution = 1
        return self
    }

    /// Makes the physics body ignore forces, but still participate in
    /// collisions. Useful for walls. You can still manually move it
    /// in your update function or in response to taps.
    /// - returns: self, but with body set up to be manually moved. Useful for chaining.
    func manualMovement() -> SKPhysicsBody {
        self.isDynamic = false
        self.allowsRotation = false
        self.affectedByGravity = false
        return self
    }
}
