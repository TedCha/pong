//
//  GameScene.swift
//  Pong
//
//  Created by Theodore Charts on 9/23/22.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let ball         : UInt32 = 0x1 << 1
    static let paddle       : UInt32 = 0x1 << 2
    static let boundry      : UInt32 = 0x1 << 3
}

enum Side {
    case none, right, left
}

enum GameState {
    case stopped, started, gameOver
}

let maxScore = 11

class GameScene: SKScene, SKPhysicsContactDelegate {
    var state = GameState.gameOver
    var rightPaddle = PaddleNode(.right)
    var leftPaddle = PaddleNode(.left)
    var rightScore = ScoreNode(.right)
    var leftScore = ScoreNode(.left)
    var ball = BallNode()
    
    func setupPhysics() {
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func setupScene() {
        backgroundColor = .black
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // contact must include ball and a paddle
        guard contact.bodyA.categoryBitMask == PhysicsCategory.paddle,
              contact.bodyB.categoryBitMask == PhysicsCategory.ball
        else { return }
        
        if let paddle = contact.bodyA.node as? PaddleNode {
            let vector = paddle.getContactReflectionVector(atContactPoint: contact.contactPoint)
            ball.setVelocity(vector)
        }
    }
    
    override func didMove(to view: SKView) {
        setupScene()
        setupPhysics()

        addChild(DividerNode(
            from: CGPointMake(frame.midX, frame.minY),
            to: CGPointMake(frame.midX, frame.maxY)
        ))
        
        addChild(BoundryNode(
            from: CGPointMake(frame.minX, frame.maxY),
            to: CGPointMake(frame.maxX, frame.maxY)
        ))
        
        addChild(BoundryNode(
            from: CGPointMake(frame.minX, frame.minY),
            to: CGPointMake(frame.maxX, frame.minY)
        ))
        
        addChild(ball)
        ball.setup()
        
        addChild(rightPaddle)
        rightPaddle.setup()
        
        addChild(leftPaddle)
        leftPaddle.setup()
        
        addChild(rightScore)
        rightScore.setup()
        
        addChild(leftScore)
        leftScore.setup()
        
        reset()
    }
    
    func reset() {
        print("Game Reset") // TODO: Remove gameOverLabel
        rightScore.reset()
        leftScore.reset()
        ball.reset()
        stop()
    }
    
    func start() {
        state = .started
        ball.serve()
    }
    
    func stop() {
        state = .stopped
        ball.stop()
    }
    
    func gameOver() {
        state = .gameOver
        print("Game Over") // TODO: Add gameOverLabel
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .stopped {
            start()
        } else if state == .gameOver {
            reset()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let scene = scene {
            let touchLocation = touch.location(in: scene)
            rightPaddle.position.y = touchLocation.y;
        }
    }

    override func update(_ currentTime: TimeInterval) {
        let side = ball.getSide()
        if side != .none {
            stop()
            ball.setup()
            
            let targetScore = side == .right ? leftScore : rightScore
            targetScore.increment()
            
            if targetScore.value == maxScore {
                gameOver()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.start()
                }
            }
        }
    }
}
