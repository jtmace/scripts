<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<style>
a {
    font-family: 'Do Hyeon', sans-serif;
    font-size: 100px;
    color: white;
}
body {
    background-color: black;
} 
</style>
</head>
<body>
<?php 
 
/* `sqlite3 sqlite.db`
   DROP TABLE services;
   CREATE TABLE services(
   ID	  	INT PRIMARY KEY 	NOT NULL,
   NAME	  	CHAR(50) 	 NOT NULL,
   LINK	  	CHAR(50) 	 NOT NULL
   );

   INSERT INTO services (ID,NAME,LINK) VALUES
     (1,'MotionEye','http://10.0.0.200:8765');
   INSERT INTO services (ID,NAME,LINK) VALUES
     (2,'Webmin','https://10.0.0.200:10000');
   ^d
*/

#ini_set('display_errors', 1);
#ini_set('display_startup_errors', 1);
#error_reporting(E_ALL);

class MyDB extends SQLite3 {
   function __construct() {
      $this->open('sqlite.db');
   }
}
$db = new MyDB();
if(!$db) {
   echo $db->lastErrorMsg();
} else {
   $sql = "SELECT * FROM services";
   $ret = $db->query($sql);
      while($row = $ret->fetchArray(SQLITE3_ASSOC) ) {
      echo "<p style=\"text-align:center\"><a href='". $row['LINK'] ."'>". $row['NAME'] ."</a><br>\n";
   }
}
?>
</body>
</html>
