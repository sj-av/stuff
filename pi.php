<?php

if(!isset($argv[1])) die("Should pass a parameter\r\n");
$on = $argv[1] === 'on';

$search_line = 'xdebug';
$ini_path = '/etc/php/7.2/apache2/conf.d/20-xdebug.ini';
$reload_apache_command = 'sudo service apache2 restart';
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
} else {
	echo "Could not find search line '{$search_line}'\r\n";
}

exec($reload_apache_command, $out);
echo implode("\r\n", $out);






