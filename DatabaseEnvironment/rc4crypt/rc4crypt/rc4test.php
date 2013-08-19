<?php

	/* vim: set expandtab shiftwidth=4 softtabstop=4 tabstop=4: */

	/**
	 * RC4Crypt 3.2
	 *
	 * RC4Crypt is a petite library that allows you to use RC4
	 * encryption easily in PHP. It's OO and can produce outputs
	 * in binary and hex.
	 *
	 * (C) Copyright 2006 Mukul Sabharwal [http://mjsabby.com]
	 *     All Rights Reserved
	 *
	 * @link http://rc4crypt.devhome.org
	 * @author Mukul Sabharwal <mjsabby@gmail.com>
	 * @version $Id: rc4test.php,v 3.2 2006/03/10 05:49:58 mukul Exp $
	 * @copyright Copyright &copy; 2006 Mukul Sabharwal
	 * @license http://www.gnu.org/copyleft/gpl.html
	 * @package RC4Crypt
	 */

	require_once('./class.rc4crypt.php');
	if (strcmp('4.1.0', phpversion()) > 0) {
		global $HTTP_GET_VARS;
		$_GET = &$HTTP_GET_VARS;
	}

	$pwd = $_GET['pwd'];
	$data = $_GET['data'];

	if (get_magic_quotes_gpc()) {
		$pwd = stripslashes($pwd);
		$data = stripslashes($data);
	}

	// The real part, keys are encouraged to be hexadecimal
	// though they don't need to be.
	$eHex = rc4crypt::encrypt($pwd, $data, 1); // Assuming the key is hexadecimal
	$dHex = rc4crypt::decrypt($pwd, $eHex, 1); // Assuming the key is hexadecimal

	$e = rc4crypt::encrypt($pwd, $data); // Assuming the key is binary (what you typed)
	$d = rc4crypt::decrypt($pwd, $e); // Assuming the key is binary (what you typed)

	echo "Original Data : $data<br/>";

	echo "Encrypted Data (using Hex Key) : " . bin2hex($eHex) . "<br/>";
	echo "Decrypted Data (using Hex Key) : $dHex<br/>";

	echo "<br/>";

	echo "Encrypted Data (using Key as is) : " . bin2hex($e) . "<br/>";
	echo "Decrypted Data (using Key as is) : $d";
?>