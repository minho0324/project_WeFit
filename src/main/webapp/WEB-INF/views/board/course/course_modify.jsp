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
                        <h2>강의영상 수정</h2>
                    </div>
                </div>
            </div>

            <!--main left-->
            <form action="<c:url value='/courseBoard/modify' />" id="modifyForm" method="POST">
                <input type="hidden" name="cbNum" value="${article2.cbNum}">
                <input type="hidden" name="pageNum" value="${param.pageNum}">
                <input type="hidden" name="category" value="${param.category}">
                <input type="hidden" name="condition" value="${param.condition}">
                <input type="hidden" name="keyword" value="${param.keyword}">
                <table>
                    <tr>
                        <td>종목</td>
                        <td>
                            <select id="sports" name="cbCategory">
                                <option value="category">종목선택</option>
                                <option ${article2.cbCategory == '수영' ? 'selected' : ''}>수영</option>
                                <option ${article2.cbCategory == '배드민턴' ? 'selected' : ''}>배드민턴</option>
                                <option ${article2.cbCategory == '스쿼시' ? 'selected' : ''}>스쿼시</option>
                                <option ${article2.cbCategory == '자전거' ? 'selected' : ''}>자전거</option>
                                <option ${article2.cbCategory == '달리기' ? 'selected' : ''}>달리기</option>
                                <option ${article2.cbCategory == '등산' ? 'selected' : ''}>등산</option>
                                <option ${article2.cbCategory == '홈트짐트' ? 'selected' : ''}>홈트짐트</option>
                                <option ${article2.cbCategory == '필라테스' ? 'selected' : ''}>필라테스</option>
                                <option ${article2.cbCategory == '골프' ? 'selected' : ''}>골프</option>
                                <option ${article2.cbCategory == '스케이트' ? 'selected' : ''}>스케이트</option>
                                <option ${article2.cbCategory == '기타' ? 'selected' : ''}>기타</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>작성자</td>
                        <td><input type=text size=20 value="관리자" readonly disabled> </td>
                        <input type="hidden" name="memberNum" size="20" value="${loginuser.memberNum }">
                    </tr>

                    <tr>
                        <td>제목<sup> ( <span id="nowByte">${article2.cbTitleByte} </span> / 200bytes )</sup></td>
                        <td><input type=text id="cbTitle" name="cbTitle" size="60" value="${article2.cbTitle}"></td>
                    </tr>

                    <tr>
                        <td>내용<sup> ( <span id="nowByte2">${article2.cbContentByte} </span> / 2000bytes )</sup></td>
                        <td><textarea id="cbContent" name="cbContent" cols="75" rows="15" onKeyUp="javascript:fnChkByte(this,'2000')">${article2.cbContent}</textarea></td>
                    </tr>


                    <tr>
                        <td>youtube 주소<sup id="cbYouTube"> ( <span id="nowByte3">${article2.cbYouCodeByte} </span> / 50bytes )</sup></td>
                        <td><input type=text id="cbYouCode" name="cbYouCode" size="60" value="https://youtu.be/${article2.cbYouCode}"></td>
                    </tr>
                    
                    
                    <tr class="text-right">
                        <td colspan="2">
                            <br>
                            <c:if test="${loginuser.memberManagerYN == 'YES' }">
                            	<button type="button" class="btn btn-primary" id="reportResetBtn">신고초기화</button>
                            </c:if>
                            <c:if test="${loginuser.memberManagerYN == 'YES'}">
                            	<button type="button" class="btn btn-primary" id="modifyBtn">수정하기</button>
                            </c:if>
                            <button type="button" class="btn btn-warning" id="deleteBtn">삭제하기</button>
                            <button type="button" class="btn btn-default" id="cancelBtn" onclick='location.href="<c:url value='/courseBoard/detail?cbNum=${article2.cbNum}&pageNum=${param.pageNum}&category=${param.category}&condition=${param.condition}&keyword=${param.keyword}' />" '>취소하기</button>
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
       	
  	
      $(function() { // start jQuery
    	  
      	//제목 byte 체크
    	  $('#cbTitle').keyup(function(){
    	       bytesHandler(this);
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
    	   function bytesHandler(obj){
    	       var text = $(obj).val();
    	       $('#nowByte').text(getTextLength(text)); 	   
    	   }
    	   
    	   
       	//내용 byte 체크
     	  $('#cbContent').keyup(function(){
     	       bytesHandler2(this);
     	  });
     	   function bytesHandler2(obj){
     	       var text = $(obj).val();
     	       $('#nowByte2').text(getTextLength(text)); 	   
     	   }
     	   
     	   
           //유튜브 링크 byte 체크
       	  $('#cbYouCode').keyup(function(){
       	       bytesHandler3(this);
       	  });
 	              
       	  function bytesHandler3(obj){
       	       var text = $(obj).val();
       	         	     
       	       if($('#cbYouCode').val().includes("https://www.youtube.com/watch?v=")) {
                     $('#nowByte3').text(+getTextLength(text) - 32);  //저 링크주소가 차지하는 바이트(32바이트)를 빼줌(왜냐하면 db에는 youtube풀주소가 저장되는게아니기 때문에.. 저장안되는 저 링크 부분은 바이트 계산 해주면 안된다.)             
         		    return;
          	   } else if($('#cbYouCode').val().includes("https://youtu.be/")) {
                     $('#nowByte3').text(+getTextLength(text) - 17);               
             		return;
          	   } else {
          		  $('#nowByte3').text(+getTextLength(text));
          	   }
       	   
       	  }
    	   
         
         // 글 수정
         $('#modifyBtn').click(function() {
            if($('#sports').val() === 'category') {
               alert('종목을 선택해주세요.');
               return;            
            } else if($('#cbTitle').val().trim() === '') {
                alert('제목을 입력해주세요.');   
                return;
            } else if(+($('#nowByte').text()) > 200) {
                alert('제목은 최대 200byte를 초과할 수 없습니다.');   
                return;
            } else if(+($('#nowByte2').text()) > 2000) {
                 alert('내용은 최대 2000byte를 초과할 수 없습니다.');   
                 return;
            } else if($('#cbYouCode').val().trim() === '') {
                alert('youtube 주소를 입력해주세요.');   
                return;
            } else if($('#nowByte3').text() > 50) {
                 alert('유튜브 주소는 최대 50byte를 초과할 수 없습니다.');   
                return;
            } else {
               $('#modifyForm').submit();            
            }         
         }); // 글 수정 검증 끝
         
         // 신고 초기화
         $('#reportResetBtn').click(function(){
        	 $('#modifyForm').attr("action",'<c:url value="/courseBoard/reportReset" />')
        	 $('#modifyForm').submit();
        	 
         });
         
         
         
         
         // 글 삭제
         $('#deleteBtn').click(function() {
            if(confirm('정말 삭제하시겠습니까?')) {
               $('#modifyForm').attr('action', '<c:url value="/courseBoard/delete" />');
               $('#modifyForm').submit();
            } else {
               return;
            }
            
         }); // 글 삭제 처리 끝
         
         

      
      }); // end jQuery
      
         
   </script>

    
</body>

</html>