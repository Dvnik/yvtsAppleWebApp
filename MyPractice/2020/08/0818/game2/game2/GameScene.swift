

import SpriteKit
import GameplayKit

//運算子重載 ====>operator overload
//重新定義運算子的行為
//語法：把要重新定義的運算子當成函數重寫

//重新定義 + 給"向量"用,因為向量可以看成平面座標上的"點"(起點在原點)
//所以以下皆以CPPoint來操作
// 為何寫在class外！！這表是要重新定義的+不是class運算子
func +(left: CGPoint, right: CGPoint) -> CGPoint
{
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
  func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
  }
#endif

//擴充CGPoint==>讓CGPoint有"向量"的操作
extension CGPoint
{
  func length() -> CGFloat
  {
    return sqrt(x*x + y*y)
  }
  
  func normalized() -> CGPoint
  {
    return self / length()
  }
}
//物理世界（讚）=====
struct PhysicsCategory
{
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let monster   : UInt32 = 0b1       // 1
  static let projectile: UInt32 = 0b10      // 2
}

class GameScene: SKScene
{

    // 1
    let player = SKSpriteNode(imageNamed: "cat")
    var step:CGFloat = 1
    
    var background:SKSpriteNode!
    var background2:SKSpriteNode!
    var projectile:SKSpriteNode!
    
    let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
    
    var monstersDestroyed = 0

    
    
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
    func addMonster()
    {
        // get dog wakls atlas
        let walks:SKTextureAtlas = SKTextureAtlas(named: "walks")
        var dog_walks:[SKTexture] = [SKTexture]()
        let numImages = walks.textureNames.count
        for i in 1...numImages
        {
            let dogTextureName = "walk\(i)"
            dog_walks.append(walks.textureNamed(dogTextureName))
        }
        
        // Create sprite
//        let monster = SKSpriteNode(imageNamed: "dog")
        let monster = SKSpriteNode(texture: dog_walks[0])
        
        //使monster接收容易的物理世界管轄
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
        monster.physicsBody?.isDynamic = true // 2
        monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4
//        monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        
        
        
        var animation:SKAction
        animation = SKAction.animate(with: dog_walks, timePerFrame: 0.1)
        let forver:SKAction = SKAction.repeatForever(animation)
        monster.run(forver)
        monster.scale(to: CGSize(width: -100, height: 100))
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/2, max: self.size.height - monster.size.height/2)
      
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: self.size.width - monster.size.width, y: actualY)
      
        // Add the monster to the scene
        addChild(monster)
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))

        // Create the actions
        //第一個動作
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY),
                                    duration: TimeInterval(actualDuration))
        //第二個動作
        let actionMoveDone = SKAction.removeFromParent()
        //可以有n個動作
        //組合連續動作
//        let ccc = SKAction.sequence([actionMove, actionMoveDone])
//        //執行連續動作
//        monster.run(ccc)
        //做一個會輸掉情況的Action
        let loseAction = SKAction.run() { [weak self] in
          guard let `self` = self else { return }
          let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
          let gameOverScene = GameOverScene(size: self.size, won: false)
          self.view?.presentScene(gameOverScene, transition: reveal)
        }
        monster.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))

    }
    
    //相當於viewdidload
    override func didMove(to view: SKView)
    {
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
        
        
        //背景
        background = SKSpriteNode(imageNamed: "space")// 建立第一張
        background2 = SKSpriteNode(imageNamed: "space")// 建立第二張
        
        background.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)// 第一張開始停在畫面正中間
        background2.position = CGPoint(x: self.size.width + self.size.width * 0.5, y: self.size.height * 0.5)// 第二張一開始停在右邊(貼齊畫面右端)
        
//        background.scale(to: CGSize(width: self.size.width, height: self.size.height))
        background.size = self.frame.size // 第一張大小與畫面一樣
        background2.size = self.frame.size// 第二張大小與畫面一樣
        // 加入Scene
        self.addChild(background)
        self.addChild(background2)
        //以下設計兩張背景的捲動行為
        //背景1先移動到左邊邊緣
        let scroll_bg:SKAction = SKAction.move(to: CGPoint(x: -self.frame.width/2, y: background.position.y), duration: 8)
        //然後馬上班搬到右端
        let set_to_right:SKAction = SKAction.move(to: CGPoint(x: self.frame.width + self.frame.width/2, y: background.position.y), duration: 0)
        // 然後移到畫面正中
        let bg_move_to_center:SKAction = SKAction.move(to: CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5), duration: 8)
        //以上的動作要連續做
        let ccc:SKAction = SKAction.sequence([scroll_bg, set_to_right, bg_move_to_center])
        // 而且要不停地做
        let scroll_forver:SKAction = SKAction.repeatForever(ccc)
        background.run(scroll_forver)
        
        //背景2要先移動到畫面正中（動作不必重新寫，拿上面的來用）
        //剩下的動作就與背景1一致
        background2.run(SKAction.sequence([bg_move_to_center, scroll_forver]))
        
        
        // 2
        self.backgroundColor = SKColor.white
        // 3
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        // 4
        player.scale(to: CGSize(width: 100, height: 100))
        self.addChild(player)
        
        self.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
        //播放音樂
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
    }
    

    //MARK: - touch Event
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
//        projectile = SKSpriteNode(imageNamed: "projectile")
//        projectile.position = CGPoint(x: player.position.x + 10, y: player.position.y - 25)
//        self.addChild(projectile)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
     
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        /*
        var finger:CGPoint
        for t in touches
        {
            finger = t.location(in: self)
            print(finger)
            projectile.run(
            SKAction.sequence([
                SKAction.move(to: finger, duration: 1),
                SKAction.removeFromParent()
            ]))
            
        }
        */
        
        // 1 - Choose one of the touches to work with
        guard let touch = touches.first else {
          return
        }
        
        run(SKAction.playSoundFileNamed("pew-pew-lei.caf", waitForCompletion: false))
        let touchLocation = touch.location(in: self)
        // 2 - Set up initial location of projectile
        let projectile = SKSpriteNode(imageNamed: "projectile")
        
        projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        
        
        projectile.position = player.position
        // 3 原點到飛鏢是一個向量->projectile.position, 原點到手指觸摸放開處是一個向量->touchLocation
        // 手指觸處向量 減去 飛鏢向量（因為剪髮我已經重載了,所以編譯器不會說兩個相減不合法） --->得到"飛鏢到手指觸點"向量 -> offset
        // 3 - Determine offset of location to projectile
        let offset = touchLocation - projectile.position
        // 4 不能往後發飛鏢
        // 4 - Bail out if you are shooting down or backwards
        if offset.x < 0 { return }
        
        // 5 飛鏢上手
        // 5 - OK to add now - you've double checked position
        addChild(projectile)
        
        // 6 用上面的一番準備，算出"飛鏢到手指觸點"向量的"單位向量"
        // 6 - Get the direction of where to shoot
        let direction = offset.normalized()
        
        // 7 如此一來！不論點哪，算出的單位向量大小都一樣了（只是方向不同）
        // 7 - Make it shoot far enough to be guaranteed off screen
        let shootAmount = direction * 1000// 用單位向量乘 1000 ===> 不論點哪,就方向不同,飛行距離都是1000個單位
        
        // 8 利用向量加法把飛鏢的位置加上要加的1000單位，的到飛鏢要去的"點"(向量)
        // 8 - Add the shoot amount to the current position
        let realDest = shootAmount + projectile.position
        
        // 9 - 做動作
        // 9 - Create the actions
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
    }
    
    //MARK: - LifeCycle
    override func update(_ currentTime: TimeInterval) {
//        step -= 1
//        player.position = CGPoint(x: size.width * 0.1 + step, y: size.height * 0.5)
//        background.position = CGPoint(x: size.width * 0.5 + step, y: size.height * 0.5)
    }
}


extension GameScene: SKPhysicsContactDelegate
{
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
      print("Hit")
      projectile.removeFromParent()
      monster.removeFromParent()
        monstersDestroyed += 1
        if monstersDestroyed > 30 {
          let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
          let gameOverScene = GameOverScene(size: self.size, won: true)
          view?.presentScene(gameOverScene, transition: reveal)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
      // 1
      var firstBody: SKPhysicsBody
      var secondBody: SKPhysicsBody
      if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
        firstBody = contact.bodyA//monster
        secondBody = contact.bodyB// projectile
      } else {
        firstBody = contact.bodyB//monster
        secondBody = contact.bodyA// projectile
      }
     
      // 2
      if ((firstBody.categoryBitMask & PhysicsCategory.monster != 0) &&
          (secondBody.categoryBitMask & PhysicsCategory.projectile != 0)) {
        if let monster = firstBody.node as? SKSpriteNode,
          let projectile = secondBody.node as? SKSpriteNode {
          projectileDidCollideWithMonster(projectile: projectile, monster: monster)
        }
      }
    }

}
