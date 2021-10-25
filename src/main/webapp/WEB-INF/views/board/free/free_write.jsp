<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        .titlebox h2 {
            border-bottom: 1px solid rgb(0, 173, 181);
            margin-top: 90px;
            margin-bottom: 80px;
            padding-bottom: 20px;
            font-size: 40px;
            font-weight: bold;
            color: rgb(0, 173, 181);
        }



        table tr:first-child {
            border-top: 1px solid rgb(180, 180, 180);
        }

        table tr td {
            padding: 15px;
            border-bottom: 1px solid #ccc;
        }

        .titlefoot {
            float: right;
            margin: 20px;
        }
    </style>
</head>

<body>

    <div class="container-fluid h-100">
        <div class="row">
            <%@ include file="../../include/header.jsp" %>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-sm-5">
                    <div class="titlebox">
                        <h2>게시글 작성</h2>
                    </div>
                </div>
            </div>

            <!--main left-->
            <form action="#" id="boardWrite" method="POST" enctype="multipart/form-data">
            	<input type="hidden" name="memberNum" value="${loginuser.memberNum}">
                <table>
                    <tr>
                        <td>게시판</td>
                        <td>
                            <select id="category" class="form-control">
								  <option value="[자유글]" selected>자유글</option>
								  <option value="[소식/정보]">소식/정보</option>
								  <option value="[홍보]">홍보</option>
								  <option value="[꿀팁]">꿀팁</option>
								  <option value="[기타]">기타</option>
							</select>
                        </td>
                    </tr>

                    <tr>
                        <td>작성자</td>
                        <td><input type="text" name="memberNick" size="20" value="${loginuser.memberNick }" readonly> </td>
                    </tr>

                    <tr>
                        <td>제목<sup> ( <span id="titleByte"> </span> / 200bytes )</sup></td> 
                        <td><input type=text name="fbTitle" size="60" id="titleInput"></td>
                    </tr>

                    <tr>
                        <td>내용<sup> ( <span id="contentByte"> </span> / 2000bytes )</sup></td>
                        <td><textarea id="contentInput" name="fbContent" cols="75" rows="15"></textarea></td>
                    </tr>

             

                    
                    <tr>
                        <td>사진올리기 </td>
                        <td><input id="uploadFiles" multiple type="file" name="fileName" size="10" maxlength="10" ></td>
                    </tr>
                    
                    <tr class="text-right">
                        <td colspan="2">
                            <br>
                            <button class="btn btn-primary" type="button" id="regBtn">등록하기</button>
                            <button class="btn btn-default" type="button" onclick="location.href='<c:url value="/freeBoard/" />'">취소하기</button>
                            <br><br><br>
                        </td>

                    </tr>
                </table>

            </form>
        </div>

    </div>


    <div class="row">
        <%@ include file="../../include/footer.jsp" %>
    </div>
	<script>
		let bool = true;
	
		$('#category').change(function(){
	    	let title = $('#titleInput').val();
			let category = title.substring(title.indexOf("["),title.indexOf("]")+1);
			if(category !== $('#category').val()){
				$('#titleInput').val(title.replace(category,$('#category').val()));
			}
			$('#titleByte').text(getTextLength($(titleInput).val()));
		});
		function getTextLength(str) {
		       var rbyte = 0;
		       for (var i = 0; i < str.length; i++) {
		    	   if(str.charCodeAt(i) > 127) { // 한글 3Byte
		  	        	rbyte += 3;
		  	        } else if(str.charCodeAt(i) < 12) { // 엔터 2Byte //이부분이 의문이다. 왜 sqlDeveloper에서 엔터를 2바이트로 인식할까... (엔터가 \r\n으로 저장되어서 4바이트일줄알았는데.. + 그리고 str.charCodeAt(i) == 13으로 작성했는데 왜 안먹힐까..13이 엔터아닌가?)
		  	        	rbyte += 2;
		  	        } else { //영문 등 나머지 1Byte
		  	        	rbyte++;
		  	        }
		      }
		      return rbyte;
		 }
		$(document).ready(function () {
			$('#titleInput').val($('#category').val());
			$('#titleByte').text(getTextLength($(titleInput).val()));
			$('#contentByte').text(getTextLength($(contentInput).val()));
		});
		
		$('#titleInput').keyup(function(){
			$('#titleByte').text(getTextLength($(this).val()));
		});
		$('#contentInput').keyup(function(){
			$('#contentByte').text(getTextLength($(this).val()));
		});
	
        
        //각 파일당, 전체 용량 확인 함수
        $("#uploadFiles").change(function(){
          bool = true;
      		
           if(this.files || this.files[0] || this.files[1] || this.files[2] || this.files[3] || this.files[4] != null) {
              var maxSize = 50 * 1024 * 1024;
              var totalSize = 0;
              
              if($('#uploadFiles')[0].files.length > 5) {
                 alert('최대 사진 수는 5장입니다.');
                 bool = false;
                 
                 return;
              }
              
              console.log(this.files.length);
              console.log('---------------');
              
              for(i=0; i<this.files.length; i++) {
                 totalSize += this.files[i].size;
              }
                 for(i=0; i<5; i++) {
                    if(this.files[i].size > 10 * 1024 * 1024){
                       alert('한 이미지의 허용 크기는 10MB입니다.');
                       bool = false;
                       return;
                    }
                 }
              if(totalSize > maxSize) {
                 alert('사진의 총 용량은 50MB입니다.');
                 bool = false;
                 return;
              }
           }
        }); //각 파일당, 전체 용량 확인 함수 종료
	
		$('#regBtn').click(function(){
			if($('#titleInput').val().trim() === ''){
				alert('제목을 입력해주세요.');
				return;
			} else if(+($('#titleByte').text()) > 200){
				alert('제목은 최대 200byte를 초과할 수 없습니다.');   
	            return;
			} else if($('#contentInput').val().trim() === ''){
				alert('내용을 입력해주세요.');
				return;
			} else if(+($('#contentByte').text()) > 2000){
				alert('내용은 최대 2000byte를 초과할 수 없습니다.');   
	            return;
			} else if(!bool){
				alert('사진파일을 확인해주세요');
				return;
			} else if($('#titleInput').val().indexOf($('#category').val()) === -1){ // 해당 태그 있는지 확인
				
				$('#titleInput').val($('#category').val()+$('#titleInput').val()); // 제목에 태그 넣기
			}
			
			$('#boardWrite').submit();
		});
		
		
	</script>

   
</body>

</html>