<?php 
include('users.php');
include('playthroughs.php');
require_once('class.rc4crypt.php');
$con=  mysql_connect("generichighscore.db.8574327.hostedresource.com","generichighscore","Sql@345678");
$key =  "0011001101000111011100001111100100101000011000010110100001001";
/*$decrypted = rc4crypt::decrypt($key, pack("H*", $_POST["postData"]));
$JSONObj = json_decode($decrypted);
exit($JSONObj->action);*/
$postData = json_decode(rc4crypt::decrypt($key, pack("H*", $_POST["postData"])));
if(!$con)
{
echo 'My FAIL Response';
}else{
	switch($postData->action)
	{
		case 'get-user-by-id':
		getUserById();
			break;
		case 'get-user-by-email':
			getUserByEmail($con, $postData->email, $key);
			break;
			case 'login':
			login($con, $postData->email, $key);
			break;
		case'create-user':
			createUser($con, $postData->email, $postData->name, $key);
			break;
		case 'get-recent-users':
			getRecentUsers($conn);
			break;
				case 'update-user':
			updateUser($con, $postData->name, $postData->levelsUnlocked, $postData->unlockedWeapons, $postData->uid, $postData->gears);
			break;
			case'add-playthrough':
			addPlaythrough($con, $postData->userId, $postData->level, $postData->loadOut, $postData->score,$postData->replay,$postData->enemiesKilled,$postData->accuracy,$postData->gearsCollected, $postData->imgData);
			break;
			case'get-high-score':
			getHighScore($con, $postData->level,$key);
			break;
			case'get-user-high-score':
			getUserHighScore($con, $postData->level,$postData->user,$key);
			break;
			case 'add-raw':
			saveScreenShot($GLOBALS[ 'HTTP_RAW_POST_DATA' ]);
		default:
			echo 'no action taken';
	}
}
exit();

?>