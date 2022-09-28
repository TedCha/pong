//
//  DividerNode.swift
//  Pong
//
//  Created by Theodore Charts on 9/25/22.
//

import SpriteKit

class DividerNode: SKShapeNode {
    override init() {
        super.init()
    }
    
    convenience init(from: CGPoint, to: CGPoint) {
        self.init()
        
        let shapePath = CGMutablePath()
        shapePath.move(to: from)
        shapePath.addLine(to: to)
        
        self.path = shapePath.copy(dashingWithPhase: 1, lengths: [25, 25])
        self.strokeColor = .white
        self.lineWidth = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
