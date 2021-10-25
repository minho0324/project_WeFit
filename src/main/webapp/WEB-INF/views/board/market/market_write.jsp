<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   
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
                        <h2>물품 등록하기</h2>
                    </div>
                </div>
            </div>

            <!--main left-->

            <form action="<c:url value='/marketBoard/regist' />" id="boardWrite" method="POST" enctype="multipart/form-data">

                <table>
                    <tr>
                        <td>카테고리</td>
                        <td>

                            <select id="mbType" name="mbType">
                                <option value="sell">팔아요</option>
                                <option value="buy">사요</option>
                                <option value="share">나눠요</option>

                                
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>작성자</td>
                        <td>
                           <input type="text" name="memberNick" size=20 value="${loginuser.memberNick }">
                           <input type="hidden" name="memberNum" value="${loginuser.memberNum }">
                         </td>

                    </tr>

                    <tr>
                        <td>제목<sup> ( <span id="nowByte">최대 </span> / 200bytes )</sup></td>

                        <td><input type="text" name="mbTitle" size="60" id="mbTitle"></td>

                    </tr>

                    <tr>
                        <td>내용<sup>( <span id="nowByte2">최대 </span> / 2000bytes )</sup></td>

                        <td><textarea name="mbContent" cols="75" rows="15" id="mbContent"></textarea></td>

                    </tr>

                    <tr>
                        <!--
                            다음 주소 api : 주소를 선택하면 지도도 함께 보여주기
                            https://postcode.map.daum.net/guide#sample
                        -->
                        <td>동네</td>
                        <td>
                           <input type="hidden" id="sample6_postcode" placeholder="우편번호">
                     <input type="button" onclick="sample6_execDaumPostcode()" value="주소 찾기"><br>
                     거래장소:<input type="text" id="sample6_address" name="mbAddrBasic" placeholder="주소" size="50" readonly><br>
                     <input type="hidden" id="sample6_detailAddress" name="mbAddrDetail" placeholder="상세주소">
                     <input type="hidden" id="sample6_extraAddress" placeholder="참고항목"><br>
         
                           <input type="hidden" name="mbLatitude" id="latitude" ><br>
                           <input type="hidden" name="mbLongitude" id="longitude"><br>
                           <input type="hidden" name="mbImageCount" value="0">
                           <input type="hidden" name="mbLookCount" value="0">
                        </td>
                    </tr>

                
                    <tr>
                        <td>사진올리기 </td>
                        <td><input multiple="multiple" type="file" id="uploadFiles" name="fileName" size="10"></td>

                    </tr>
                    <tr>
                        <td>가격 </td>
                        <td><input id="priceInput" type=text name=mbPrice size="60"></td>

                    </tr>
                    <tr class="text-right">
                        <td colspan="2">
                            <br>
                            <button class="btn btn-primary" id="registBtn" type="button">등록하기</button>
                            <button class="btn btn-default" type="button" onclick="history.back()">취소하기</button>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
                geocoder.addressSearch($('#sample6_address').val(), coordinate);
            }
        }).open();
        
        
        
    } // 다음 주소 끝
        
    var coordinate = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
           $('#longitude').val(result[0].x);
           $('#latitude').val(result[0].y);
            console.log(result);
        }
    };
    </script>
<script>
   
    
let bool = true;
    $(function() {
       

    	 $('#mbTitle').keyup(function(){
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
   	  $('#mbContent').keyup(function(){
   	       bytesHandler2(this);
   	  });
   	   function bytesHandler2(obj){
   	       var text = $(obj).val();
   	       $('#nowByte2').text(getTextLength(text)); 	   
   	   }
   	   
   	   $('#registBtn').click(function() {
						
			const regexp = /^[0-9]*$/
			if($('#mbTitle').val().trim() === ''){
				alert('제목을 입력하세요')
				return;
			}else if(+($('#nowByte').text()) > 200)	{
				alert('제목은 200byte를 초과할 수 없습니다')
				return;
			} else if($('#mbContent').val().trim() === ''){ 
				alert('내용을 입력하세요.')
				return;
   	   		}else if(+($('#nowByte2').text()) > 2000){
				alert('내용은 2000byte를 초과할 수 없습니다.')
				return;
   	   		} else if($('#priceInput').val().trim() === ''){
	   	   		alert('가격을 입력해주세요')
				return;
	   	   			
			} else if(!regexp.test($('#priceInput').val())){
				alert('가격은 숫자만 입력가능합니다.');
				return;
   	   		} else if($('#sample6_address').val().trim() === ''){
				alert('주소를 입력해주세요.');
				return;
   	   		} else {
				$('#boardWrite').submit();
			}
	});
    
   	 
   	 //각 파일당, 전체 용량 확인 함수
       $("input[name=fileName]").off().on("change", function(){
     
          if(this.files || this.files[0] || this.files[1] || this.files[2] || this.files[3] || this.files[4] || this.files[5] || this.files[6] || this.files[7] || this.files[8] || this.files[9] != null) {
             var maxSize = 50 * 1024 * 1024;
             var totalSize = 0;
             
             if($('#uploadFiles')[0].files.length > 10) {
                alert('최대 사진 수는 10장입니다.');
                bool = false;
                return;
             }
             
             for(i=0; i<this.files.length; i++) {
                totalSize += this.files[i].size;
             }
                for(i=0; i<5; i++) {
                   if(this.files[0].size > 10 * 1024 * 1024){
                      alert('한 이미지의 허용 크기는 10MB입니다.');
                      this.files[i].remove();
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
     	   
     	 
    });
	  
    
    
</script>

   
</body>

</html>