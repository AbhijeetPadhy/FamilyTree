
<%@page import= "org.apache.jena.rdf.model.*" %>
<%@page import= "org.apache.jena.tdb.TDBFactory" %>
<%@page import= "org.apache.jena.update.GraphStore" %>
<%@page import= "org.apache.jena.update.GraphStoreFactory" %>
<%@page import= "org.apache.jena.query.* " %>
<%@page import= "org.apache.jena.query.Dataset " %>
<%@page import= "org.apache.jena.query.QueryExecution " %>
<%@page import= "org.apache.jena.query.QueryExecutionFactory " %>
<%@page import= "org.apache.jena.query.ReadWrite " %>
<%@page import= "org.apache.jena.query.ResultSet " %>
<%@page import= "org.apache.jena.rdf.model.*" %>





<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="bootstrap.min.css">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

	<!-- jquery -->
	<script src="jquery.min.js"></script>

	<!-- Latest compiled and minified JavaScript -->
	<script src="bootstrap.min.js"></script>

	<style>
	body {
    background-color: #bdc3c7;
	}
	div.page{
	background-color: #fbfcfc;
	box-shadow: 0px 0px 10px grey;
	}
	.text-cloud{
	color: #ecf0f1;
	}
	.colp{
	background-color: #34495e;
	}
	</style>
	<title>Home</title>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<nav class="navbar navbar-default navbar-fixed-top">
			  <div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
				  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				  </button>
				  <a class="navbar-brand" href="index.jsp">iDEAS</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				  <ul class="nav navbar-nav">
					<li><a href="index.jsp">Home</a></li>
					<li><a href="createres.jsp">Create</a></li>
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="#">Separated link</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="#">One more separated link</a></li>
					  </ul>
					</li>
				  </ul>
				  <form class="navbar-form navbar-left" role="search">
					<div class="form-group">
					  <input type="text" class="form-control" placeholder="Search">
					</div>
					<button type="submit" class="btn btn-default">Submit</button>
				  </form>
				  <ul class="nav navbar-nav navbar-right">
					<li class="active"><a href="tdbread.jsp">Triple Store</a></li>
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li role="separator" class="divider"></li>
						<li><a href="#">Separated link</a></li>
					  </ul>
					</li>
				  </ul>
				</div><!-- /.navbar-collapse -->
			  </div><!-- /.container-fluid -->
			</nav>
		</div>

		<div>
			<div class="jumbotron text-cloud colp hidden-xs hidden-sm">
			  <h1>Family Tree</h1>
			  <p>we the people</p>
			  <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
		</div>
		<div>
			<div class="visible-xs visible-sm">
				<br /><br /><br /><br />
			</div>
		</div>
		<div class="row">
			<div class="col-xs-1"></div>
			<div class="col-xs-10 page">
				<div class="page-header">
				  <h1>
					<%
						out.println("Triple Stores");
					%> <small>...</small></h1>
				</div>

				<table class="table table-hover">
				  <tr>
					<th>subject</th>
					<th>predicate</th>
					<th>object</th>
				  </tr>
				  <%
						//Dataset dataset = DatasetFactory.create(dftGraphURI, namedGraphURIs) ;
							String directory = "TDBStore" ;
							Dataset dataset = TDBFactory.createDataset(directory) ;
							dataset.begin(ReadWrite.READ) ;

							String qs1 = "SELECT * {?s ?p ?o}" ;

							try {
								QueryExecution qExec = QueryExecutionFactory.create(qs1, dataset);
								ResultSet rs = qExec.execSelect() ;
								for ( int i=1; rs.hasNext() ; )
								  {
									QuerySolution soln = rs.nextSolution() ;
									RDFNode s=soln.get("s");
									RDFNode p=soln.get("p");
									RDFNode o=soln.get("o");
									out.println("<tr>");
										out.println("<td>"+s+"</td>");
										out.println("<td>"+p+"</td>");
										out.println("<td>"+o+"</td>");
									out.println("</tr>");
									//extracting directly FullName

								  }
							}
							finally {
								   dataset.end() ;
							   }
					%>
				</table>

				<div class="bs-callout bs-callout-warning" id="callout-formgroup-inputgroup">
					<h4>Empty the triple stores...</h4>
					<form class="form-horizontal" method="POST" action="clearstores.jsp">

					  <div class="form-group">
						<label class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
						  <input type="password" class="form-control" id="inputPassword3" placeholder="Passowrd" name="password">
						</div>
					  </div>

					  <div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">

						  <button type="submit" class="btn btn-default">Proceed</button>
						</div>
					  </div>
					</form>
				 </div>

			</div>
			<div class="col-xs-1"></div>
		</div>
		<br /><br /><br /><br />
		<div class="row">
			<nav class="navbar navbar-default navbar-fixed-bottom">
			  <div class="container-fluid">
					<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
				  <a class="navbar-brand">Semantic Web Technologies, NIT Durgapur</a>
				</div>
			  </div><!-- /.container-fluid -->
			</nav>
		</div>

	</div>
</body>
</html>
