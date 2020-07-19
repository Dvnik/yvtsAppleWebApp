
struct studrecord {
   let stname: String
   init?(stname: String) {
      if stname.isEmpty {return nil }
      self.stname = stname
   }
}
let stmark = studrecord(stname: "Swing")

if let name = stmark {
   print("Student name is \(name)")
}
let blankname = studrecord(stname: "")

if blankname == nil {
   print("Student name is left blank")
}
