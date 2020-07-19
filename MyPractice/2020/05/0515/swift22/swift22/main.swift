
import AVFoundation


// play music is also anther kind of ouput, just lick print
var spring: AVAudioPlayer // declare AVAudioPlayer variable to handle paly music
var music:URL

music = URL(fileURLWithPath: "/Users/yihsuan/Desktop/meme_song1.mp3")
do
{
    spring = try AVAudioPlayer(contentsOf: music)
    spring.play()
}
catch
{
    print("it's have somting wrong.")
    print("error message : \(error)")
}
var xxx = readLine()

print("========OVER======")
