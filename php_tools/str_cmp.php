<?php
$path = "../ipTmp.txt";
$handle = @fopen($path, "r");
$Npath = "../ip.txt";
$NewHandle = @fopen($path, "r");
$i = 0;
$CleanTab = array(); 
$FinalTab = array();
if ($handle) {
    while (($buffer = fgets($handle, 4096)) !== false) {
		$CleanTab[$i] = $buffer;
		$FinalTab = array_unique($CleanTab);
   		$i++;
    }
    if (!feof($handle)) {
        echo "Erreur: fgets() a échoué\n";
    }
    fclose($handle);
	$comma_separated = implode("", $FinalTab);
//print final contents in file ip.txt for catch with nmap
    file_put_contents('../ip.txt', print_r($comma_separated, true));
}
?>
