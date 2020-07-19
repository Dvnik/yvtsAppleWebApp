import AVFoundation
class JLCat {
    
    var number: Int?
    var kind: String?
    var cost: Double?
    var player: AVAudioPlayer?
    
    func reportPrice(bossTellMe: Double) -> Double {
        let price: Double = bossTellMe * 10
        return price
    }
    
    func meow() {
        let meow:URL = URL(fileURLWithPath: "/Users/trixie/Desktop/iOS_practice/0519/Cute-cat-meowing-on-the-street.mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: meow)
            player?.play()
        }
        catch {
            print(error)
        }
        
    }
    
    func meow(sound:String) {
        let meow:URL = URL(fileURLWithPath: sound)
        
        do {
            player = try AVAudioPlayer(contentsOf: meow)
            player?.play()
        }
        catch {
            print(error)
        }
        
    }
    
}


var c1: JLCat = JLCat()

c1.number = 1
c1.kind = "波斯"
c1.cost = 6000.0

print("本店的第\(c1.number!)隻貓是\(c1.kind!)種的,成本\(c1.cost!)元")
print("老闆說要賣\(c1.reportPrice(bossTellMe: 8000.0))")

c1.meow()





