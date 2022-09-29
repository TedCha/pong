//
//  ScoreNode.swift
//  Pong
//
//  Created by Theodore Charts on 9/25/22.
//

import SpriteKit

class ScoreNode: SKLabelNode {
    let marginTop: CGFloat = 40
    let marginLeft: CGFloat = 80
    var side: Side
    var value: Int {
        didSet {
            self.text = "\(value)"
        }
    }
    
    init(_ side: Side) {
        self.value = 0
        self.side = side
        super.init()
        
        self.fontName = "Arial"
        self.color = .white
        self.fontSize = 60
        self.text = "0"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        self.value = 0
    }
    
    func setup() {
        guard let parentFrame = parent?.frame else { fatalError("node must have parent") }
        switch (side) {
        case .right:
            self.position = CGPointMake(parentFrame.midX + marginLeft, parentFrame.maxY - (fontSize + marginTop))
        case .left:
            self.position = CGPointMake(parentFrame.midX - marginLeft, parentFrame.maxY - (fontSize + marginTop))
        default:
            fatalError("node must be .left or .right")
        }
    }
    
    func increment() {
        self.value += 1
    }
}
