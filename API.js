    var elem;
    
  var httpRequest;
  document.getElementById("b1").onclick = function() { makeRequest('send2.jsp?q=1',"s1"); };
  document.getElementById("b2").onclick = function() { makeRequest('send2.jsp?q=2&v1='+document.getElementById("t1").value,"s2"); };
  document.getElementById("b3").onclick = function() { makeRequest('send2.jsp?q=3&v1='+document.getElementById("select").value+"&v2="+document.getElementById("t2").value,"s3"); };
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

