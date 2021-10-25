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

.titlebox h2 {
	border-bottom: 1px solid rgb(0, 173, 181);
	margin: 20px 0px;
	padding-bottom: 20px;
	font-size: 40px;
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

.carousel-inner {
	height: 100%;
}
.carousel-inner>.item {
	height: 100%;
}

.carousel-inner>.item>img {
	top: 0;
	left: 0;
	min-width: 100%;
	min-height: 400px;
	text-align: center;
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

		/* 글 수정, 삭제 버튼*/
        .m {
           margin-left: -15px;
           margin-right: 20px;
        }
        
       .l {
           margin-right: 20px;
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
				
					<c:if test="${loginuser.memberNum == dietList.memberNum || loginuser.memberManagerYN == 'YES'}">
						<button type="button" class="btn btn-primary pull-right m" id="modifyBtn"
						onclick="location.href='<c:url value="/dietBoard/dietModify?dbNum=${dietList.dbNum}" />'">수정하기
					</button>
				</c:if>
				
				<button type="button" class="btn btn-primary pull-right l"
						onclick="location.href='<c:url value="/dietBoard/dietList?pageNum=${pc.paging.pageNum}&keyword=${pc.paging.keyword }&condition=${pc.paging.condition }&category=${pc.paging.category }&order=${pc.paging.order }" />'">목록으로</button>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div class="titlebox">
							<h2>${fn:replace(fn:replace(fn:replace(dietList.dbTitle,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") }</h2>
						</div>
					</div>
				</div>

			<c:if test="${dietList.dbImageCount > 0 }">
				<div class="row">
					<div class="container-fluid">
						<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="false">
							
							
							<ol class="carousel-indicators">
								<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
								<c:forEach var="pics" begin="1" end="${dietList.dbImageCount -1 }">
									<li data-target="#carousel-example-generic" data-slide-to="${pics}"></li>
								</c:forEach>
							</ol>

						
	                            <div class="carousel-inner" role="listbox">
	                            
	                            
	                            	<c:if test="${dietList.dbRealImage1 != null }">
		                                <div class="item active">
		                                    <img src="/upload/board/diet/${dietList.memberNick }/${dietList.dbRealImage1 }" width="100%" height="100%" alt="...">
		                                </div>
	                            	</c:if >
	                            	
	                            	
	                            	<c:if test="${dietList.dbRealImage2 != null }">
		                                <div class="item">
		                                    <img src="/upload/board/diet/${dietList.memberNick }/${dietList.dbRealImage2 }" width="100%" height="100%" alt="...">
		                                </div>
	                            	</c:if>
	                            	
	                            	
	                            	<c:if test="${dietList.dbRealImage3 != null }">
		                                <div class="item">
		                                    <img src="/upload/board/diet/${dietList.memberNick }/${dietList.dbRealImage3 }" width="100%" height="100%" alt="...">
		                                </div>
	                            	</c:if>
	                            	
	                            	
	                            	<c:if test="${dietList.dbRealImage4 != null }">
		                                <div class="item">
		                                    <img src="/upload/board/diet/${dietList.memberNick }/${dietList.dbRealImage4 }" width="100%" height="100%" alt="...">
		                                </div>
	                            	</c:if>
	                            	
	                            	
	                            	<c:if test="${dietList.dbRealImage5 != null }">
		                                <div class="item">
		                                    <img src="/upload/board/diet/${dietList.memberNick }/${dietList.dbRealImage5 }" width="100%" height="100%" alt="...">
		                                </div>
	                            	</c:if>
	                            	
	                                
	
	                            </div>

							<!-- Controls -->
							<a class="left carousel-control" href="#carousel-example-generic"
								role="button" data-slide="prev"> <span
								class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a> <a class="right carousel-control"
								href="#carousel-example-generic" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right"
								aria-hidden="true"></span> <span class="sr-only">Next</span>
							</a>
						</div>


					</div>
				</div>
			</c:if>
				<br>

				<div class="row">
					<div class="container-fluid">

						<table style="width: 100%">


							<tr>
								<td>작성일:&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${dietList.dbRegDate}"
										pattern="yyyy-MM-dd HH:mm" />
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${dietList.memberNick}
										
								</td>
								<td>
									<span class="glyphicon glyphicon-eye-open">
									</span>
									${dietList.dbLookCount}
								</td>
								<td>
									<c:if test="${loginuser != null }">
										<button id="lovelyBtn" class="btn btn-info pull-right">
											<span class="glyphicon glyphicon-heart"></span> <span id="countLovely">좋아요</span>
										</button>
									</c:if>
								</td>
							</tr>

							<tr>
								<td colspan="3">
									<p style="line-height: 150%;">${fn:replace(fn:replace(fn:replace(dietList.dbContent,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") }</p>
								</td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td>
									<c:if test="${loginuser != null }">
										<button id="reportBtn" class="btn btn-info pull-right">
											<span class="glyphicon glyphicon-thumbs-down"></span> <span id="countReport">신고하기</span>
										</button>

									</c:if>
								</td>
							</tr>

						</table>
					</div>
				</div>

			</div>
			<div class="col-md-4 col-sm-12 test">
				<div class="row">
					<span id="replyCountSpan" class="reply reply-count">댓글 :
						???개</span>
				</div>
				<div class="row">
                    
						<div><sup> ( <span id="nowByte">최대 </span> / 200bytes )</sup></div>
                        <div class="input-group input-group-lg">
                            <input id="replyInput" type="text" class="form-control" placeholder="댓글을 작성해주세요"
                                aria-describedby="basic-input">
                            <span class="input-group-btn" id="basic-input">
                                <button id="replyBtn" type="button" class="btn btn-default"><span
                                        class="glyphicon glyphicon-send"></span></button>
                            </span>
                        </div>
                   	
                </div>

				<div id="replyList" class="row container-fluid"></div>
				<!-- <button class="form-control" id="moreList">더보기</button> -->
			</div>
		</div>



		<div class="row">
			<%@ include file="../../include/footer.jsp"%>
		</div>


	</div>

	<script defer>
		function sleep(ms) {
			const wakeUpTime = Date.now() + ms;
			while (Date.now() < wakeUpTime) {
			}
		}

		replyLoad(1, true);

		
		
		
		// 댓글입력
		function replyRegist() {
			if (${loginuser == null ? true : false}) {
				alert('댓글 등록 - 로그인을 하세요!'); 
				$('#replyInput').val('');
				$('#nowByte').text('최대');
				return;
			} else if(+($('#nowByte').html())>200){
				alert('댓글은 200바이트 초과해서 입력할 수 없습니다.');
				$('#replyInput').val('');
				$('#nowByte').text('최대');
				$('#replyInput').focus();
				return;
			}

			$.ajax({
				type : "post",
				url : "<c:url value='/dietReply/replyRegist' />",
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					"memberNum" : '${loginuser.memberNum}',
					"drContent" : $('#replyInput').val(),
					"dbNum" : '${dietList.dbNum}'
				}),
				success : function(data) {
					console.log('데이터 통신 성공' + data);
					//댓글 목록 불러오기
					replyLoad(1, true);
					$('#nowByte').text('최대');
					alert('댓글등록완료!');
				},
				error : function(request, status, error) {
					alert('등록 통신 실패! 관리자에게 문의하세요.');
					console.log("code" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error" + error);
				}
			}); //비동기통신 종료 

		} // 댓글입력 종료 

		/*
		//더보기 버튼 이벤트 처리
		$('#moreList').click(function() {
			replyLoad(page++ , false); //페이지 수만 늘리고 false값을 줘서 (더보기니까) 댓글을 누적한다.
			
		});//더보기버튼 함수 종료
		 */

		let page = 1;
		let strAdd = "";
		countLovely();

		//무한 스크롤
		$(document).ready(
				function() {

					$('.test:last-child .input-group').css("width",
							$('.test:last-child').width() * 0.9);
					replyLoad(1, true);
					pageNum = 2;

				});
		$(window).resize(
				function() {
					$('.test:last-child .input-group').css("width",
							$('.test:last-child').width() * 0.9);
				});

		$('.test:last-child')
				.scroll(
						function() {

							let replyTotalHeight = 0;
							let count = 0;

							$('.test:last-child >.row').each(
									function() {
										replyTotalHeight = replyTotalHeight
												+ $(this).height()
										count++;
									});
							if ($('.test:last-child').scrollTop()
									+ $('.test:last-child').height() >= replyTotalHeight) {
								replyLoad(pageNum, false);
								pageNum = pageNum + 1;
							}
							console.log(count);

						});//무한 스크롤 종료

		//댓글 목록 불러오기 요청 (페이징)
		function replyLoad(pageNum, reset) {

			const dbNum = '${dietList.dbNum}';

			$
					.getJSON(
							"<c:url value='/dietReply/replyList/' />" + dbNum
									+ '/' + pageNum,

							function(data) {

								let total = data.total; //총 댓글 수
								console.log('총 댓글 갯수' + total);
								$('#replyCountSpan').html(
										'댓글 :' + data.total + '개');
								let Data = data.list; //댓글 리스트

								if (total <= page * 10) {
									$('#moreList').css('display', 'none');
								} else {
									$('#moreList').css('display', 'block');
								}

								if (reset === true) {
									strAdd = '';
								}

								

								let loginuserName = '${loginuser.memberNick!=null? loginuser.memberNick:''}';
								let content = '';
								for (let i = 0; i < Data.length; i++) {
									content = Data[i].drContent.replace(/>/g,"&gt;").replace(/</g,"&lt;").replace(/\n/g,"<br/>");
									strAdd += '<div class="row reply-item" style="display:none;">';
									strAdd += '<div class="reply reply-box">';
									strAdd += '<span class="reply-writer">'
											+ Data[i].memberNick
											+ '</span> <small>'
											+ timeStamp(Data[i].drRegDate)
											+ '</small>'
											if (Data[i].memberNick == "${loginuser.memberNick}" || ${loginuser.memberManagerYN == "YES"}) {
										strAdd += '&nbsp;&nbsp;&nbsp;&nbsp;<span class="mod-del"><small class="replyModBtn'+Data[i].drNum+'">수정</small> <small class="replyDelBtn'+Data[i].drNum+'">삭제</small></span>'
										
									}
									strAdd += '<br><br><span class="reply-content">'
											+ content + '</span>'
									strAdd += '</div>';
									strAdd += '</div>';
								}
								$('#replyList').html(strAdd);
								$('.reply-item').fadeIn(500);
							}

					); // end getJSON

		} // 댓글불러오기 함수 종료
	
		
		let boolRegist = true; //댓글의 등록이냐 수정이냐를 판가름 해줄 불린타입의 변수
		let frClassName = '';

		
		//댓글 등록버튼 등록&수정 여부 판가름 코드
		
		$('#replyBtn').click(function() {
			if (boolRegist) {
				replyRegist();
				$('#replyInput').val('');
			} else {
				replyModify(frClassName);
				$('#replyInput').val('');
			}
		});
		$('#replyInput').keydown(function(e) {
			if (e.keyCode === 13) {
				if (boolRegist) {
					replyRegist();
					$('#replyInput').val('');
				} else {
					replyModify(frClassName);
					$('#replyInput').val('');
				}
			}
		})

		//댓글 수정 & 삭제
		$('#replyList').click(function(e) {
			if(e.target.className.indexOf('replyModBtn') != -1) {
				$('#replyInput').val($(e.target).parent('.mod-del').nextAll('.reply-content').html());
				$('#nowByte').html(getTextLength($('#replyInput').val()));
				boolRegist = false;
				frClassName = $(e.target).attr('class');
			}
			if(e.target.className.indexOf('replyDelBtn') != -1) {
				if(${loginuser == null ? true : false}) {
					alert('댓글수정&삭제 - 로그인하세요!');
					return;
				}
				const arr = {
						"memberNum" : '${loginuser.memberNum}',
						"drNum" : e.target.className
				}
				$.ajax({
					type : "post",
					url : "<c:url value='/dietReply/dietReplyDelete' />",
					headers: {
						"Content-Type" : "application/json"
					},
					data: JSON.stringify(arr),
					success : function(data) {
						console.log('통신성공' + data);
						if(data === "success") {
							alert('삭제 완료');
							replyLoad(1, true);
							pageNum = 2;
							$('#replyInput').val('');
						}
					},
					error : function() {
						console.log('삭제 통신 실패!')
					}
				}); // 비동기통신 종료
			}
		}); //댓글 수정 & 삭제 종료
		

		// 댓글 수정함수
		function replyModify(frClassName) {
			if (${loginuser == null ? true : false}) {
				alert('댓글 수정 - 로그인을 하세요!');
				return;
			}

			$.ajax({
				type : "post",
				url : "<c:url value='/dietReply/dietReplyModify' />",
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					"memberNum" : ${loginuser != null? loginuser.memberNum:-1},
					"drContent" : $('#replyInput').val(),
					"drNum" : frClassName
				}),
				success : function(data) {
					console.log('통신 성공' + data);
					alert('댓글 수정 완료');
					replyLoad(1, true);
					pageNum = 2;
				},
				error : function(request, status, error) {
					alert('수정 통신에 실패했습니다. 관리자에게 문의하세요');
					console.log("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}

			}); // 비동기통신 종료
			boolRegist = true;
			frClassName = '';
			replyLoad(1, true);
			pageNum = 2;
		} // 댓글 수정 종료

		function replyCount() {
			$.ajax({
						type : "GET",
						url : "<c:url value='/dietBoard/replyCount?dbNum=${dietList.dbNum}' />",
						success : function(data) {
							console.log('통신성공!' + data);
							$('replyCountSpan').html('댓글:' + data + '개');
						},
						error : function(request, status, error) {
							alert('조회수 통신에 실패했습니다. 관리자에게 문의하세요');
							console.log("code:" + request.status + "\n"
									+ "message:" + request.responseText + "\n"
									+ "error:" + error);
						}
					}); //비동기 통신 끝
		} //replyCount() 끝

		//좋아요 버튼 함수
		$('#lovelyBtn').click(function() {
			
			const arr = {
				"dbNum" : '${dietList.dbNum}',
				"memberNum" : '${loginuser.memberNum == null ? -1 :loginuser.memberNum}'
			};
			$.ajax({
				type : "post",
				url : "<c:url value='/dietBoard/dietLikely' />",
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify(arr),
				success : function(data) {
					console.log('데이터 통신 성공!' + data);
					if (data === 'success') {
						countLovely();
					} else {
						countLovely();
					}
				},
				error : function() {
					alert('좋아요 통신에 실패했습니다. 관리자에게 문의하세요');
				}
			}); //좋아요 비동기 종료
		}); //좋아요 함수 종료

		
		//좋아요 숫자카운트
		function countLovely() {
			const dbNum = "${dietList.dbNum}";
			
			$.getJSON (
				"<c:url value='/dietBoard/' />" + dbNum,
				
				function (data) {
					let count = data;
					$('#countLovely').html(count);
				}
			)
		} //좋아요 숫자카운트 끝
		
		//신고 숫자 카운트
		function countReport() {
			const dbNum = "{$dietList.dbNum}";
			$.getJSON (
				"<c:url value='/dietBoard/countReport' />" + dbNum,
				function (data) {
					let count = data;
					$('#countReport').html(count);
				}
			)
		}
		
		//신고버튼 함수
		$('#reportBtn').click(function() {

			const arr = {
				"dbNum" : '${dietList.dbNum }',
				"memberNum" : '${loginuser.memberNum }'
			};
			$.ajax({
				type : "POST",
				url : "<c:url value='/dietBoard/dietReport' />",
				headers : {
					"Content-Type" : "application/json"
				},
				data : JSON.stringify(arr),
				success : function(data) {
					console.log('통신성공!' + data);
					if (data === 'success') {
						countReport();
					} else {
						countReport();
					}
				},
				error : function() {
					alert('신고하기 통신에 실패했습니다. 관리자에게 문의하세요');
				}
			}); //신고 비동기 처리 끝
		}); // 신고 함수 끝
		

		


		// 날짜 처리 함수
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
				time = year + "-" + month + "-" + day + " " + hour + ":"
						+ minute + "";

			}
			return time;
		}
		//댓글 내용 byte 체크
		$('#replyInput').keyup(function(){
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
	</script>

</body>

</html>







