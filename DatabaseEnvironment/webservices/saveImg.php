<?php 
include('playthroughs.php');
$con=  mysql_connect("generichighscore.db.8574327.hostedresource.com","generichighscore","Sql@345678");

if(!$con)
{
	exit('My FAIL Response');
}else{
			saveScreenShot($GLOBALS[ 'HTTP_RAW_POST_DATA' ]);
	exit('stuff again');
}
exit('My Stuff');

?>