<?php
//$iv_size = mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_CBC); //get vector size on CBC mode 
   // $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);  
//echo $_POST["iv"];
require_once('class.rc4crypt.php');
echo decrypt($_POST["key"],$_POST["msg"]);
function decrypt($key, $encrypted)
{
/*$mcrypt_cipher = MCRYPT_RIJNDAEL_256;
$mcrypt_mode = MCRYPT_MODE_CBC;
    $decrypted = rtrim(mcrypt_decrypt($mcrypt_cipher, $key, $encrypted, $mcrypt_mode, $iv), "\0");
    return $decrypted;*/
		//$d = rc4crypt::encrypt("0x000000", "HelloWorld", 1);
		$mydata = pack("H*", $encrypted); //when getting data from flash. 
		//$datatopass = bin2hex($myencrypteddata); //when sending data back to flash
$d = rc4crypt::decrypt($key, $mydata); // Assuming the key is binary (what you typed)

	//$d = rc4crypt::decrypt($key, $encrypted, 1); // Assuming the key is binary (what you typed)
	return $d;
}
 ?>