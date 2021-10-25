<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<% pageContext.setAttribute("replaceChar", "\n"); %>
<% pageContext.setAttribute("replaceChar1", "<"); %>
<% pageContext.setAttribute("replaceChar2", ">"); %>

<!DOCTYPE html>


<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
#carousel-example-generic {
            /* 케러셀(이미지 슬라이드) 높이 고정 및 배경색 조정*/
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
        }
.titlebox h2 {
	border-bottom: 1px solid rgb(0, 173, 181);
	margin: 20px 0px;
	padding-bottom: 20px;
	font-size: 20px;
	font-weight: bold;
	color: rgb(0, 173, 181);
}

table tr td {
	padding: 15px;
	border-bottom: 1px solid #ccc;
}

.titlefoot {
	float: right;
	margin: 20px;
}

.video-wrap {
	position: relative;
	padding-bottom: 56.25%;
	padding-top: 30px;
	height: 0;
	overflow: hidden;
}

.video-wrap iframe, .video-wrap object, .video-wrap embed {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.carousel-inner>.item>img {
	top: 0;
	left: 0;
	min-width: 100%;
	min-height: 400px;
}

#carousel-example-generic {
	/* 케러셀(이미지 슬라이드) 높이 고정 및 배경색 조정*/
	height: 100%;
	background-color: rgba(0, 0, 0, 0.8);
}

.test {
	height: 1000px;
	overflow: auto;
}

.test:last-child .row {
	margin-top: 20px;
	margin-left: 20px .;
}

.reply {
            font-size: 20px;
            font-weight: 600;
        }

        .reply small {
            font-size: 15px;
            font-weight: 400;
        }

        .reply-box {
            padding-bottom: 20px;
            border-bottom: 1px solid #ccc;
            overflow:hidden;
        }
        
        .mod-del{
        	float: right;
        	margin-right: 10px;
        }
        .mod-del > small {
        	cursor: pointer;
        	font-size: 13px;
        }
        
        .reply-box small {
        	font-size:13px;
        }
        
        .reply-content {
        	font-size: 15px;
        	font-weight: normal;
        }
</style>
</head>

<body>

	<div class="container-fluid h-100">

		<div class="row">
			<%@ include file="../../include/header.jsp"%>
		</div>

		<div class="container-fluid">
			<div class="col-md-8 col-sm-12 test">
				<div class="row">
					<c:if test="${loginuser.memberNick == placeList.memberNick || loginuser.memberManagerYN == 'YES' }">
						<button type="button" class="btn btn-primary pull-right"
							onclick="location.href='<c:url value="/placeBoard/placeModify?pbNum=${placeList.pbNum}" />'">수정하기</button>
					</c:if>
					<button type="button" class="btn btn-primary pull-right"
						onclick="location.href='<c:url value="/placeBoard/placeList?pageNum=${pc.paging.pageNum }&keyword=${pc.paging.keyword }&condition=${pc.paging.condition }&category=${pc.paging.category }&latitude=${(loginuser!=null && loginuser.memberLatitude!=null)? loginuser.memberLatitude:0.0 }&longitude=${(loginuser!=null && loginuser.memberLongitude!=null)? loginuser.memberLongitude:0.0 }&distance=${pc.paging.distance }&order=${pc.paging.order }" />'">목록으로</button>
				</div>


				<div class="row">
					<div class="col-sm-12">
						<div class="titlebox">
							<h2>[${placeList.pbCategory}]
							${fn:replace(fn:replace(fn:replace(placeList.pbTitle,replaceChar2,"&gt;" ),
								replaceChar1,"&lt;"),replaceChar,"<br/>") }</h2>
						</div>
					</div>
				</div>

				<c:if test="${placeList.pbImageCount > 0 }">
					<div class="row">
						<div class="container-fluid">
							<div id="carousel-example-generic" class="carousel slide"
								data-ride="carousel" data-interval="false">
								<!-- Indicators -->
								<ol class="carousel-indicators">
									<li data-target="#carousel-example-generic" data-slide-to="0"
										class="active"></li>
									<c:forEach var="index" begin="1"
										end="${placeList.pbImageCount-1}">
										<li data-target="#carousel-example-generic"
											data-slide-to="${index}"></li>
			                        </c:forEach>
								</ol>

								<!-- Wrapper for slides -->
								<div class="carousel-inner" role="listbox">
									<c:if test="${placeList.pbRealImage1 != null }">
										<div class="item active">
											<img
												src="/upload/board/place/${placeList.memberNick }/${placeList.pbRealImage1 }"
												width="100%" alt="...">
										</div>
									</c:if>

									<c:if test="${placeList.pbRealImage2 != null }">
										<div class="item">
											<img
												src="/upload/board/place/${placeList.memberNick }/${placeList.pbRealImage2 }"
												width="100%" alt="...">
										</div>
									</c:if>

									<c:if test="${placeList.pbRealImage3 != null }">
										<div class="item">
											<img
												src="/upload/board/place/${placeList.memberNick }/${placeList.pbRealImage3 }"
												width="100%" alt="...">
										</div>
									</c:if>

									<c:if test="${placeList.pbRealImage4 != null }">
										<div class="item">
											<img
												src="/upload/board/place/${placeList.memberNick }/${placeList.pbRealImage4 }"
												width="100%" alt="...">
										</div>
									</c:if>

									<c:if test="${placeList.pbRealImage5 != null }">
										<div class="item">
											<img
												src="/upload/board/place/${placeList.memberNick }/${placeList.pbRealImage5 }"
												width="100%" alt="...">
										</div>
									</c:if>
								</div>

								<!-- Controls -->
								<a class="left carousel-control"
									href="#carousel-example-generic" role="button"
									data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
									<span class="sr-only">Previous</span>
								</a> <a class="right carousel-control"
									href="#carousel-example-generic" role="button"
									data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
									<span class="sr-only">Next</span>
								</a>
							</div>
						</div>
					</div>
				</c:if>
				<br>

				<div class="row">
					<div class="container-fluid">

						<!-- 시설 표시된 지도.. -->
						<div id="map" style="width: 100%; height: 350px;"></div>

						<table style="width:100%">
							<tr>
								<td>작성일  :  <fmt:formatDate value="${placeList.pbRegDate}" pattern="yyyy-MM-dd HH:mm"/></td>
								<td><span class="glyphicon glyphicon-eye-open"></span>  ${placeList.pbLookCount}</td>
								<td>
									<button id="likeBtn" class="btn btn-info pull-right">
										<span class="glyphicon glyphicon-heart"></span>&nbsp;<span id="countLike">좋아요</span>
									</button>
								</td>
							</tr>
							
							<tr>
								<td colspan="2">주소 :  ${placeList.pbAddrBasic} ${placeList.pbAddrDetail}</td>
								<td><a href="https://map.kakao.com/link/to/${placeList.pbAddrBasic},${placeList.pbLatitude},${placeList.pbLongitude}">
										<button class="btn btn-info pull-right">길찾기</button></a></td>
							</tr>

							<tr>
								<td colspan="3">
									<p style="line-height: 150%;">${fn:replace(fn:replace(fn:replace(placeList.pbContent,replaceChar2,"&gt;"),
									replaceChar1,"&lt;"),replaceChar,"<br/>") }</p></td>
							</tr>
							
							<tr>
								<td></td>
								<td></td>
								<td><c:if test="${loginuser != null }">
										<button id="reportBtn" class="btn btn-info pull-right">
											<span class="glyphicon glyphicon-thumbs-down"></span> 신고하기
										</button></c:if></td>
							</tr>

						</table>
					</div>
				</div>

			</div>

			<!-- 댓글창 -->
			<div class="col-md-4 col-sm-12 test">

				<div class="row">
					<span id="replyCountSpan" class="reply reply-count">댓글 :
						???개</span>
				</div>

				<div class="row">
					<div><sup> ( <span id="nowByte">최대 </span> / 200bytes )</sup></div>
						<div class="input-group input-group-lg">
							<input type="text" id="replyInput" class="form-control"
								placeholder="댓글을 작성해주세요" aria-describedby="basic-input">
							<span class="input-group-btn" id="basic-input">
								<button id="replyBtn" type="button" class="btn btn-default">
									<span class="glyphicon glyphicon-send"></span>
								</button>
							</span>
						</div>
				</div>

				<div id="replyList" class="row container-fluid"></div>

			</div>
		</div>

		<div class="row">
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>

	<script defer>
		let strAdd = '';
	   	let pageNum = 2;
	   	let boolRegist = true;
	   	let prClassName = '';
       function sleep(ms) {
           const wakeUpTime = Date.now() + ms;
           while (Date.now() < wakeUpTime) { }
       }
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
     } // 바이트 체크 함수
	       
	   
		//댓글 목록 페이징 처리
		function replyLoad(pageNum, reset){
        	$.getJSON(
        		"<c:url value='/placeReply/placeReplyList/${placeList.pbNum}/' />" + pageNum,
        		function(data){
        			console.log(data);
        			$('#replyCountSpan').html('댓글 :'+data.total+'개');
                    if(reset === true){
                        strAdd='';
                    }
                    let loginuserName = "${loginuser.memberNick!=null? loginuser.memberNick:''}";
                    const manager = "${loginuser !=null? loginuser.memberManagerYN:''}";
                    let content = '';
        			for (let i = 0; i < data.list.length; i++) {
        				content = data.list[i].prContent.replace(/>/g,"&gt;").replace(/</g,"&lt;").replace(/\n/g,"<br/>");
                        strAdd += '<div class="row reply-item" style="display:none;">';
                        strAdd += '<div class="reply reply-box">';
                        strAdd += '<span class="reply-writer">'+data.list[i].memberNick+'</span> <small>'+timeStamp(data.list[i].prRegDate)+'</small>'
                        if(data.list[i].memberNick === loginuserName || manager === 'YES'){
	                        strAdd += '&nbsp;&nbsp;&nbsp;&nbsp;<span class="mod-del"><small class="replyModBtn'+data.list[i].prNum+'">수정</small> <small class="replyDelBtn'+data.list[i].prNum+'">삭제</small></span>'
                        }
                        strAdd += '<br><br><span class="reply-content">'+content+'</span>'
                        strAdd += '</div>';
                        strAdd += '</div>';
                    }
                    $('#replyList').html(strAdd);
                    $('.reply-item').fadeIn(500);
        		}	
        	); // end getJson
        }
       
    	//날짜 처리 함수
       function timeStamp(millis) {
           const date = new Date(); //현재 날짜
           // 현재 날짜를 밀리초로 변환 - 등록일 밀리초 -> 시간차
           const gap = date.getTime() - millis;
           // 댓글1시간전 담 -> 방금전, 댓글 하루전 -> 몇시간전, 하루이상 2021-08-13
           let time; // 리턴할 시간
           if (gap < 60 * 60 * 24 * 1000) { // 1일 미만인 경우
               if (gap < 60 * 60 * 1000) { //1시간 미만일 경우
                   time = '방금 전';
               } else {
                   time = parseInt(gap / (60 * 60 * 1000)) + "시간 전";
               }
           } else { //1일 이상일경우
               const today = new Date(millis);
               const year = today.getFullYear(); //년
               const month = today.getMonth() + 1; //월
               const day = today.getDate(); //일
               const hour = today.getHours(); // 시
               const minute = today.getMinutes(); // 분
               time = year + "년" + month + "월" + day + "일" + hour + "시" + minute + "분";

           }
           return time;
       }
       
    
     	
	    
	    //댓글 목록
	    $(document).ready(function () {
	    	countLike();
        $('.test:last-child .input-group').css("width", $('.test:last-child').width() * 0.9);
           replyLoad(1,true);
           pageNum=2;
        });
	    
	    $(window).resize(function () {
            $('.test:last-child .input-group').css("width", $('.test:last-child').width() * 0.9);
        });
        $('.test:last-child').scroll(function () {
            /*
                document height -> 모든 row들의 높이 합
                문서 전체의 높이를 의미합니다.
                window height -> div.test의 높이
                화면의 높이를 의미합니다.
                scroll top
                스크롤의 top이 위치하고 있는 높이를 의미합니다
                
            */
            let replyTotalHeight = 0;
            let count=0;
            
            $('.test:last-child >.row').each(function () {
                replyTotalHeight = replyTotalHeight + $(this).height()
                count++;
            });
            if ($('.test:last-child').scrollTop() + $('.test:last-child').height() >= replyTotalHeight) {
                // 로딩이미지 보여주기
                // $('.test:last-child').append(`
                //     <div id="loadingImg" class="row">
                //         <img src="${pageContext.request.contextPath }/resources/img/load.gif" alt="">
                //     </div>
                // `);
                // $('#loadingImg').remove();
                replyLoad(pageNum,false);
                pageNum = pageNum+1;
            }
            console.log(count);

            // console.log($('.test:last-child').scrollTop()+","+$('.test:last-child').height()+","+)
        });
        // $(window).scroll(function(){
        //     if($(window).scrollTop()+$(window).height()+1 >= $(document).height()){
        //         console.log('스크롤 하단 감지');
        //     }
        // });
	    
	  //댓글 버튼 클릭 시 
		$('#replyBtn').click(function(){
	    	if(boolRegist){
	        	replyRegist();
	        	$('#replyInput').focus();
	    	} else {
	    		placeReplyModify(prClassName);
	    		$('#replyInput').focus();
	    	}  
	    });
	    $('#replyInput').keyup(function(e){
	    	if(e.keyCode === 13){
	    		$('#replyBtn').click();
	    		
	    	} else {
	    		$('#nowByte').html(getTextLength($('#replyInput').val()));
	    	}
	    });
	    
	    //댓글 등록
	    function replyRegist(){
	    	
			if(${loginuser==null? true:false}){
				alert('로그인이 필요합니다.');
				return;
			} else if(+($('#nowByte').html())>200){
				alert('댓글 내용은 200바이트를 초과할 수 없습니다.');
				return;
			}
			
			
        	$.ajax({
                type: "POST",
                url: "<c:url value='/placeReply/replyRegist' />",
                headers:{
                    "Content-Type":"application/json"
                },
                data: JSON.stringify({
                    "memberNum":${loginuser.memberNum==null? -1:loginuser.memberNum},
                    "prContent":$('#replyInput').val(),
                    "pbNum":${placeList.pbNum}
                }),
                dataType: "text",
                success: function (data) {
                    console.log('통신성공!' + data);	
            		       		
            		replyLoad(1,true);
            		$('#nowByte').text('최대');
            		alert('댓글이 등록되었습니다.');
            		pageNum=2;
                },
                error: function (request, status, error) {
                    alert('통신에 실패했습니다. 관리자에게 문의하세요');
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            }); //비동기 처리 끝
        	$('#replyInput').val('');
        }
	    
	    //댓글 수정 시
	    function placeReplyModify(prClassName){
			if(${loginuser==null? true:false }){
				alert('로그인이 필요합니다.');
				return;
			} else if(+($('#nowByte').html())>200){
				alert('댓글 내용은 200바이트를 초과할 수 없습니다.');
				return;
			}
			
        	$.ajax({
                type: "POST",
                url: "<c:url value='/placeReply/placeReplyModify' />",
                headers:{
                    "Content-Type":"application/json"
                },
                data: JSON.stringify({
                    "memberNum":${loginuser.memberNum==null? -1:loginuser.memberNum },
                    "prContent":$('#replyInput').val(),
                    "prNum":prClassName
                }),
                dataType: "text",
                success: function (data) {
                    console.log('통신성공!' + data);	
            		       		
            		replyLoad(1,true);
            		pageNum=2;
            		alert('댓글 수정 완료');
                },
                error: function (request, status, error) {
                    alert('통신에 실패했습니다. 관리자에게 문의하세요');
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
            }); //비동기 처리 끝
        	boolRegist = true;
            prClassName = '';
            replyLoad(1,true);
            pageNum=2;
            $('#replyInput').val('');
		}

	    $('#replyList').click(function(e){
    		if(e.target.className.indexOf('replyModBtn') != -1){
    			$('#replyInput').val($(e.target).parent('.mod-del').nextAll('.reply-content').html());
    			$('#nowByte').html(getTextLength($('#replyInput').val()));
    			$('#replyInput').focus();
    			boolRegist = false;
    			prClassName = $(e.target).attr('class');
    		}
    		if(e.target.className.indexOf('replyDelBtn') != -1){
    			if(${loginuser==null? true:false}){
    				return;
    			}
    			const arr = {
   					"memberNum": ${loginuser.memberNum==null? -1:loginuser.memberNum },
                   	"prNum": e.target.className	
    			}
    			$.ajax({
                    type: "POST",
                    url: "<c:url value='/placeReply/placeReplyDelete' />",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                    data: JSON.stringify(arr),
                    success: function (data) {
                        console.log('통신성공!' + data);
                      	if(data==="success"){
                      		$('#replyInput').val('');
                      		$('#nowByte').html('최대');
                      		alert('삭제 완료했습니다.');
			    			replyLoad(1,true);
			    			pageNum=2;
			    			
                      	} 
                    },
                    error: function () {
                        alert('통신에 실패했습니다. 관리자에게 문의하세요');
                    }
                });
    		}
    	});
	    
	 	// 좋아요 처리
        $('#likeBtn').click(function() {
        	
			if(${loginuser==null? true:false}){
				alert('로그인이 필요합니다.');
				return;
			}
			
        	const pbNum = ${placeList.pbNum};
        	const memberNum = ${loginuser.memberNum == null ? -1 :loginuser.memberNum};
        	
        	$.ajax({
                type: "POST",
                url: "<c:url value='/placeBoard/placeLike' />",
                headers: {
                    "Content-Type": "application/json"
                },
                dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                data: JSON.stringify({
        			"pbNum" : pbNum,
        			"memberNum" : memberNum
        		}),
                success: function (data) {
                  	if(data === "likeSuccess"){    		
                  		//alert('좋아요');
                  		countLike();
                  	} else {  		
                  		//alert('좋아요 취소');
                  		countLike();
                  	}
                },
                error: function() {
                    alert('통신에 실패했습니다. 관리자에게 문의하세요');
                }
            }); // end ajax
        	
        }); // 좋아요 처리 끝
        
            
        
        
        
     	// 좋아요 개수 출력
       function countLike() {
        	          	
			const pbNum = "${placeList.pbNum}";
        	$.getJSON(
        		"/wefit/placeBoard/" + pbNum,
        		function(data) {           			
        			let count = data.count;

        			//좋아요 개수 출력
        			$('#countLike').html(count);
        		
        		} // end function(data)         			
        	)//end getJSON
        } //countLike 함수 끝
	
		//신고 처리
        $('#reportBtn').click(function(){
    		if(${loginuser==null? true:false}){
				alert('로그인이 필요합니다.');
				return;
			}
    		const arr = {
    			"pbNum" : ${placeList.pbNum},
    			"memberNum" : ${loginuser.memberNum==null? -1:loginuser.memberNum }
    		};
    		$.ajax({
                type: "POST",
                url: "<c:url value='/placeBoard/placeReport' />",
                headers: {
                    "Content-Type": "application/json"
                },
                dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                data: JSON.stringify(arr),
                success: function (data) {
                    console.log('통신성공!' + data);
                  	if(data==="success"){
                  		alert('신고 완료했습니다.');
                  	} else{
                  		alert('이미 신고를 하셨습니다.')
                   	}
                },
                error: function () {
                    alert('통신에 실패했습니다. 관리자에게 문의하세요');
                }
            }); //신고  비동기 처리 끝
        });
        
        
        // 카카오 지도 api
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng('${placeList.pbLatitude}', '${placeList.pbLongitude}'), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };  

	    // 지도를 생성합니다    
	    var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	    // 주소-좌표 변환 객체를 생성합니다
	    var geocoder = new kakao.maps.services.Geocoder();
	
	    // 주소로 좌표를 검색합니다
	    geocoder.addressSearch('${placeList.pbAddrBasic}', function(result, status) {
	
	        // 정상적으로 검색이 완료됐으면 
	         if (status === kakao.maps.services.Status.OK) {
	
	            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	            // 결과값으로 받은 위치를 마커로 표시합니다
	            var marker = new kakao.maps.Marker({
	                map: map,
	                position: coords
	            });
	
	            // 인포윈도우로 장소에 대한 설명을 표시합니다
	            var infowindow = new kakao.maps.InfoWindow({
	                content: '<div style="width:150px;text-align:center;padding:6px 0;">시설위치</div>'
	            });
	            infowindow.open(map, marker);
	
	            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	            map.setCenter(coords);
	        } 
	    });    

	</script>


</body>

</html>