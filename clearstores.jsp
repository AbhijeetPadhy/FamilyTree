<html>
<head></head>
<body>
<%@page import= "org.apache.jena.rdf.model.*" %>
<%@page import= "org.apache.jena.tdb.TDBFactory" %>
<%@page import= "org.apache.jena.update.GraphStore" %>
<%@page import= "org.apache.jena.update.GraphStoreFactory" %>
<%@page import= "org.apache.jena.update.UpdateExecutionFactory" %>
<%@page import= "org.apache.jena.update.UpdateFactory" %>
<%@page import= "org.apache.jena.update.UpdateProcessor" %>
<%@page import= "org.apache.jena.update.UpdateRequest" %>
<%@page import= "org.apache.jena.vocabulary.*" %>
<%@page import= "org.apache.jena.query.Dataset " %>
<%@page import= "org.apache.jena.query.ReadWrite " %>

<%

        String pass    = request.getParameter("password");

		if( pass.equals("abhijeet") ){
			String directory = "TDBStore" ;
			Dataset dataset = TDBFactory.createDataset(directory) ;
			dataset.begin(ReadWrite.WRITE) ;

			try {
				Model model = dataset.getDefaultModel() ;
				// API calls to a model in the dataset

				// ... perform a SPARQL Update
				GraphStore graphStore = GraphStoreFactory.create(dataset) ;
				String sparqlUpdateString = "CLEAR  DEFAULT ";
				UpdateRequest req = UpdateFactory.create(sparqlUpdateString) ;
				UpdateProcessor proc = UpdateExecutionFactory.create(req, graphStore) ;
				proc.execute() ;

				// Finally, commit the transaction.
				dataset.commit() ;
				// Or call .abort()
			   } finally {
				   dataset.end() ;
			   }

		}
		response.sendRedirect("tdbread.jsp");
%>
</body>
</html>
