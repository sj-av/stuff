<?php

if(!isset($argv[1])) die("Should pass a parameter\r\n");
$on = $argv[1] === 'on';

$search_line = 'xdebug';
$ini_path = '/opt/lampp/etc/php.ini';
// $ini_path = './php.ini';
if(!is_writable($ini_path)) die('File not writable: ' . $ini_path . "\r\n");
$lines = file($ini_path);
$line = '';
$index = null;
foreach($lines as $line_number => $line){
	if(strpos($line, $search_line) !== false){
		if($on) {
			$line = str_replace(';', '', $line);
		} else if (strpos($line, ';') === false){
			$line = ';' . $line;
		}
		$index = $line_number;
		break;
	}
}
if(!is_null($index)) {
	$lines[$index] = $line;
	echo $line . "\r\n";
	file_put_contents($ini_path, implode("", $lines));
}






