<html>
<head>
	<title>WOOOOOOW</title>
</head>

<body>
<p id="disp"></p>
<span id="ajaxButton" style="cursor: pointer; text-decoration: underline">
  Make a request
</span>
<script type="text/javascript">
(function() {
  var httpRequest;
  document.getElementById("ajaxButton").onclick = function() { makeRequest('target.jsp?uri=http://somewhere/AbhijeetPadhy'); };

  function makeRequest(url) {
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
        document.getElementById("disp").innerHTML = httpRequest.responseText;
      } else {
        alert('There was a problem with the request.');
      }
    }
  }
})();
</script>

</body>
</html>