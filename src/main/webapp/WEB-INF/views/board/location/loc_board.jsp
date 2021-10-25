<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<% pageContext.setAttribute("replaceChar", "\n"); %>
<% pageContext.setAttribute("replaceChar1", "<"); %>
<% pageContext.setAttribute("replaceChar2", ">"); %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
.footer {
	background-color: red;
	height: 50px;
}

.section {
	background-color: yellowgreen;
	height: 500px;
}

.sidebar {
	background-color: yellow;
	position: fixed;
	right: 15px;
	top: 250px;
}



#title {
	color: rgb(0, 173, 181);
	font-size: 45px;
	font-weight: bold;
	cursor:pointer;
}

#all {
	font-weight: bold;
}
.search-area {
			margin-top: 15px;
			margin-right: 10px;
		} 


input {
	padding: 5px;
	border: 1px solid lightgray;
	border-radius: 10px;
	width: 200px;
}

.page-link {
	color: rgb(0, 173, 181);
}

#btn-list {
	margin-top: 15px;
	margin-bottom: 25px;
}
tr{
	cursor: pointer;
}


</style>
</head>

<body>

	<div class="container-fluid h-100">
		<div class="row">
			<%@ include file="../../include/header.jsp"%>
		</div>

		<div class="row">

			<div class="container">
				<div class="row">
					<div class="col-sm-5" align="left">
						<span id="title">장소 찾기</span>
					</div>

					<!-- 종목 -->
					<div id="btn-list" class="row" align="right">
						<div id="sportsBtn" class="btn-group text-center " role="group" aria-label="Basic outlined example">
							<button type="button" class="btn btn-info ${(pc.paging.category == '' )|| (pc.paging.category == null)? 'active':'' }" id="allBtn">전체</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '수영'? 'active':'' }" id="swimmingBtn">수영</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '배드민턴'? 'active':'' }" id="badmintonBtn">배드민턴</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '스쿼시'? 'active':'' }" id="squashBtn">스쿼시</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '자전거'? 'active':'' }" id="bicycleBtn">자전거</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '달리기'? 'active':'' }" id="runningBtn">달리기</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '등산'? 'active':'' }" id="hikingBtn">등산</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '홈트짐트'? 'active':'' }" id="trainingBtn">홈트짐트</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '필라테스'? 'active':'' }" id="pilatesBtn">필라테스</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '골프'? 'active':'' }" id="golfBtn">골프</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '스케이트'? 'active':'' }" id="skateBtn">스케이트</button>
							<button type="button" class="btn btn-info ${pc.paging.category == '기타'? 'active':'' }" id="etcBtn">기타</button>&nbsp;&nbsp;&nbsp;
						</div>
					

						<div class="search-area form-inline pull-right">
							<select id="order" class="form-control col-sm-2 ">
                            		<option value="date" ${pc.paging.order == 'date'? 'selected':'' }>최신순</option>
                            		<option value="view" ${pc.paging.order == 'view'? 'selected':'' }>조회수순</option>
                            		<option value="reply" ${pc.paging.order == 'reply'? 'selected':'' }>댓글수순</option>
                            		<c:if test="${loginuser != null && loginuser.memberLatitude != 0.0 }">
	                            		<option value="distance" ${pc.paging.order == 'distance'? 'selected':'' }>거리순</option>
                            		</c:if>
                            		<option value="like" ${pc.paging.order == 'like'? 'selected':'' }>좋아요순</option>
                            		<c:if test="${loginuser.memberManagerYN=='YES' }">
	                            		<option value="report" ${pc.paging.order == 'report'? 'selected':'' }>신고수순</option>
                            		</c:if>
                            		
                           	</select>
							<select id="search-condition" class="form-control" >
								<option value="title"
									${(pc.paging.condition == 'title')||(pc.paging.condition == null)? 'selected' : '' }>제목</option>
								<option value="content"
									${pc.paging.condition == 'content' ? 'selected' : '' }>내용</option>
								<option value="titleContent"
									${pc.paging.condition == 'titleContent' ? 'selected' : '' }>제목+내용</option>
								<option value="area"
									${pc.paging.condition == 'area' ? 'selected' : '' }>지역명</option>
							</select> 
							<c:if test="${loginuser != null }">
								<select id="search-distance" class="form-control">
									<option value="" ${pc.paging.distance==15000? 'selected':'' }>거리선택</option>
									<option value="2km" ${pc.paging.distance==2? 'selected':'' }>2km 이내</option>
									<option value="5km" ${pc.paging.distance==5? 'selected':'' }>5km 이내</option>
									<option value="10km" ${pc.paging.distance==10? 'selected':'' }>10km 이내</option>
								</select> 
							
							</c:if>
							
							<input id="search-input" type="text" placeholder="Search" class="form-control" value="${pc.paging.keyword }">
		
							<button type="button" class="btn" aria-label="Left Align" id="searchBtn">
								<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
							</button>
						</div>
					</div>
				</div>
				
			
				<div class="row margin-top-5">
					<table class="table table-hover table-responsive">

						<thead class="bg-info">
							<tr>
								<th scope="col" class="text-center">번호</th>
								<th scope="col" class="text-center">종목</th>
								<th scope="col" class="text-center">지역</th>
								<th scope="col" class="text-center">장소명</th>
								<th scope="col" class="text-center">글쓴이</th>
								<th scope="col" class="text-center">조회</th>
								<th scope="col" class="text-center">날짜</th>
							</tr>
						</thead>

						<tbody>
							<c:if test="${fn:length(placeList) == 0 }">
								 <tr>
								 	<td colspan=7><p class="search-none">검색 결과가 없습니다.</p></td>
							 	<tr>
							</c:if>
							<c:forEach var="vo" items="${placeList}">
								<tr ${(loginuser.memberManagerYN=="YES" && vo.pbReportCount > 0)? "style='background-color:red'":"" } onclick="location.href='<c:url value="/placeBoard/placeDetail?pbNum=${vo.pbNum}&pageNum=${pc.paging.pageNum }&keyword=${pc.paging.keyword }&condition=${pc.paging.condition }&category=${pc.paging.category }&latitude=${(loginuser!=null && loginuser.memberLatitude!=null)? loginuser.memberLatitude:0.0 }&longitude=${(loginuser!=null && loginuser.memberLongitude!=null)? loginuser.memberLongitude:0.0 }&distance=${pc.paging.distance }&order=${pc.paging.order } " />'">	
									<td class="text-center">${vo.pbNum}</td>
									<td class="text-center">[${vo.pbCategory}]</td>
									<td class="text-center">
										<!-- 공백을 기준으로 문자열을 잘라서 배열로 저장한다 -->
										<c:set var="addBasicArr" value="${fn:split(vo.pbAddrBasic, ' ')}" />
										
										<!-- 배열로 저장된 것을 불러오겠다 -->
										<p>
										<c:forEach var="arr" items="${addBasicArr }" begin="0" end="1" >
											${arr }
										</c:forEach>
										</p>
									</td>

									<td>
										${fn:replace(fn:replace(fn:replace(vo.pbTitle, replaceChar2,"&gt;"),
										replaceChar1,"&lt;"),replaceChar,"<br/>") }&nbsp;&nbsp;[${vo.pbReplyCount}] &nbsp;&nbsp;&nbsp;</td>
										
									<td class="text-center">${vo.memberNick}</td>
									<td class="text-center">${vo.pbLookCount}</td>
									<td class="text-center"><fmt:formatDate value="${vo.pbRegDate}" pattern="yy/MM/dd HH:mm" /></td>
								</tr>
							</c:forEach>
						</tbody>

					</table>
				</div>

				<div class="row" align="right">
					<button type="button" id="write"
						class="btn btn-outline-primary float-right"
						onclick="location.href='<c:url value='/placeBoard/placeWrite' />' ">
						<b>새 장소 등록</b>
					</button>
				</div>

				<!-- 페이징 -->
				<div class="row text-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<c:if test="${pc.prev}">
								<li class="page-item"><a class="page-link"
									href="<c:url value='/placeBoard/placeList?pageNum=${pc.beginPage-1}&latitude=${loginuser.memberLatitude}&longitude=${loginuser.memberLongitude}&condition=${pc.paging.condition}&keyword=${pc.paging.keyword}&distance=${pc.paging.distance}&category=${pc.paging.category}&order=${pc.paging.order }' />">Prev</a></li>
							</c:if>

							<c:forEach var="page" begin="${pc.beginPage}" end="${pc.endPage}">
								<li class="page-item ${pc.paging.pageNum == page? 'active':'' }"><a class="page-link"
									href="<c:url value='/placeBoard/placeList?pageNum=${page}&latitude=${loginuser.memberLatitude}&longitude=${loginuser.memberLongitude}&condition=${pc.paging.condition}&keyword=${pc.paging.keyword}&distance=${pc.paging.distance}&category=${pc.paging.category}&order=${pc.paging.order }' />">${page}</a></li>
							</c:forEach>

							<c:if test="${pc.next}">
								<li class="page-item"><a class="page-link"
									href="<c:url value='/placeBoard/placeList?pageNum=${pc.endPage+1}&latitude=${loginuser.memberLatitude}&longitude=${loginuser.memberLongitude}&condition=${pc.paging.condition}&keyword=${pc.paging.keyword}&distance=${pc.paging.distance}&category=${pc.paging.category}&order=${pc.paging.order }' />">Next</a></li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>



			<div class="row">
				<%@ include file="../../include/footer.jsp"%>
			</div>

		</div>



	<script>
	  $('#title').click(function() {
    	location.href='<c:url value="/placeBoard/placeList" />';
	  });
      
   
     // 종목카테고리 클릭 시 
     $('#allBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=&keyword=${pc.paging.keyword} " />`
       });
     $('#swimmingBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=수영&keyword=${pc.paging.keyword} " />`
       });
     $('#badmintonBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=배드민턴&keyword=${pc.paging.keyword} " />`
       });
     $('#squashBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=스쿼시&keyword=${pc.paging.keyword} " />`
       });
     $('#bicycleBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=자전거&keyword=${pc.paging.keyword} " />`
       });
     $('#runningBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=달리기&keyword=${pc.paging.keyword} " />`
       }); 
     $('#hikingBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=등산&keyword=${pc.paging.keyword} " />`
       });
     $('#trainingBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=홈트짐트&keyword=${pc.paging.keyword} " />`
       });
     $('#pilatesBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=필라테스&keyword=${pc.paging.keyword} " />`
       });
     $('#golfBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=골프&keyword=${pc.paging.keyword} " />`
       });
     $('#skateBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=스케이트&keyword=${pc.paging.keyword} " />`
       });
     $('#etcBtn').click(function(){
       location.href=`<c:url value="/placeBoard/placeList?category=기타&keyword=${pc.paging.keyword} " />`
       });
       
      // 검색기능 구현 
      $('#searchBtn').click(function() {
          const condition = $('#search-condition').val();
          const keyword = $('#search-input').val();
//    	  const distance = +$('#search-distance').val();
		  let distance = 0;
		  if($('#search-distance').val() === ''){
			  distance = 15000;
		  } else if($('#search-distance').val() === '2km'){
			  distance = 2;
		  } else if($('#search-distance').val() === '5km'){
			  distance = 5;
		  } else if($('#search-distance').val() === '10km'){
			  distance = 10;
		  }
          
          location.href = '/wefit/placeBoard/placeList?condition=' + condition + '&distance=' + distance + '&keyword=' + keyword + '&order=' + $('#order').val() + '&latitude=' + ${loginuser != null? loginuser.memberLatitude:0.0} + '&longitude=' + ${loginuser != null? loginuser.memberLongitude:0.0} ;                                                 
       });
      $('#search-input').keydown(function(e){
    	  if(e.keyCode == 13){
    		  e.preventDefault();
    		  $('#searchBtn').click();
    	  }
      })
      
	   
     
    	//
	   function fn_contentView(bid){
	      var url = "${pageContext.request.contextPath}/board/getBoardContent";
	      url = url + "?bid="+bid;
	      location.href = url;
	   }

  

    </script>
</body>
</html>