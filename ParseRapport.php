<?php

$DynamicTarget = getenv("DYNAMIC_TARGET");
$path = $DynamicTarget."/rapportNmap.txt";
$path2 = "pathFile.txt";

$handle = @fopen($path, "r");
$i = 0;
$z = 0;
$CleanTab = array(); 
$FinalTab = array();
$Y = 7;
$pieces = array();
$pieces_lenght = 0;
$buffer;
$MAC =array();


//push buffer in pieces array
if ($handle) {
    while (($buffer = fgets($handle, 4096)) !== false) 
    {	
    	var_dump($buffer);
		$pieces = explode(" ", $buffer);
        echo("O");
	}
    //ERROR
    if (!feof($handle)) 
    {
        echo "Erreur: fgets() a échoué\n";
    }

}
$pieces_lenght = count($pieces);
$point = $pieces_lenght - 1;


//parse pieces array and push open port in Clean file 
for($i = 0; $i <= $point; $i++)
	{
		if (preg_match("/\btcp\b/i", $pieces[$i])) 
		{	 	
		 	$CleanTab[$i] = $pieces[$i];
		 	var_dump($CleanTab[$i]);
 		}
 		/*elseif (preg_match("/\bMAC Address:\b/i", $pieces[$i])) 
		{
		 	$MAC[$i] = $pieces[$i];
 		}*/
 		else
   	$i++;
    }
   
$comma_separated = implode("\r\n", $CleanTab);
file_put_contents('CleanNmap.txt', print_r($comma_separated, true));

?>
