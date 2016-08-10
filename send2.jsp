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
<%@page import= "org.apache.jena.query.QueryExecution " %>
<%@page import= "org.apache.jena.query.QueryExecutionFactory " %>
<%@page import= "org.apache.jena.query.ResultSet " %>
<%@page import= "org.apache.jena.query.* " %>
<%@page import= "org.apache.jena.graph.Node" %>
<%@page import= "java.io.*" %>
<%@page import= "org.apache.jena.util.FileManager" %>
<%
        
        String inputFileName  = "/opt/tomcat/webapps/ROOT/semantic/marks-xlsx.rdf";
        // create an empty model
        Model model = ModelFactory.createDefaultModel();

        InputStream in = FileManager.get().open( inputFileName );
        if (in == null) {
            out.print( "File: " + inputFileName + " not found");
        }
        else {
            // read the RDF/XML file
            model.read(in, "");
            
            //display info about all students
            String querytype = request.getParameter("q");
            String v1,v2;
            String queryString="";
            if(querytype.equals("1")){
                v1=request.getParameter("v1");
                queryString="PREFIX nit:   <http://nitdgp.ac.in/> " +
                            "SELECT ?sem ?rollno ?ca ?total ?grade " +
                            "WHERE {" +
                            "?x nit:rollno ?y. " +
                            "?y nit:roll ?r1. " +
                            "?y nit:no ?r2. " +
                            "?x nit:sem ?sem. " +
                            "?x nit:ca ?ca. " +
                            "?x nit:total ?total. " +
                            "?x nit:grade ?grade " +
                            "BIND(CONCAT(?r1, ?r2) AS ?rollno)" +
                            "}";
            }
            else if(querytype.equals("2")){
                v1=request.getParameter("v1");
                queryString="PREFIX nit:   <http://nitdgp.ac.in/> " +
                            "SELECT ?sem ?rollno ?ca ?total ?grade " +
                            "WHERE {" +
                            "?x nit:rollno ?y. " +
                            "?y nit:roll ?r1. " +
                            "?y nit:no ?r2. " +
                            "?x nit:sem ?sem. " +
                            "?x nit:ca ?ca. " +
                            "?x nit:total ?total. " +
                            "?x nit:grade ?grade " +
                            "BIND(CONCAT(?r1, ?r2) AS ?rollno)" +
                            "FILTER(?rollno = \""+v1+"\") " +
                            "}";
            }
            else if(querytype.equals("3")){
                v1=request.getParameter("v1");
                v2=request.getParameter("v2");
                String c="";
                if(v1.equals("less"))
                    c="<";
                else if(v1.equals("greater"))
                    c=">";
                else if(v1.equals("equal"))
                    c="=";
                    
                queryString="PREFIX nit:   <http://nitdgp.ac.in/> " +
                            "SELECT ?sem ?rollno ?ca ?total ?grade " +
                            "WHERE {" +
                            "?x nit:rollno ?y. " +
                            "?y nit:roll ?r1. " +
                            "?y nit:no ?r2. " +
                            "?x nit:sem ?sem. " +
                            "?x nit:ca ?ca. " +
                            "?x nit:total ?total. " +
                            "?x nit:grade ?grade " +
                            "BIND(CONCAT(?r1, ?r2) AS ?rollno)" +
                            "FILTER(?total "+c+" \""+v2+"\") " +
                            "}";
            }
            //out.print(queryString+"wow");

            Query query = QueryFactory.create(queryString) ;
            try (QueryExecution qexec = QueryExecutionFactory.create(query, model)) {
            ResultSet results = qexec.execSelect() ;
        // write to a ByteArrayOutputStream
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

            ResultSetFormatter.outputAsJSON(outputStream, results);
            //ResultSetFormatter.outputAsTSV(outputStream, results);
            //ResultSetFormatter.outputAsXML(outputStream, results);
            //ResultSetFormatter.outputAsCSV(outputStream, results);

            // and turn that into a String
            String json = new String(outputStream.toByteArray());

            out.println(json);
            }
            
        }
%>
				
