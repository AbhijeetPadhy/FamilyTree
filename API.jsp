<html>
<head>
    <title>API woooooow</title>
</head>
<body>
    <form>
        <fieldset>
            <legend>Example 1</legend>
            <button type="button" id="b1">Display All Data</button>
            <span id="s1"></span>
        </fieldset><br>
        <fieldset>
            <legend>Example 2</legend>
            Display All details of a student with roll no <input type="text" id="t1" name="marks">
            <button type="button" id="b2">Display</button>
            <span id="s2"></span>
        </fieldset><br>
        <fieldset>
            <legend>Example 3</legend>
            Display marks of all those whose total is 
            <select name="logic" id="select">
                <option value="less">less than</option>
                <option value="greater">greater than</option>
                <option value="equal">equal to</option>
            </select>
            <input type="text" name="marks" id="t2">
            <button type="button" id="b3">Display</button>
            <span id="s3"></span>
        </fieldset>
    </form>
    <script src="API.js"></script>
</body>
</html>