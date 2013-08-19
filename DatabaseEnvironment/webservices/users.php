<?php
require_once('class.rc4crypt.php');
function updateUser($con, $name, $levelsUnlocked, $unlockedWeapons,$uid, $gears)
{
	//$exists = getUserById($con, $uid);
	if($levelsUnlocked>9){
	$levelsUnlocked=9;
	}
	$db_selected=mysql_select_db ('generichighscore', $con);
	$query = sprintf("UPDATE users SET name='%s', ".
	"levelsUnlocked = '%s', ".
	"gears = '%s', ".
	"unlockedWeapons  = '%s' WHERE uid = '%s'",
	mysql_real_escape_string($name),
	mysql_real_escape_string($levelsUnlocked),
	mysql_real_escape_string($gears),
	mysql_real_escape_string($unlockedWeapons),
	mysql_real_escape_string($uid));
	$resource=mysql_query($query, $con) or die(mysql_error());
	echo "1".$uid." ".$name." ".$levelsUnlocked." ".$unlockedWeapons;
}
function createUser($con, $email, $name, $key)
{
	$exists = getUserByEmail($con, $email, $key);
	if(!$exists)
	{
		$db_selected=mysql_select_db ('generichighscore', $con);
	$query = sprintf("INSERT INTO users (email, name) VALUES('%s', '%s')",
	mysql_real_escape_string($email),
	mysql_real_escape_string($name));
	$resource=mysql_query($query, $con) or die(mysql_error());
	echo getUserByEmail($con, $email, $key);
	//echo "Found user";
	}else{
	//echo "End of Method";
	echo bin2hex(rc4crypt::encrypt($key, "{-1}"));
	}
	
	//
}
function getUserById($con, $uid, $key)
{
$db_selected=mysql_select_db ('generichighscore', $con);
	$query = sprintf("SELECT * FROM users WHERE uid = '%s'",
	mysql_real_escape_string($uid));
	$result=mysql_query($query, $con) or die(mysql_error());
	$row=mysql_fetch_assoc($result);
	return bin2hex(rc4crypt::encrypt($key, json_encode($row)));
}
function getUserByEmail($con, $email, $key)
{
	$db_selected=mysql_select_db ('generichighscore', $con);
	$query = sprintf("SELECT * FROM users WHERE email = '%s'",
	mysql_real_escape_string($email));
	$result=mysql_query($query, $con) or die(mysql_error());
	$row=mysql_fetch_assoc($result);
	$JSONRow = json_encode($row);
	if($JSONRow=='false')
	{
	return;
}else{
return bin2hex(rc4crypt::encrypt($key,$JSONRow ));
}	
}
function login($con, $email, $key)
{
$user = getUserByEmail($con, $email, $key);
if(!$user)
{
echo bin2hex(rc4crypt::encrypt($key,"{-1}"));
}else{
echo $user;
}
}
function getRecent($con){
}
?>