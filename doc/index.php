<?php
$isWin = strtoupper(substr(PHP_OS, 0, 3)) === 'WIN';

//Mapping Markdown File List
$files = array();
foreach (glob("*.md") as $filename) {
	if($isWin)$filename = iconv("GBK","UTF-8", $filename);
	array_unshift($files, $filename);
};
$data = array(
	"files"=>$files
);
if(isset($_GET["f"])){
	$data["markdown"] = $_GET["f"];
}

?>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<script src="http://oss.ibg.com/weblib/pack.js.php"></script>
	<style type="text/less">  
	#mdlist {
		body,p,li { font-family:"Open Sans",Arial; }
		h1,h2,h3,h4,h5,h6 { font-family:"Open Sans","微软雅黑";}  
	}
	</style>

	<script> 
		require(["bootstrap3","font/Open Sans","coffee","less"]); 
		define("data",<?=json_encode($data)?>);
	</script>

	<script type="text/coffeescript" src="index.coffee"></script>
	<title> Markdowns </title>
</head>
<body id="mdlist">
	<br>
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<br>
				<div id="mdList" class="list-group">
				</div>
			</div>
			<div class="col-md-9">
				<div id="mdContent">
					
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>