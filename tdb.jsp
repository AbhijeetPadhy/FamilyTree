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

        String givenName    = request.getParameter("first");
        String familyName   = request.getParameter("last");
        String fullName     = givenName + " " + familyName;
				String personURI    = "http://somewhere/"+givenName+familyName;

        String directory = "TDBStore" ;
        Dataset dataset = TDBFactory.createDataset(directory) ;
        dataset.begin(ReadWrite.WRITE) ;

        try {
            Model model = dataset.getDefaultModel() ;
            Resource johnSmith
            = model.createResource(personURI)
                   .addProperty(VCARD.FN, fullName)
                   .addProperty(VCARD.N,
                                model.createResource()
                                     .addProperty(VCARD.Given, givenName)
                                     .addProperty(VCARD.Family, familyName));


            // ... perform a SPARQL Update
            GraphStore graphStore = GraphStoreFactory.create(dataset) ;
            String sparqlUpdateString = "INSERT { ?s ?p ?now } WHERE { BIND(now() AS ?now) }";
						//String sparqlUpdateString = "CLEAR  DEFAULT ";
            UpdateRequest req = UpdateFactory.create(sparqlUpdateString) ;
            UpdateProcessor proc = UpdateExecutionFactory.create(req, graphStore) ;
            proc.execute() ;

            // Finally, commit the transaction.
            dataset.commit() ;
            // Or call .abort()
           } finally {
               dataset.end() ;
           }
		   response.sendRedirect("index.jsp");
%>
</body>
</html>
