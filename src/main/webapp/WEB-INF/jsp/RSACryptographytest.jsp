<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = (String) request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Login</title>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 순서에 유의 -->
<script type="text/javascript" src="<%=ctxPath %>/home/script/RSA/rsa.js"></script>
<script type="text/javascript" src="<%=ctxPath %>/home/script/RSA/jsbn.js"></script>
<script type="text/javascript" src="<%=ctxPath %>/home/script/RSA/prng4.js"></script>
<script type="text/javascript" src="<%=ctxPath %>/home/script/RSA/rng.js"></script>
 
<script type="text/javascript">    
    function login(){
        var id = $("#USER_ID_TEXT");
        var pw = $("#USER_PW_TEXT");
    
        if(id.val() == ""){
            alert("아이디를 입력 해주세요.");
            id.focus();
            return false;
        }
        
        if(pw.val() == ""){
            alert("비밀번호를 입력 해주세요.");
            pw.focus();
            return false;
        }
        
        // rsa 암호화
        var rsa = new RSAKey();
        rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
        
        $("#USER_ID").val(rsa.encrypt(id.val()));
        $("#USER_PW").val(rsa.encrypt(pw.val()));
        
        setCookie("USER_ID", id.val(), 1);
        
        id.val("");
        pw.val("");
 
        return true;
    }
    
    function setCookie(cName, cValue, cSecond){
        var expire = new Date();
        expire.setTime(expire.getTime() + (cSecond * 10000));
        cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
        if(typeof cSecond != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
 		console.log(expire.toGMTString());
        document.cookie = cookies;
    }
    function getCookie(cName) {
        cName = cName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cName);
        var cValue = '';
        if(start != -1){
            start += cName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cValue = cookieData.substring(start, end);
        }
        return unescape(cValue);
    }
	console.log(getCookie("USER_ID"));
</script>
</head>
<body>
    <form name="frm" method="post" action="<%=ctxPath%>/login.do" onsubmit="return login()">
        <input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
        <input type="hidden" id="RSAExponent" value="${RSAExponent}"/>    
        <input type="text" placeholder="아이디" id="USER_ID_TEXT" name="USER_ID_TEXT" />
        <input type="password" placeholder="비밀번호" id="USER_PW_TEXT" name="USER_PW_TEXT" />
        <input type="hidden" id="USER_ID" name="USER_ID">
        <input type="hidden" id="USER_PW" name="USER_PW">
        <input type="submit" value="로그인" />
    </form>
</body>
</html>