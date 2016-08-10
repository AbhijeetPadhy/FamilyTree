<html>
<head>
	<title>WOOOOOOW</title>
</head>

<body>

<span id="ajaxButton" style="cursor: pointer; text-decoration: underline">
  Display data of all students
</span>
<p id="disp"></p>

<span id="ajaxButton1" style="cursor: pointer; text-decoration: underline">
  Display data of all students whose total > 50
</span>
<p id="disp1"></p>


<script type="text/javascript">
(function() {
    var elem;
    var queryString = 
                            "PREFIX nit:   <http://nitdgp.ac.in/> " +
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
                            
    var queryString1 = 
                            "PREFIX nit:   <http://nitdgp.ac.in/> " +
                            "SELECT ?rollno ?total ?grade " +
                            "WHERE {" +
                            "?x nit:rollno ?y. " +
                            "?y nit:roll ?r1. " +
                            "?y nit:no ?r2. " +
                            "?x nit:sem ?sem. " +
                            "?x nit:ca ?ca. " +
                            "?x nit:total ?total. " +
                            "?x nit:grade ?grade " +
                            "BIND(CONCAT(?r1, ?r2) AS ?rollno)" +
                            "FILTER(?total > \"70.0\") " +
                            "}";
  var httpRequest;
  document.getElementById("ajaxButton").onclick = function() { makeRequest('send.jsp?q='+queryString,"disp"); };
  document.getElementById("ajaxButton1").onclick = function() { makeRequest('send.jsp?q='+queryString1,"disp1"); };

  function makeRequest(url,e) {
    elem = e;
    httpRequest = new XMLHttpRequest();

    if (!httpRequest) {
      alert('Giving up :( Cannot create an XMLHTTP instance');
      return false;
    }
    httpRequest.onreadystatechange = alertContents;
    httpRequest.open('GET', url);
    httpRequest.send();
  }

  function alertContents() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      if (httpRequest.status === 200) {
        var text = httpRequest.responseText;
        var obj = JSON.parse(text);
        var head = obj.head.vars;
        fLen = obj.head.vars.length;
        var str = "<table border=1><tr>";
        for(var i = 0; i<fLen ;i++){
            str = str + "<th>" + obj.head.vars[i] + "</th>";
        }
        str = str + "</tr>";
        no = obj.results.bindings.length;
        for(i=0;i<no;i++){
            str += "<tr>";
            for(j=0;j<fLen;j++){
                str += "<td>"+ obj.results.bindings[i][obj.head.vars[j]].value + "</td>";
            }
            str += "</tr>";
        }
        str += "</table>";
        document.getElementById(elem).innerHTML = str;
      } else {
        alert('There was a problem with the request.');
      }
    }
  }
})();
</script>

</body>
</html>
