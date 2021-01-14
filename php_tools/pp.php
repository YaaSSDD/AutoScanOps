<?php
$DynamicTarget = getenv("DYNAMIC_TARGET");
$path = "../rapport/rapport-nmap.txt";
$handle = @fopen($path, "r");
$i = 0;
$z = 0;
$CleanTab = array(); 
$pieces = array();
$pieces_lenght = 0;
$buffer;
//push buffer in pieces array
if ($handle) {
    while (($buffer = fgets($handle, 4096)) !== false) 
    {   
        //var_dump($buffer);
        $pieces = explode(" ", $buffer);
        $pieces_lenght = count($pieces);
        $point = $pieces_lenght - 1;
        //parse pieces array and push open port in Clean file 
        for($i = 0; $i <= $point; $i++)
        {
            if (preg_match("/\btcp\b/i", $pieces[$i])) 
            {       
                //echo "toto";
                $CleanTab[$z] = $pieces[$i];
                //var_dump($CleanTab);
                $i++;
                $z++;
            }
    $i++;
    }
    }
    //fgets failed($buffer);
    if (!feof($handle)) 
    {
        echo "Erreur: fgets() a échoué\n";
    }

}  

//section write json file for monitoring 
$port = "Open port : ".json_encode($CleanTab)."\n";
$fp = fopen('port.json', 'w');
fwrite($fp, $port);
fclose($fp);
//section write txt file
$comma_separated = implode("\r\n", $CleanTab);
file_put_contents('CleanNmap.txt', print_r($comma_separated, true));
?>