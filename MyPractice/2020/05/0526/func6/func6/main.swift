

func add(a:Int, b:Int) -> Int {
    return a + b
}


func add(a:Int, b:Int, c:Int) -> Int {
    return a + b + c
}


// <> =====> 在所有能處理"汎型"(Generic)的語言中,都用來表示<你想處理的型態>
// 例：如果我想處理Int ===> <Int>,如果我想處理String ===> <String>...

// 以下是"函數"的汎型
// 在宣告函數時候面加<隨便給個詞>就表示這個函數可以處理各種"型態"是個"汎型函數"
func vari<N>(members: N...){
   for i in members {
      print(i)
   }
}
