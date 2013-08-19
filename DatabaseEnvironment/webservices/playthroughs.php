<?php
require_once('class.rc4crypt.php');
function addPlaythrough($con, $userId,$level, $loadOut, $score,$replay,$enemiesKilled, $accuracy,$gearsCollected, $imgData){
	$db_selected=mysql_select_db ('generichighscore', $con);
	
	$photoId=saveScreenShot(base64_decode($imgData));
	
	$query1 =  sprintf("INSERT INTO levelPlaythroughs (user, loadOut, score, photoId,replay,enemiesKilled, accuracy, gearsCollected, level) VALUES('%s','%s','%s','%s','%s','%s','%s','%s','%s')",
	mysql_real_escape_string($userId),
	mysql_real_escape_string($loadOut),
	mysql_real_escape_string($score),
	mysql_real_escape_string($photoId),
	mysql_real_escape_string($replay),
	mysql_real_escape_string($enemiesKilled),
	mysql_real_escape_string($accuracy),
	mysql_real_escape_string($gearsCollected),
	mysql_real_escape_string($level));

	mysql_query($query1, $con) or die(mysql_error());
	
	$playthroughId=mysql_insert_id();

	$query2 =  sprintf("INSERT INTO level".$level."Playthroughs (playthroughId) VALUES('%s')",
	mysql_real_escape_string($playthroughId));

	$result=mysql_query($query2, $con) or die(mysql_error());
	
	echo "1|Playthrough recorded!|";
}
function getHighScore($con, $level,$key, $indexStart=0,$resultSize=10)
{
	$db_selected=mysql_select_db ('generichighscore', $con);
	$query =  sprintf("SELECT level".$level."View.date, MAX(level".$level."View.score), level".$level."View.loadOut,level".$level."View.user,level".$level."View.photoId,level".$level."View.enemiesKilled,level".$level."View.accuracy,level".$level."View.gearsCollected, users.name FROM level".$level."View LEFT JOIN users ON level".$level."View.user = users.uid WHERE level".$level."View.replay = 0 GROUP BY user ORDER BY MAX(score) DESC LIMIT ".$indexStart.", ".$resultSize);

	$result = mysql_query($query, $con) or die(mysql_error());
	$exitResult;
	while ($row = mysql_fetch_assoc($result)) 
	{
		$row['place']=count($exitResult);
		$row['score']=$row['MAX(level'.$level.'View.score)'];
		$exitResult[count($exitResult)]=$row;
	}
	
	echo bin2hex(rc4crypt::encrypt($key, json_encode($exitResult)));
}
function getAllScore($con, $level,$key)
{
	$db_selected=mysql_select_db ('generichighscore', $con);
	$query =  sprintf("SELECT level".$level."View.date, MAX(level".$level."View.score), level".$level."View.loadOut, users.name FROM level".$level."View LEFT JOIN users ON level".$level."View.user = users.uid GROUP BY user ORDER BY score DESC");

	$result = mysql_query($query, $con) or die(mysql_error());
	$exitResult;
	while ($row = mysql_fetch_assoc($result)) 
	{
		$row['place']=count($exitResult);
		$row['score']=$row['MAX(level'.$level.'View.score)'];
		$exitResult[count($exitResult)]=$row;
	}
	echo bin2hex(rc4crypt::encrypt($key, json_encode($exitResult)));
}
function getUserHighScore($con, $level, $user,$key,$resultSize=10)
{
	$db_selected=mysql_select_db ('generichighscore', $con);
	//$query =  sprintf("CREATE VIEW playthroughs AS ".
	//"SELECT levelPlaythroughs.date, levelPlaythroughs.score, levelPlaythroughs.loadOut, levelPlaythroughs.user FROM level".$level."Playthroughs LEFT JOIN levelPlaythroughs ON level".$level."Playthroughs.playthroughId = levelPlaythroughs.uid ORDER BY score DESC");
	//$result = mysql_query($query, $con) or die(mysql_error());
	$query =  sprintf("SELECT level".$level."View.date, MAX(level".$level."View.score), level".$level."View.loadOut,level".$level."View.user,level".$level."View.photoId,level".$level."View.enemiesKilled,level".$level."View.accuracy,level".$level."View.gearsCollected, users.name FROM level".$level."View LEFT JOIN users ON level".$level."View.user = users.uid WHERE level".$level."View.replay = 0 GROUP BY user ORDER BY MAX(score) DESC");
	$result = mysql_query($query, $con) or die(mysql_error());
	
	$exitResult;
	$resultArray;
	$userRow;
	$top=0;
	$bottom=0;
	
	while ($row = mysql_fetch_assoc($result)) 
	{
		$row['place']=count($resultArray);
		
		$row['score']=$row['MAX(level'.$level.'View.score)'];
		if($row['user']==$user)
		{
			
			//if I have found the user I am looking for, record his row. 
			$userRow=count($resultArray);
		}else if(!$userRow)
		{
			//the current row is NOT the search key, AND we have NOT found him already. 
			$bottom=count($resultArray);
		}else if($bottom-$userRow<$resultSize/2)
		{
			//the current row is NOT the search key, BUT we have in fact found him already. 
			//
			$bottom=count($resultArray);
			
			if($bottom>$resultSize)
			{
				$top=$bottom-$resultSize;
				
			}else{
				$top=0;
			}
		}else if($bottom-$top<$resultSize){
			$bottom=count($resultArray);
		}
		$resultArray[count($resultArray)]=$row;
	}
	if(count($resultArray)<=10)
	{
	$bottom=count($resultArray);

	}
	for($i=$top;$i<$bottom;$i++)
	{
		$exitResult[count($exitResult)] = $resultArray[$i];
	}

	echo bin2hex(rc4crypt::encrypt($key, json_encode($exitResult)));
}
function saveScreenShot($data)
{
	$id=uniqid();
	$img = fopen('../img/'.$id.'.jpg','wb');
	fwrite($img,$data);
	fclose($img);
	return $id;
}
?>