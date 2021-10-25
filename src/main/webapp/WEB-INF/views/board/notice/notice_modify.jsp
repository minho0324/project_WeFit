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
                        <h2>공지사항 수정</h2>
                    </div>
                </div>
            </div>

            <!--main left-->
            <form action="<c:url value='/noticeBoard/noticeModify' />" id="modifyForm" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="nbNum" value="${noticeContent.nbNum }">
                <table>
                    

                    <tr>
                        <td>작성자</td>
                        <td><input type=text name=name size=20 readonly value="관리자"></td>
                    </tr>

                    <tr>
                        <td>제목<sup> ( <span id="nowByte">최대 </span> / 200bytes )</sup></td>

                        <td><input id="titleInput" type=text name="nbTitle" size="60" value="${noticeContent.nbTitle}"></td>

                    </tr>

                    <tr>
                        <td>내용<sup> ( <span id="nowByte2">최대 </span> / 2000bytes )</sup></td>

                        <td><textarea name="nbContent" id="contentInput" cols="75" rows="15">${noticeContent.nbContent}</textarea></td>

                    </tr>

                   <div class='uploadResult'>
                    	<tr>
                        <td>사진올리기 </td>

                        <td><input multiple type="file" name="fileName" id="fileName" size="1" maxlength="1" value="${noticeContent.nbRealImage1 }"></td>
                    	</tr>
                    </div>
                    
                    <tr class="text-right">
                        <td colspan="2">
                            <br>
							<c:if test="${loginuser.memberManagerYN == 'YES' }">
                            	<button type="button" class="btn btn-primary" id="reportResetBtn">신고초기화</button>
                            </c:if>
                            <c:if test="${loginuser.memberNum == noticeContent.memberNum}">
	                       		<button class="btn btn-primary" type="button" id="modifyBtn">수정하기</button>
	                       	</c:if>
                            <button class="btn btn-primary" type="button" id="deleteBtn">삭제하기</button>
                            <button type="button" class="btn btn-default" onclick="location.href='<c:url value="/noticeBoard/noticeDetail?nbNum=${noticeContent.nbNum}" />'">취소하기</button>

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
    //	let title = $('#input-title').val();
    	
    	
   // 	$('#modifyBtn').click(function(){
  //  		$('#modifyForm').submit();
  //  	});
    
    	$('#deleteBtn').click(function(){
    		if(confirm("정말로 삭제하시겠습니까?")){
	    		$('#modifyForm').attr("action","<c:url value='/noticeBoard/noticeDelete'/>")
	    		$('#modifyForm').submit();
    		}
    	});
    	$('#reportResetBtn').click(function() {
	       	 $('#modifyForm').attr("action",'<c:url value="/noticeBoard/reportReset" />')
	       	 $('#modifyForm').submit();
	   		
 	 	});
    	
    	
		
////////////////////////////////////////////////////////////////////////////////		
		let bool = true;
		 $(function() {
   	  
   	//제목 byte 체크
   	  $('#titleInput').keyup(function(){
   	       bytesHandler(this);
   	  });
   	   function getTextLength(str) {
   	       var rbyte = 0;
   	       for (var i = 0; i < str.length; i++) {
   	    	   if(str.charCodeAt(i) > 127) { // 한글 3Byte
   	  	        	rbyte += 3;
   	  	        } else if(str.charCodeAt(i) < 12) { // 엔터 2Byte
   	  	        	rbyte += 2;
   	  	        } else { //영문 등 나머지 1Byte
   	  	        	rbyte++;
   	  	        }
   	      }
   	       return rbyte;
   	  }
   	   function bytesHandler(obj){
   	       var text = $(obj).val();
   	       $('#nowByte').text(getTextLength(text)); 	   
   	   }
   	   
   	   
      	//내용 byte 체크
    	  $('#contentInput').keyup(function(){
    	       bytesHandler2(this);
    	  });
    	   function bytesHandler2(obj){
    	       var text = $(obj).val();
    	       $('#nowByte2').text(getTextLength(text)); 	   
    	   }
     
     });

  
     $(function() {
        

         $('#modifyBtn').click(function() {
           if($('#titleInput').val() === '') {
              alert('제목은 필수 항목 입니다.');
              $('#titleInput').focus();
                return;
           }else if(+($('#nowByte').text()) > 200) {
               alert('제목은 최대 200byte를 초과할 수 없습니다.');   
               $('#titleInput').focus();
                    return;
           }else if(+($('#nowByte2').text()) > 2000) {
                  alert('내용은 최대 2000byte를 초과할 수 없습니다.');   
                  $('#contentInput').focus();
                  return;
           }else if(!bool){
              alert('글쓰기 입력 정보를 다시 확인해주세요.'); 
              return;
           }else {
              $('#modifyForm').submit();  
              
           }
  
        });
       //각 파일당, 전체 용량 확인 함수
         $("#fileName").change(function(){
           if(this.files || this.files[0] || this.files[1] || this.files[2] || this.files[3] || this.files[4] != null) {
              
              
              if($('#fileName')[0].files.length > 1) {
                 alert('최대 사진 수는 1장입니다.');
                 bool = false;
                 return;
              }
              
              
                 for(i=0; i<5; i++) {
                    if(this.files[0].size > 10 * 1024 * 1024){
                       alert('한 이미지의 허용 크기는 10MB입니다.');
                       bool = false;
                       return;
                    }
                 }
             
           }

                 
           
           bool = true;
        }); //각 파일당, 전체 용량 확인 함수 종료
   });
	</script>

    
</body>

</html>


    

	
