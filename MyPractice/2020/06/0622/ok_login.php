<?php

   $account = $_GET["account"];
   $password = $_GET["password"];

   $f = fopen("/Users/john/my_data/member.txt", "r");

   $data = fread($f, 1000);

   fclose($f);

   $arr = explode("\n", $data);
   $is_member = 0;
   for($i = 0 ; $i < count($arr); $i++){
      
      $column = explode(",", $arr[$i]);

      if($column[1] == $account && $column[2] == $password){
         
         $is_member = 1;
         break;
      }else{
         
      }
      
    
   }
 
   print($is_member);
?>