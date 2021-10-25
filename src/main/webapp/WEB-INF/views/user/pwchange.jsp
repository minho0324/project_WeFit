<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    
    <style>

        .row h2 {
            text-align: center;
            color: rgb(0, 173, 181);
            font-size: 35px;
            font-weight: bold;
        }
        .empty-space{
            height:100px;
        }

        .passwordForm{
            margin-top: 100px;
            margin-bottom: 100px;
        }
  
    </style>
</head>

<body>
    <div class="container-fluid h-100">
        <div class="row">
            <%@ include file="../include/header.jsp" %>
        </div>
        
        <div class="container passwordForm">
        
            <div class="row">
                <h2>비밀번호 변경</h2>
            </div>
            <div class="empty-space"></div>
            
            <form id="form-passwdChange" action="<c:url value='/user/passwdChange' />" method="POST" class="form-horizontal">
        		<input type="hidden" name="memberNick" value="${nick }" />
                <div class="form-group">
                  <label for="input-password" class="col-sm-2 control-label">비밀번호</label>
                  <div class="col-sm-10">
                    <input name="memberPasswd" type="password" class="form-control" id="input-password" placeholder="비밀번호">
                  </div>
                </div>
                <div class="form-group">
                  <label for="input-password-check" class="col-sm-2 control-label">비밀번호확인</label>
                  <div class="col-sm-10">
                    <input type="password" class="form-control" id="input-password-check" placeholder="비밀번호확인">
                  </div>
                </div>
                <div class="empty-space"></div>
                <div class="row">
                    <div class="col-sm-offset-6 col-sm-2">
                        <button id="passwdChangeBtn" type="button" class="btn btn-primary">변경하기</button>
                    </div>
                    <div class="col-sm-2">
                        <button type="button" class="btn btn-defalut">취소하기</button>
                    </div>       
                </div>
            </form>
        
        </div>
        
        <div class="row">
            <%@ include file="../include/footer.jsp" %>
        </div>
    </div>
    <script>
	    $('#input-password').keyup(function(){
	 	   if(!regExpPw.test($('#input-password').val())){
	 		   $('#input-password').css("background-color","pink");
	 		   passwdChk = false;
	 	   } else {
	 		   $('#input-password').css("background-color","skyblue");
	 		   passwdChk = true;
	 	   }
	 	   
	    });
	    $('#input-password-check').keyup(function(){
     	   if($('#input-password').val() !== $('#input-password-check').val()){
     		   $('#input-password-check').css("background-color","pink");
     	   } else {
     		   $('#input-password-check').css("background-color","skyblue");
     	   }
     	   
        });
	    
	    
	    $('#passwdChangeBtn').click(function(){
	    	if(passwdChk == true){
		    	$('#form-passwdChange').submit();
	    	} else{
	    		alert('패스워드는 영문+숫자+특수문자조합으로 8자리 이상으로 해주셔야 합니다.')
	    	}
	    	
	    });
	    
	    
    </script>


    
</body>
</html>