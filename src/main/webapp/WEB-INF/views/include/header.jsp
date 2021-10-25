<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WeFit</title>
    <!--reset.css (css 초기화)-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	64d6e725e286fedd8e4a806ec1c57025&libraries=services"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
    
    <style>
        /* 부트스트랩 메뉴바설정  */
        .navbar {
            min-height: 130px;
        }

        .navbar a {
            font-size: 20px;
            font-weight: 800;
        }

        .navbar > .container-fluid > .collapse {
            padding-top: 80px;
            padding-left: 250px;

        }

        .navbar>.container-fluid>.navbar-header>button {
            height: 120px;
            width: 120px;
        }

        .navbar>.container-fluid>.navbar-header>button>span {
            margin: 0 auto;
            margin-bottom: 25px;
            width: 70px;
            height: 10px;
        }

        .navbar>.container-fluid>.navbar-header>button>span:first-child {
            margin-top: 30px;
        }

        .navbar>.container-fluid>.navbar-header>button>span:last-child {
            margin-bottom: 0px;
        }
    </style>

</head>

<body>
    <!-- 부트스트랩 메뉴바 -->
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- 메뉴에서 가장 왼쪽, 모바일에서 표시되는 제목 -->
            <div class="navbar-header">
                <!-- 모바일때 표시되는 메뉴 버튼(PC 버젼에서는 보이지 않는다.)  -->
                <button type="button" class="navbar-toggle collapsed btn btn-lg" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!-- 메뉴의 홈페이지 이름 -->
                <a class="navbar-brand" href="<c:url value='/' />"><img src="${pageContext.request.contextPath }/resources/img/logo/logo2.png"
                        width="230px" alt="logo"></a>
            </div>

            <!-- 메뉴의 리스트 -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <!-- Link 메뉴 (class가 active가 포함되어 있기 때문에 선택된 메뉴 뜻) -->
                    <li><a id="menuPlace" href="<c:url value='/placeBoard/placeList' />">장소찾기 </a></li>
                    <li><a id="menuCourse" href='<c:url value='/courseBoard/?category=' />'>운동강의</a></li>
                    <li><a id="menuDiet" href="<c:url value='/dietBoard/dietList' />">오늘의 식단</a></li>
                    <li><a id="menuMarket" href="<c:url value='/marketBoard/market_board' />">장터</a></li>
                    <li><a id="menuNotice" href="<c:url value='/noticeBoard/' />">공지사항</a></li>
                    <li><a id="menuFree" href="<c:url value='/freeBoard/' />">자유게시판</a></li>
                </ul>

                <!-- 오른쪽 정렬의 메뉴 -->
                <ul class="nav navbar-nav navbar-right">
                    <!-- Link 메뉴 -->

                    
                    <li class="dropdown">
                    	<c:if test="${loginuser == null }">
	                    	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
	                            aria-expanded="false">로그인하기 <span class="caret"></span></a>
	                    </c:if>
                        <c:if test="${loginuser != null }">
	                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
	                            aria-expanded="false">${loginuser.memberNick }님 <span class="caret"></span></a>
	                    </c:if>
                        <ul class="dropdown-menu">
                            <li><a id="geoLink"><span id="centerAddr" class="glyphicon glyphicon-map-marker"
                                        aria-hidden="true">${loginuser.memberLatitude==null||loginuser.memberLatitude==0.0? '내위치 추가':loginuser.memberLatitude }</span></a></li>
                            <li role="separator" class="divider"></li>
                    		 
	                     	<c:if test="${loginuser != null }">
	                            <li><a><span class="glyphicon glyphicon-pencil"
	                                        aria-hidden="true" data-toggle="modal" data-target="#modal-infochange">&nbsp;회원정보변경</span></a></li>
	                            <li><a href="<c:url value='/user/logout'/>"><span class="glyphicon glyphicon-log-out"
	                                        aria-hidden="true">&nbsp;로그아웃</span></a></li>
	                    	</c:if>
		                    <c:if test="${loginuser == null }">
	                            <li><a href="#" data-toggle="modal" data-target="#modal-login"><span class="glyphicon glyphicon-pencil"
	                                        aria-hidden="true">&nbsp;로그인</span></a></li>
	                            <li><a href="#"><span class="glyphicon glyphicon-log-out"
	                                        aria-hidden="true" data-toggle="modal" data-target="#modal-join">&nbsp;회원가입</span></a></li>
		                    </c:if>
                        </ul>
                    </li>
                  
                    
                </ul>
            </div>
        </div>
    </nav>






    <!-- Modal login창 -->
    <div id="modal-login" class="modal fade">
        <div class="modal-dialog">

            <!-- Modal Content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">로그인</h4>
                </div>
                <div class="modal-body">


                    <form action="<c:url value="/user/login" />" method="post" id="form-login" class="form-horizontal">

                        <div class="form-group">
                            <label for="login-email" class="col-sm-3 control-label">이메일</label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control" id="login-email" name="memberEmail" placeholder="이메일을 입력해주세요">
                            </div>

                        </div>
                       
                        <div class="form-group">
                            <label for="login-password" class="col-sm-3 control-label">비밀번호</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="login-password" name="memberPasswd"

                                    placeholder="비밀번호를 입력해주세요">
                            </div>

                        </div>
                        <div class="form-group">
                            <label for="auto-login-check" class="col-sm-3 control-label">자동로그인</label>
                            <div class="col-sm-1">


                                <input type="checkbox" class="form-control" id="auto-login-check" name="autoLoginCheck">


                            </div>

                        </div>


                    </form>


                </div>
                <div class="modal-footer">


                    <button type="button" class="btn btn-info" data-dismiss="modal" id="loginBtn">로그인</button>

                    <button type="button" class="btn btn-default" data-dismiss="modal" data-toggle="modal" data-target="#modal-pwsearch" >비밀번호 찾기</button>
                </div>


            </div>
        </div>
    </div>
    <!-- Modal join창-->


    <div  id="modal-join" class="modal fade">

        <div class="modal-dialog">

            <!-- Modal Content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">회원가입</h4>
                </div>
                <div class="modal-body">


                    <form id="form-join" action="<c:url value='/user/join' />" method="post" role="form" class="form-horizontal">
                        <div class="form-group">
                            <label for="memail" class="col-sm-3 control-label">이메일</label>
                            <div class="col-sm-6">
                                <input type="email" class="form-control" id="join-email" name="memberEmail" placeholder="이메일을 입력해주세요">
                            </div>
                            <div class="col-sm-3">
                                <button id="emailCheckBtn" type="button" class="form-control">이메일확인</button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="mnick" class="col-sm-3 control-label">닉네임</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="join-nick" name="memberNick" placeholder="닉네임을 입력해주세요">
                            </div>
                            <div class="col-sm-3">
                                <button id="nickCheckBtn" type="button" class="form-control">닉네임확인</button>

                            </div>

                        </div>
                        <div class="form-group">


                            <label for="mpasswd" class="col-sm-3 control-label">비밀번호</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="join-passwd" name="memberPasswd"

                                    placeholder="비밀번호를 입력해주세요">
                            </div>

                        </div>
                        <div class="form-group">


                            <label for="passwordchk" class="col-sm-3 control-label">비밀번호확인</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="passwordchk"

                                    placeholder="비밀번호를 확인해주세요">
                            </div>

                        </div>

                        <div class="form-group">


                            <label for="mphone" class="col-sm-3 control-label">핸드폰 번호</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="join-phone" name="memberPhone"
                                    placeholder="'-'빼고 입력해주세요">
                            </div>

                        </div>


                    </form>
                </div>



                <div class="modal-footer">


                    <button id="joinBtn" type="button" class="btn btn-primary">가입하기</button>

                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                </div>


            </div>
        </div>
    </div>
     <!-- Modal pwsearch창 -->
     <div id="modal-pwsearch" class="modal fade">
        <div class="modal-dialog">

            <!-- Modal Content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">비밀번호찾기</h4>
                </div>
                <div class="modal-body">
                    <form action="" method="post" id="form-passwdSearch" class="form-horizontal">
                       
                        <div class="form-group">
                            <label for="input-email" class="col-sm-3 control-label">이메일</label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control" id="input-email-search" placeholder="이메일을 입력해주세요">
                            </div>
                           
                        </div>
                        
                        

                        
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="mailSendBtn" type="button" class="btn btn-info" data-dismiss="modal">인증메일 발송</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                </div>


            </div>
        </div>
    </div>

	<!-- Modal 회원정보변경 모달창 -->
    <div id="modal-infochange" class="modal fade">
        <div class="modal-dialog">

            <!-- Modal Content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">회원정보변경</h4>
                </div>
                <div class="modal-body">
                    <form action="" method="post" id="form-infoChange" class="form-horizontal">
                        
                        <div class="form-group">
                            <label for="input-email" class="col-sm-3 control-label">이메일</label>
                            <div class="col-sm-9">
                                <input name="memberEmail" type="email" class="form-control" id="info-email" readonly value="${loginuser.memberEmail }">
                            </div>
                            
                        </div>
                        <div class="form-group">
                            <label for="input-nick" class="col-sm-3 control-label">닉네임</label>
                            <div class="col-sm-9">
                                <input name="memberNick" type="text" class="form-control" id="info-nick" placeholder="닉네임을 입력해주세요" value="${loginuser.memberNick }">
                            </div>
                           
                            
                        </div>
                        <div class="form-group">
                            <label for="input-password" class="col-sm-3 control-label">비밀번호</label>
                            <div class="col-sm-9">
                                <input name="memberPasswd" type="password" class="form-control" id="info-password" placeholder="비밀번호를 입력해주세요">
                            </div>
                            
                        </div>
                        <div class="form-group">
                            <label for="input-passwordchk" class="col-sm-3 control-label">비밀번호확인</label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" id="info-passwordchk" placeholder="비밀번호를 확인해주세요">
                            </div>
                            
                        </div>

                        <div class="form-group">
                            <label for="input-phone" class="col-sm-3 control-label">핸드폰 번호</label>
                            <div class="col-sm-9">
                                <input name="memberPhone" type="text" class="form-control" id="info-phone" placeholder="'-'빼고 입력해주세요" value="${loginuser.memberPhone }">
                            </div>
                            
                        </div>

                        
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="infoChangeBtn">정보변경</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="delUserBtn">탈퇴하기</button>
                </div>


            </div>
        </div>
    </div>
    <script defer>
		
		// 비밀번호 규칙 정규식
		// : 숫자, 특문 각 1회 이상, 영문은 2개 이상 사용하여 8자리 이상 입력
		const regExpPw = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		// 이메일 정규표현식
		const regExpEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		// 핸드폰 정규표현식
		const regExpPhone = /^[0-9]*$/;
        /*부트스트랩 jquery*/
        
        if(window.location.pathname.indexOf("/placeBoard") !== -1){
       		$('#menuPlace').css("color","black").css("font-size","23px");
       	} else if(window.location.pathname.indexOf("/courseBoard") !== -1){
       		$('#menuCourse').css("color","black").css("font-size","23px");
       	} else if(window.location.pathname.indexOf("/dietBoard") !== -1){
       		$('#menuDiet').css("color","black").css("font-size","23px");
       	} else if(window.location.pathname.indexOf("/noticeBoard") !== -1){
       		$('#menuNotice').css("color","black").css("font-size","23px");
       	} else if(window.location.pathname.indexOf("/marketBoard") !== -1){
       		$('#menuMarket').css("color","black").css("font-size","23px");
       	} else if(window.location.pathname.indexOf("/freeBoard") !== -1){
       		$('#menuFree').css("color","black").css("font-size","23px");
       	} 
        $(document).ready(function () { 
        	 
        	
        	
            menuBarLocation();
            $(window).resize(function () {
                menuBarLocation();
            });

            
            let emailChk = false;
            let nickChk = false;
            let passwdChk = false;
           	
            const msg = '${msg }';
           	if(msg === "복구 필요"){
           		if(confirm("계정이 복구가 필요합니다.\n복구를 진행하시겠습니까?")){
           			$('#login-email').val('${login.memberEmail }');
           			$('#form-login').attr("action","<c:url value='/user/recovery'/>");
           			$('#form-login').submit();
           		}
           	}
           	else if(msg !== ""){
            	
            	alert(msg);
            }
            
            $('#emailCheckBtn').click(function(){
            	
            	if ($('#join-email').val() === "") {
            		alert('이메일을 입력해주세요');
            		return;
            		
            	} else if(!regExpEmail.test($('#join-email').val())){
            		alert('이메일 형식에 맞게 입력해주세요');
            		return;
            	}
            	
            	$.ajax({
                    type: "POST",
                    url: "<c:url value='/user/emailChk' />",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                    data: $('#join-email').val(),
                    success: function (data) {
                        console.log('통신성공!' + data);
                      	if(data==="success"){
                      		alert('사용 가능한 이메일입니다.')
                      		emailChk = true;
                      		$('#join-email').attr("readonly","true");
                      	} else{
                      		$('#join-email').val('');
                      		alert('이미 사용중인 이메일입니다.')
                      	}
                    },
                    error: function () {
                        alert('통신에 실패했습니다. 관리자에게 문의하세요');
                    }
                }); //이메일 체크 비동기 통신 끝
            }); //이메일 체크 이벤트 끝
            
			$('#nickCheckBtn').click(function(){
				if ($('#join-nick').val() === "") {
            		alert('닉네임을 입력해주세요');
            		return;
            		
            	}
				
            	$.ajax({
                    type: "POST",
                    url: "<c:url value='/user/nickChk' />",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                    data: $('#join-nick').val(),
                    success: function (data) {
                        console.log('통신성공!' + data);

                      	if(data==="success"){
                      		alert('사용 가능한 닉네임입니다.')
                      		$('#join-nick').attr("readonly","true")
                      		nickChk = true;
                      	} else{
                      		alert('이미 사용중인 닉네임입니다.')
                      	}
                    },
                    error: function () {
                        alert('통신에 실패했습니다. 관리자에게 문의하세요');
                    }
                }); //닉네임 체크 비동기 통신 끝
            }); //닉네임 체크 이벤트 끝

           $('#join-passwd').keyup(function(){
        	   if(!regExpPw.test($('#join-passwd').val())){
        		   $('#join-passwd').css("background-color","pink");
        		   passwdChk = false;
        	   } else {
        		   $('#join-passwd').css("background-color","skyblue");
        		   passwdChk = true;
        	   }
        	   
           });
            
           $('#passwordchk').keyup(function(){
        	   if($('#join-passwd').val() !== $('#passwordchk').val()){
        		   $('#passwordchk').css("background-color","pink");
        	   } else {
        		   $('#passwordchk').css("background-color","skyblue");
        	   }
        	   
           });
           
           $('#join-phone').keyup(function(){
        	  if(!regExpPhone.test($('#join-phone').val())){
        		  alert("'-'은 입력하지마세요");
        		  $('#join-phone').val('');
        	  } 
           });
         
            $('#joinBtn').click(function(){
            	if (!emailChk){
            		alert('이메일 중복확인이 필요합니다.');
            		return;
            	} else if(!nickChk){
            		alert('닉네임 중복확인이 필요합니다.');
            		return;
            	} else if($('#join-passwd').val() === ""){
           			alert('비밀번호는 필수값입니다.');
           			return;
           		} else if ($('#passwordchk').val() === ""){
           			alert('비밀번호확인을 입력해주세요');
           			return;
           		} else if(!passwdChk){
           			alert('최소 8 자, 특수문자, 영문 및  숫자섞어서 써주세요')
           			$('#join-passwd').val('');
           			$('#passwordchk').val('');
           			return;
           		}
            	$('#form-join').submit();
            	
            	
            	
            }); // 가입버튼 클릭 이벤트
            
            $('#loginBtn').click(function(){
            	if($('#login-email').val() === ""){
            		alert('이메일을 입력해주세요!');
            	} else if($('#login-password').val() === ""){
            		alert('비밀번호를 입력해주세요!');
            	} else{
            		
            		$('#form-login').submit();
            	}
            }); // 로그인 클릭 이벤트
            

        });
        function menuBarLocation(){
            if ($(window).width() < 755) {
                $('.navbar > .container-fluid > .collapse').css('padding-left', '0px');
                $('.navbar > .container-fluid > .collapse').css('padding-top', '0px');
            } else {
                $('.navbar > .container-fluid > .collapse').css('padding-left', '250px');
                $('.navbar > .container-fluid > .collapse').css('padding-top', '80px');
            }
        }
            
        function getLocation() {
        	const loginEmail = '${loginuser!=null? loginuser.memberEmail: "" }'
        	if(loginEmail == ""){
        		alert('로그인 후 이용해주세요');
        		return;
        	} else if (navigator.geolocation) { // GPS를 지원하면
                navigator.geolocation.getCurrentPosition(function (position) {
                	$.ajax({
                        type: "POST",
                        url: "<c:url value='/user/geoRegist' />",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                        data: JSON.stringify({
                        	"memberEmail" : loginEmail,
                            "memberLatitude" : position.coords.latitude,
                            "memberLongitude" : position.coords.longitude,
                        }),
                        success: function (data) {
                            console.log('통신성공!' + data);

                          	if(data==="success"){
                          		alert("위치가 등록 되었습니다.");
                          		location.reload();
                          	} else{
                          		alert('위치 등록에 실패했습니다.');
                          	}
                        },
                        error: function () {
                            alert('통신에 실패했습니다. 관리자에게 문의하세요');
                        }
                    }); // 회원 위치정보 등록 비동기 처리 끝
                	
                }, function (error) {
                    console.error(error);
                }, {
                    enableHighAccuracy: false,
                    maximumAge: 0,
                    timeout: Infinity
                });
            } else {
                alert('GPS를 지원하지 않습니다');
            }
        }
		$('#geoLink').click(function(e){
			e.preventDefault();
			getLocation();
		});
		$('#input-email-search').keydown(function(e){
			if(e.keyCode===13){
				e.preventDefault();
				$('#mailSendBtn').click();
				
			}
		});
		$('#mailSendBtn').click(function(){
			$.ajax({
                type: "POST",
                url: "<c:url value='/user/passwdEmailSend' />",
                headers: {
                    "Content-Type": "application/json"
                },
                dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                data: $('#input-email-search').val(),
                success: function (data) {
                    console.log('통신성공!' + data);

                  	if(data==="success"){
                  		alert("비밀번호 변경 이메일이 발송되었습니다.")
                  	} else{
                  		alert('가입되지 않은 이메일입니다.')
                  	}
                },
                error: function () {
                    alert('통신에 실패했습니다. 관리자에게 문의하세요');
                }
            }); // 회원 위치정보 등록 비동기 처리 끝
		});
		
		/// 다음 주소 api사용부분
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		let myNickChk = true;
    	let passwdChk = false;
        $('#info-password').keyup(function(){
            if(!regExpPw.test($('#info-password').val())){
                $('#info-password').css("background-color","pink");
                passwdChk = false;
            } else {
                $('#info-password').css("background-color","skyblue");
                passwdChk = true;
            }
            
        });

        $('#info-passwordchk').keyup(function(){
            if($('#info-password').val() !== $('#info-passwordchk').val()){
                $('#info-passwordchk').css("background-color","pink");
            } else {
                $('#info-passwordchk').css("background-color","skyblue");
            }
            
        });

        $('#infoChangeBtn').click(function(){
            if(passwdChk === false){
                alert('비밀번호는 숫자 영문 특수 포함 8자 이상으로 작성하셔야 합니다.');
                return;
            }

            if(confirm('회원정보를 수정하시겠습니까?') === true){
                if($('#info-nick').val() !== '${loginuser.memberNick}'){
                	myNickChk = false;
                } else{
                	myNickChk = true;
                }
                $.ajax({
                    type: "POST",
                    url: "<c:url value='/user/modifyUser' />",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    dataType: "text", //서버로부터 어떤 형식으로 받을지(생략가능)
                    data: JSON.stringify({
                        "memberEmail": $('#info-email').val(),
                        "memberNick": $('#info-nick').val(),
                        "memberPasswd": $('#info-password').val(),
                        "memberPhone": $('#info-phone').val(),
                        "nickChk": myNickChk
                    }),
                    success: function (data) {
                        console.log('통신성공!' + data);

                        if(data==="success"){
                            alert("회원정보변경을 성공적으로 마쳤습니다.");
                            location.href="<c:url value='/' />"
                        } else if(data==="duplicate"){
                            alert('이미 다른 닉네임이 존재합니다.');
                        } 
                    },
                    error: function () {
                        alert('통신에 실패했습니다. 관리자에게 문의하세요');
                    }
                }); // 회원 위치정보 등록 비동기 처리 끝
            }

        });
        
        $('#delUserBtn').click(function(){
			if(confirm('정말로 탈퇴하시겠습니까?') === true){
				$('#form-infoChange').attr('action','<c:url value="/user/delUser" />');
				$('#form-infoChange').submit();
			}
        	
        });
        
        
    </script>
    <c:if test="${loginuser.memberLatitude != null }">
    <script>
    	
    	var callback = function(result,status){
    		console.log("result:"+result);
    		console.log("status:"+status);
    		
    		var location = result[1].address_name;
    		const locarr = location.split(" ");
    		console.log(locarr[0],locarr[1]);
	    	$('#centerAddr').html(locarr[0]+" "+locarr[1]);
    		
    	}
    	geocoder.coord2RegionCode(${loginuser.memberLongitude}, ${loginuser.memberLatitude}, callback);
    </script>
    </c:if>
</body>

</html>