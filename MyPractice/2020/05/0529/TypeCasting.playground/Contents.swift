import UIKit

/*
型別轉換（Type Casting）是一種檢查"型別實體"的方式，或是把"實體"當成它的父類別或子類別來處理的一種方式。
『型別轉換』在Swift中使用is和as運算子實作。
這兩個運算子提供了一種簡單達意的方式去檢查值的型別，或者轉換它的型別。
你也可以用『型別轉換』來檢查一個類別是否實作了某個協定。
*/

//===========定義一個用於『型別轉換』的類別階層（Defining a Class Hierarchy for Type Casting）===========
//『型別轉換』可以用於類別和子類別的階層架構上，檢查特定類別實體的型別，並且轉換這個類別實體的型別成為這個階層架構中的其他型別。

//----以下三段程式碼定義了一個類別階層，和一個包含了幾個這些類別實體的陣列，作為『型別轉換』的範例。----

//第一段程式碼定義了一個新的基礎類別MediaItem。這個類別為任何出現在數位媒體函式庫（digital media library）的媒體項目提供基礎功能。（它假定所有的媒體項都有個名稱）

//媒體項目類別
class MediaItem
{
    //媒體項目名稱
    var name: String
    //所有媒體項目的名稱在初始化時提供
    init(name: String)
    {
        self.name = name
    }
}

//下一個程式碼段定義了MediaItem的兩個子類別。第一個子類別Movie，在父類別（或者說基礎類別）的基礎上增加了一個 director（導演） 屬性，和對應的初始化方法。第二個類別在父類別的基礎上增加了一個 artist（作者） 屬性，和對應的初始化方法：

//電影類別，繼承自媒體項目類別
class Movie: MediaItem
{
    //導演
    var director: String
    // 媒體項目名稱（繼承自父類別MediaItem）
    // var name: String // 當作電影名稱使用

    init(name: String, director: String)
    {
        // Step1.自己的屬性設定初值
        self.director = director
        // Step2. 父類別的屬性設定初值
        super.init(name: name)  //呼叫父類別初始化方法
        // Step3. 在初始化完成的最後階段，可以進一步修改屬性值
        //--------可以省略--------
    }
}

//歌曲類別，繼承自媒體項目類別
class Song: MediaItem
{
    //作者
    var artist: String
    // 媒體項目名稱（繼承自父類別MediaItem）
    // var name: String // 當作歌曲名稱使用

    init(name: String, artist: String)
    {
        // Step1.自己的屬性設定初值
        self.artist = artist
        // Step2. 父類別的屬性設定初值
        super.init(name: name)  //呼叫父類別初始化方法
        // Step3. 在初始化完成的最後階段，可以進一步修改屬性值
        //--------可以省略--------
    }
}


//宣告陣列常數，包含兩個Movie實體和三個Song實體（注意：陣列元素的型別，被推斷為共同的基礎類別MediaItem）
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

/*
library的型別是在它被初始化時根據它陣列中所包含的內容推斷來的。
Swift的型別檢測器能夠推測出Movie和Song有共同的父類別MediaItem，所以它推斷[MediaItem]類別作為library的型別。
在背景運作時，library裡儲存的媒體項目依然是Movie和Song型別，但是如果逐一取出陣列元素，取出的實體會是MediaItem型別，而不是Movie和Song型別。
為了讓他們以原來的型別工作，你需要檢查他們的型別，或"向下轉換"（downcast）他們的型別到其他型別。
*/


//======================檢查型別（Checking Type）======================
/*
用"『型別轉換』運算子"（is）來檢查一個實體是否屬於特定的『子型別』（subclass type）。
若實體屬於那個『子型別』，『型別轉換』運算子is回傳true，否則回傳false。
*/

//下面的範例定義了兩個變數，movieCount和songCount，用來計算陣列library中Movie和Song型別的實體數量：
var movieCount = 0      //Movie型別所產生的實體數量
var songCount = 0       //Song型別所產生的實體數量

//以迴圈列出所有陣列元素
for item in library
{
    //檢查陣列元素中的實體是否屬於Movie子型別所配置出來的型別實體
    if item is Movie
    {
        movieCount += 1
    }
    //檢查陣列元素中的實體是否屬於Song子型別
    else if item is Song
    {
        songCount += 1
    }
}
print("媒體資料庫包含了\(movieCount)部電影與\(songCount)首歌")


//======================向下轉型（Downcasting）======================
/*
一個特定型別的常數或變數，在背景運作時，可能實際上屬於一個"子類別的實體"。
因此你可以嘗試使用"型別轉換運算子"（as?或者as!）將它們『向下轉型』到它們的子型別，

因為向下轉型可能會失敗，"型別轉型運算子"帶有兩種不同形式：
1.條件形式（conditional form）as? 回傳一個你試圖向下轉換之型別的"選擇值"（optional value）。
2.強制形式（forced form     ）as! 把試圖『向下轉型』和『強制拆封』的結果混合成單一作業（a single compound action）。

當你不確定『向下轉型』可以成功時，用『型別轉換』的"條件形式"（as?）。
條件形式的『型別轉換』總是回傳一個"選擇值"，如果『向下轉型』無法達成，"選擇值"將是nil。
這樣讓你能夠檢查『向下轉型』是否成功。

只有你可以確定『向下轉型』一定會成功時，才使用"強制形式"（as!）。
當你試圖『向下轉型』為一個不正確的型別時，"強制形式"的『型別轉換』會觸發一個執行時期錯誤。
*/

/*
下面的範例，取出library裡的每一個MediaItem，並列印出適當的描述。
要這樣做，item需要真正作為Movie或Song的型別來使用，而不僅僅是作為MediaItem。
為了能夠使用Movie或Song的director或artist屬性，這是必要的。

在這個範例中，陣列中的每一個item可能是Movie或Song。
事前你不知道每個item的真實型別，所以這裡使用"條件形式"的『型別轉換』（as?）去檢查迴圈裡每次的『向下轉型』。
*/
/*
 let library = [
     Movie(name: "Casablanca", director: "Michael Curtiz"),
     Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
     Movie(name: "Citizen Kane", director: "Orson Welles"),
     Song(name: "The One And Only", artist: "Chesney Hawkes"),
     Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
 ]
 **/

for item in library
{
    if let movie = item as? Movie   //如果成功轉型成Movie型別
    {
        print("Movie: \(movie.name), dir. \(movie.director)")   //印出電影名稱和導演名稱
    }
    else if let song = item as? Song       //如果成功轉型成Song型別
    {
        print("Song: \(song.name), by \(song.artist)")          //印出歌曲名稱和作者名稱
    }
}

/*
注意：
『轉型』（Casting）沒有真的改變實體或變更它的值。
根本的實體保持不變，只是簡單地把它當作被轉換成的類別來看待與存取。
*/

//========Any和AnyObject的型別轉換（Type Casting for Any and AnyObject）========
/*
Swift為不確定型別（non-specific types）提供了兩種『特殊的型別別名』（special type aliases）：
● Any可以表示"任意型別"，包含『函式型別』（function types）。
● AnyObject可以代表任何"類別型別"的實體。

注意：
只有當你明確需要它的行為和功能時，才使用Any和AnyObject。
在你的程式碼裡，使用你所期望的明確型別總是更好的。
*/
//Any代用型別，只能使用明確指定型別的語法宣告
let myArray:[Any] = ["abc", 34, 56.88]
// 注意：當取得的元素為任意型別的實體時，不可以直接使用，必須完成精確轉型
if let arr = myArray[0] as? String
{
    arr.hasPrefix("a")
}

if let arr = myArray[1] as? Float
{
    arr.magnitude
}
else
{
    print("轉換不成功！")
    if let narr = myArray[1] as? Int
    {
        narr.hashValue
    }
}
