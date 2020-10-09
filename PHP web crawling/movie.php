<?php
$conn = sqlsrv_connect( "Server_Name", array( "Database"=>"movie")); //Change the Server_Name. Movie database must be created before running this file.
if( $conn ) {
     echo "Connection established.<br />";
}else{
     echo "Connection could not be established.<br />";
     die( print_r( sqlsrv_errors(), true));
}
$k=0;
 //The main program
for ($j=2010;$j<2015;$j++) {
$of = fopen("C:/xampp/htdocs/Project 1/movie ".$j.".html", 'w'); //A folder named Project 1 must be created in htdocs before running this file.
$url = fopen("http://boxofficemojo.com/yearly/chart/?page=1&view=releasedate&view2=domestic&yr=".$j."&p=.htm", 'r');
while (!feof($url)) {
	$urlr = fgets($url, 105000);
	fwrite($of, $urlr);
	}
fclose($url);
fclose($of);
echo "Web page ".$j." saved <br/>";


//Making cuts for each record
set_time_limit(6000000);
$file = "C:/xampp/htdocs/Project 1/movie ".$j.".html";
$read= fopen($file,'r');
	while (!feof($read))  {
		$line = fgets($read, 105000);
		
		if(preg_match('/close&order/',$line)) 
		$cuts = preg_split('/id=/',$line);
	}
$k++;	
//Parse the cuts and input in database	
for ($i=1;$i<=100;$i++)	
{
	$id= explode('.htm',$cuts[$i]);//explode breaks the string before each .htm. $id[0] contains the substring before the first encounter of .htm which is the movie id.
	$temp_name= preg_split('/.htm">/',$cuts[$i]);	//preg_split divides after the substring /.htm">/. $temp_name[1] contains the substring after the first encounter of /.htm">/.
	$name= explode('</a>',$temp_name[1]);	
	$temp_rev= preg_split('/size="2"><b>/',$cuts[$i]);
	$revenue_USDComma= explode('</b>',$temp_rev[1]);
	$revenue_USD=str_replace(',','',$revenue_USDComma[0]);
	$revenue=intval(str_replace('$','',$revenue_USD));
	$temp_theaters= preg_split('/td><td align="right"><font size="2">/',$cuts[$i]);
	$temp_no_theaters= explode('</font>',$temp_theaters[2]);
	$no_theaters=intval(str_replace(',','',$temp_no_theaters[0]));
	$rev_opwk_USDComma= explode('</font>',$temp_theaters[3]);
	$rev_opwk_USD=str_replace(',','',$rev_opwk_USDComma[0]);
	$rev_opwk=intval(str_replace('$','',$rev_opwk_USD));
	$temp_no_theaters_opwk= explode('</font>',$temp_theaters[4]);
	$no_theaters_opwk=intval(str_replace(',','',$temp_no_theaters_opwk[0]));
	$closing= explode('</font>',$temp_theaters[6]);
	if(preg_match("/-/",$closing[0])) {
		$cl_month = 0; $cl_date = 0;
		} else {
		$temp_closing = preg_split('#/#',$closing[0]);
		$cl_month = intval($temp_closing[0]);
		$cl_date = intval($temp_closing[1]);
		}
	
	if(preg_match('/studio=">/',$cuts[$i]))
		{ 
		  $temp_studio= preg_split('/studio=">/',$cuts[$i]);
		  $studio= explode('</a>', $temp_studio[1]);
		  $opening= explode('</a>',$temp_name[2]);
		} else 
		{
		  $studio= explode('</a>',$temp_name[2]);
		  $opening= explode('</a>',$temp_name[3]);
		}
	$temp_opening = preg_split('#/#',$opening[0]);
	$op_month = intval($temp_opening[0]);
	$op_date = intval($temp_opening[1]);
// Opening each movie page by ID
$of2 = fopen("C:/xampp/htdocs/Project 1/ID/".$id[0].".html", 'w'); //An empty folder named ID must be created in Project 1 before running this file.
$url2 = fopen("http://boxofficemojo.com/movies/?id=".$id[0].".htm", 'r');

while (!feof($url2)) {
	$urlr2 = fgets($url2, 1000);
	fwrite($of2, $urlr2);
	}
fclose($url2);
fclose($of2);

// Parsing each movie page
$file2 = "C:/xampp/htdocs/Project 1/ID/".$id[0].".html";
$read2= fopen($file2,'r');
	while (!feof($read2))  {
		$line2 = fgets($read2, 1000);
		
		if(preg_match('/Genre: <b>/',$line2))
			{
				$temp_genre = preg_split('/Genre: <b>/',$line2);
				$genre = preg_split('/</',$temp_genre[1]);
				$temp_mpaa = preg_split('/MPAA Rating: <b>/',$line2);
				$mpaa = preg_split('/</',$temp_mpaa[1]);
				$temp_budget = preg_split('/Production Budget: <b>/',$line2);
				$budget_USD = preg_split('/ /',$temp_budget[1]);
				if(preg_match("#N/A#",$budget_USD[0]))
					$budget= 0; else $budget = intval(str_replace('$','',$budget_USD[0]));
			}
		if(preg_match('/In Release:/',$line2))
			{
			 $nextline = fgets($read2, 100);
			 $temp_days = preg_split('/&nbsp;/',$nextline);
			 $days_char = preg_split('/ days/',$temp_days[1]);
			 $days = intval($days_char[0]);
			 break;
			}
	}
			
	echo "Count: <b/>".(($k-1)*100+$i)."</b><br/>";	
	echo "Movie ID: <b/>".$id[0]."</b><br/>";
	echo "Movie Name : <b/>".$name[0]."</b><br/>";
	echo "Production: <b/>".$studio[0]."</b><br/>";
	echo "Total Revenue: <b/>".$revenue."</b><br/>";
	echo "No. of Theaters: <b/>".$no_theaters."</b><br/>";
	echo "Revenue in opening weekend: <b/>".$rev_opwk."</b><br/>";
	echo "No. of Theaters in Opening weekend: <b/>".$no_theaters_opwk."</b><br/>";
	echo "Opening Month: <b/>".$op_month."</b><br/>";
	echo "Opening Date: <b/>".$op_date."</b><br/>";
	echo "Closing Month: <b/>".$cl_month."</b><br/>";
	echo "Closing Date: <b/>".$cl_date."</b><br/>";
	echo "Genre: <b/>".$genre[0]."</b><br/>";
	echo "MPAA: <b/>".$mpaa[0]."</b><br/>";
	echo "Budget: <b/>".$budget."</b><br/>";
	echo "Days: <b/>".$days."</b><br/>";
	echo "Release Year: <b/>".$j."</b><br/>";
	
	if(preg_match("/'/",$name[0]))
		$name[0]= preg_replace("/'/","''",$name[0]);
		
// Insert a row of information into the table "Facts"
sqlsrv_query($conn,"INSERT INTO Fact
(ID, MovieName, Production, Revenue, No_of_Theaters, Rev_OpWk, No_Theaters_OpWk, Budget, MPAA, Total_Days, Genre, Closing_Month, Closing_Date, Opening_Month, Opening_Date, Release_Year)
 VALUES('$id[0]', '$name[0]', '$studio[0]', $revenue, $no_theaters, $rev_opwk, $no_theaters_opwk, $budget, '$mpaa[0]', $days, '$genre[0]', $cl_month, $cl_date, $op_month, $op_date, $j)") 
or die(print_r( sqlsrv_errors(), true));

echo "<b/>Data of ".$id[0]." Inserted!</b> <br /><br />";
}
}
?>
