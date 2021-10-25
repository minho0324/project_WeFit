<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
                 <h2>식단 등록</h2>
             </div>
         </div>
     </div>

     <!--main left-->
     <form action="<c:url value='/dietBoard/dietWrite' />" id="boardWrite" name="writeForm" method="POST" enctype="multipart/form-data">
         <table>
             <tr>
                 <td>작성자</td>
                 <td><input type=text name="memberNick" id="memberNick" size=20 value="${loginuser.memberNick}" readonly></td>
             </tr>

             <tr>
                 <td>제목<sup> ( <span id="nowByte">최대 </span> / 200bytes )</sup></td>
                 <td><input type=text name="dbTitle" id="dbTitle" size="60"></td>
             </tr>

             <tr>
                 <td>내용<sup> ( <span id="nowByte2">최대 </span> / 2000bytes )</sup></td>
                 <td><textarea name="dbContent" id="dbContent" cols="75" rows="15" wrap="hard"></textarea></td>
             </tr>

             
             <tr>
                 <td>사진올리기 </td>
                 <td>
                 	<input multiple="multiple" type="file" id="uploadFiles" name="fileName" size="10" maxlength="10">
                 	<span></span>
                 </td>
             </tr>
             
             <tr class="text-right">
                 <td colspan="2">
                     <br>
                     <button class="btn btn-primary" id="writeBtn" type="button">등록하기</button>
                     <button class="btn btn-default" id="listBtn" type="button" onclick="location.href='<c:url value='/dietBoard/dietList' />'">취소하기</button>
                         <br><br><br>
                     </td>
                     
                 </tr>
             </table>
<input type="hidden" name="memberNum" value="${loginuser.memberNum}">
        </form>
    </div>

</div>


<div class="row">
    <%@ include file="../../include/footer.jsp" %>
</div>

<script>
  
  
   let bool = true;
 
   
	   $(function() {
	

	   	   $('#writeBtn').click(function() {
				if($('#dbTitle').val().trim() === ''){
					alert('제목을 입력하세요')
				return;
				}else if(+($('#nowByte').text()) > 200)	{
					alert('제목은 200byte를 초과할 수 없습니다')
					return;
				}else if(+($('#nowByte2').text()) > 2000){
					alert('내용은 2000byte를 초과할 수 없습니다.')
					return;
				}else{
					$('#boardWrite').submit();
				}
			});
	   	
		      
	    	//제목 byte 체크
	    	   $('#dbTitle').keyup(function(){
	    	        bytesHandler(this);
	    	   });
				function bytesHandler(obj) {
					var text = $(obj).val();
					$('#nowByte').text(getTextLength(text));
					
				}
	    	
	    	//내용 byte 체크
				$('#dbContent').keyup(function() {
					bytesHandler2(this);
				});
				function bytesHandler2(obj) {
					var text = $(obj).val();
					$('#nowByte2').text(getTextLength(text));
				}
			
				function getTextLength(str) {
					var rbyte = 0;
					for (var i = 0; i < str.length; i++) {
						if (str.charCodeAt(i) > 127) { 
							rbyte += 3;
						} else if (str.charCodeAt(i) < 12) { 
							rbyte += 2;
						} else { 
							rbyte++;
						}
					}
					return rbyte;
				}

   	  
   	  
   	
		$('#listBtn').click(function() {
			if(confirm('목록으로 돌아가시겠습니까?')) {
				location.href='<c:url value="/dietBoard/dietList" />';
			} else {
				return;
			}
		});
 		
		//조건 통과 여부 거를 변수
		let bool = true;
 		
 		//각 파일당, 전체 용량 확인 함수
 		$("input[name=fileName]").off().on("change", function(){
	
  		if(this.files || this.files[0] || this.files[1] || this.files[2] || this.files[3] || this.files[4] != null) {
  			var maxSize = 50 * 1024 * 1024;
  			var totalSize = 0;
  			
 				if($('#uploadFiles')[0].files.length > 5) {
 					alert('최대 사진 수는 5장입니다.');
 					bool = false;
 					return;
 				}
 				
  			for(i=0; i<this.files.length; i++) {
  				totalSize += this.files[i].size;
  			}
  				for(i=0; i<5; i++) {
  					if(this.files[0].size > 10 * 1024 * 1024){
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
 			bool = true;
 		}); //각 파일당, 전체 용량 확인 함수 종료
 		
  				
  }); //제이쿼리 종료

		
		
		
  </script>
    
    
    
    
    

    
</body>

</html>


