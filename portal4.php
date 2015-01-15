<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<script src="/weblib/pack.js.php"></script>
	<script> require(["bootstrap","less","coffee","font/Open Sans"]); </script>
	<style type="text/less">
		#side {margin-top:-30px;}
		#footer {background:hsl(210,80%,90%);}

		#oss4 {
			.brand {font-weight:600;}
			font-family: "Open Sans"; font-size:15px;
			.alert {border-radius:0;
				background:hsl(45,100%,90%);
				&.alert-info { background:hsl(200,100%,90%) }
				padding:0 8px 8px;
				h2,h3,h4 {
					font-weight:400;
					font:400 2em/1.6em "Open Sans";
					margin:0 -8px 8px*1.5;padding:8px*0.5 8px;
					color:#333;
					background:hsla(0,0%,100%,0.4);
					border-bottom:1px solid hsla(0,0%,0%,0.15);
				}
			}

		}
	</style>
	<title> Tmpl </title>
</head>
<body id="oss4">
	<div class="navbar navbar-static-top">
		<div class="navbar-inner">
			<div class="container">
				<a href="" class="brand">Hey</a>
			</div>
		</div>
	</div>
	<!-- Container -->
	<div class="container">
		<div class="row">
			<div class="span9">
				<br>
				<div class="alert alert-danger">
					<a href="" class="btn btn-link pull-right">Close</a>
					Hello World
				</div>
				<div class="row-fluid">
					<div class="span6">
						<div class="alert">
							<h3>Infomation</h3>
							Infomation
							<br>Infomation
							<br>Infomation
							<br>
							<br>Infomation
							<br>Infomation
							<br>
						</div>
					</div>
					<div class="span6">
						<div class="alert">
							<h3>Infomation</h3>
							<br>Infomation
							<br>Infomation
							<br>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span6">
						<div class="alert">
							<h3>Infomation</h3>
							Infomation
							<br>Infomation
							<br>Infomation
							<br>
						</div>
					</div>
					<div class="span6">
						<div class="alert">
							<h3>Infomation</h3>
							Infomation
							<br>Infomation
							<br>Infomation
							<br>Infomation
							<br>Infomation
							<br>
						</div>
					</div>
				</div>
			</div>
			<div class="span3">
				<div id="side" class="alert alert-info">
					<div class="side-section" id="personal">
						<h3 class="side-heading">Title</h3>
						<p class="lead">Welcome</p>
						Personal Infomation
					</div>
					<br>
					<div class="side-section" id="fav">
						<h3 class="side-heading">Title</h3>
						<ul class="nav nav-stacked">
							<li><a href=""> <i class="icon-star"></i> 收藏 </a></li>
							<li><a href=""> <i class="icon-star"></i> 收藏 </a></li>
							<li><a href=""> <i class="icon-star"></i> 收藏 </a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end container -->

	<div id="footer" class="footer">
		<div class="container">
			<div class="row">
				<div class="span3">
					<br>
					
					<img style="width:300px;height:180px;" data-src="holder.js/300*180" >
				</div>
				<div class="span9">
					<h3>Mobile first</h3>

					h3 Bootstrap 2, we added optional mobile friendly styles for key aspects of the framework. With Bootstrap 3, we've rewritten the project to be mobile friendly from the start. Instead of adding on optional mobile styles, they're baked right into the core. In fact, Bootstrap is mobile first. Mobile first styles can be found throughout the entire library instead of in separate files.

					To ensure proper rendering and touch zooming, add the viewport meta tag to your head.
				</div>
			</div>
			<br>
		</div>
	</div>

</body>
</html>