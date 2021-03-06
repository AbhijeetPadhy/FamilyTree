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
<%@ page import="java.net.URLDecoder"%>
<%

        String relation    = request.getParameter("relation");
		String resvalue    = request.getParameter("resvalue");
		String person = request.getParameter("person");
		String personURI = URLDecoder.decode(person).trim();
		String valueURI = URLDecoder.decode(resvalue);
        String nsA = "http://somewhere/else#";

		//out.print(relation);
		//out.print(resvalue);
		out.print("--");
		out.print(personURI);
		out.print("--");
		//out.print(nsA);
        String directory = "TDBStore" ;
        Dataset dataset = TDBFactory.createDataset(directory) ;
        dataset.begin(ReadWrite.WRITE) ;

        try {
            Model model = dataset.getDefaultModel() ;
            // API calls to a model in the dataset
			Property P = model.createProperty( nsA + relation );
			Resource obj = model.getResource(valueURI);
            Resource johnSmith
            = model.getResource(personURI)
                   .addProperty(P, obj);


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
		response.sendRedirect("person.jsp?uri="+personURI);
%>
