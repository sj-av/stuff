<?php

// example:
// php convert.php video.mp4 -fps 30 -vf transpose=1

// -vf transpose=1 - rotates video clock-wise
// -vf transpose=2 - rotates video counterclock-wise

define("CURRENT_PATH", getcwd());

if(count($argv) < 2){
	die("Video file name not passed in \r\n");
}

$default_fps = 30;
$fps = 0;
$vf = '';

if(in_array('-fps', $argv)){
	$index = array_search('-fps', $argv);
	$fps = (float)@$argv[$index + 1];	
}

if(in_array('-vf', $argv)){
	$index = array_search('-vf', $argv);
	$vf = '-vf "' . $argv[$index + 1] . '"';	
}

if(!$fps) $fps = $default_fps;

$file_full_name = $argv[1];

$path = CURRENT_PATH . "/" . $file_full_name;

if(!file_exists($path))  {
	die("File " . $file_full_name . " does not exist at path: " . $path . "\r\n");
}

$path_info = pathinfo($file_full_name);
$file_base_name = strtolower($path_info['filename']);
$ext = strtolower($path_info["extension"]);

$command = "ffmpeg -y -i \"{$path}\" {$vf} -r {$fps} \"" . CURRENT_PATH . "/" . $file_base_name . "_converted.{$ext}\"";

echo $command . "\r\n";

shell_exec($command);

die("Done \r\n");
