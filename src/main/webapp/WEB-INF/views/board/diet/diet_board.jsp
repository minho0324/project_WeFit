
<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            height: 500px;
        }

        

        /* h2 {
          color: rgb(0, 173, 181);
          font-size: 35px;
          font-weight: bold;
        } */

        #title {
            color: rgb(0, 173, 181);
            font-size: 45px;
            font-weight: bold;
            cursor:pointer;
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



	

        .vid {
            margin: 25px 5px;
            padding: 5px;
            border: 1px solid #ccc;
        }

        .vid .video {
            /* border: 1px solid #fff; */
            background: #fff;
            padding: 10px;
            cursor: pointer;
        }


        /* .course {      
            box-sizing: border-box;        
        } */

        .subject {
            height: 70px;
            margin: 10px;
        }

        .auth {
            text-align: left;
            font-size: 15px;
            padding: 0 13px;
            overflow: hidden;
        }

        .auth span {
            float: right;
            font-size: 14px;
            padding-left: 15px;
        }
        .auth span:nth-child(1),span:nth-child(2){
            float: left;
            padding-left: 0px;
        }
        .auth span:nth-child(2){
            padding-left: 15px;
        }

        .glyphicon-comment {
            color: skyblue;
        }

        .glyphicon-eye-open {
            color: purple;
        }

        .glyphicon b {
            color: #000;
            padding-left: 8px;
        }
        
      
    </style>
</head>

<body>

    <div class="container-fluid h-100">
        <div class="row">
            <%@ include file="../../include/header.jsp" %>
        </div>
        <div class="row">
            <div class="container">

            <!-- <div class="row">
                <h2 class="font-weight-bold text-center">운동 강의</h2>
            </div> -->

            <div class="row">
                <div class="col-sm-5" align="left">
                    
                    <span id="title">오늘의 식단</span>
                    
                </div>
              	<div class="row"></div>
              	<form action="<c:url value='/dietBoard/dietList' />">
					<div id="btn-list" class="form-inline pull-right" >
						
						
						<select id="order" name="order" class="form-control col-sm-2">
                     		<option value="date" ${dpc.paging.order == 'date'? 'selected':'' }>최신순</option>
                     		<option value="view" ${dpc.paging.order == 'view'? 'selected':'' }>조회수순</option>
                     		<option value="reply" ${dpc.paging.order == 'reply'? 'selected':'' }>댓글수순</option>
                     		<option value="like" ${dpc.paging.order == 'like'? 'selected':'' }>좋아요순</option>
                     		<c:if test="${loginuser.memberManagerYN=='YES' }">
                      			<option value="report" ${dpc.paging.order == 'report'? 'selected':'' }>신고수순</option>
                     		</c:if>
                     		
                     	</select>
						<!--검색 조건-->
						<select class="search-condition form-control" name="condition">
							<option value="title" ${dpc.paging.condition=='title'? 'selected':'' }>제목</option>
							<option value="writer" ${dpc.paging.condition=='writer'? 'selected':'' }>작성자</option>
							<option value="content" ${dpc.paging.condition=='content'? 'selected':'' }>내용</option>
						</select> <input type="text" placeholder="Search" name="keyword" class="form-control" value="${dpc.paging.keyword}">
						<button type="submit" class="btn" aria-label="Left Align">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</div>
				</form>
              	
            </div>


            <div class="row margin-top-5">
               
                <table class="table">
                 
                   <tbody>
						<c:if test="${fn:length(dietList) == 0 }">
								 <p class="search-none">검색 결과가 없습니다.</p>
							</c:if>
						<c:forEach var="vo" varStatus="i" items="${dietList}">
							<c:if test="${i.count % 3 == 1}">
								<tr class="course">
							</c:if>
							
							<th scope="col" class="text-center" style="width: 33%;" id="dietviewCnt"
								onclick="location.href='<c:url value='/dietBoard/dietDetail?dbNum=${vo.dbNum}&pageNum=${dpc.paging.pageNum}&keyword=${dpc.paging.keyword }&condition=${dpc.paging.condition }&category=${dpc.paging.category }&order=${dpc.paging.order }' />'">
								<div class="vid">
									<div class="video" ${(loginuser.memberManagerYN=="YES" && vo.dbReportCount > 0)? "style='background-color:red'":"" }>
								<c:if test="${vo.dbRealImage1 != null }">
									<img
										src="/upload/board/diet/${vo.memberNick}/${vo.dbRealImage1}"
										width="280px" height="160px" alt="vid01">
								</c:if>
								<c:if test="${vo.dbRealImage1 == null }">
									<img
										src="${pageContext.request.contextPath }/resources/img/logo/logo.png"
										width="280px" height="160px" alt="vid01">
								</c:if>
								
									<p class="subject">
										${fn:replace(fn:replace(fn:replace(vo.dbTitle, replaceChar2,"&gt;"),replaceChar1,"&lt;"),replaceChar,"<br/>") }
									</p>
									<p class="auth">
										<span class="writeday"><fmt:formatDate value="${vo.dbRegDate}" pattern="yy.MM.dd HH:mm" /></span> 
										<span class="nickname">${vo.memberNick }</span> 
										<span class="glyphicon glyphicon-comment" aria-hidden="true"><b>${vo.drCount }</b></span>
										<span class="glyphicon glyphicon-eye-open" aria-hidden="true"><b>${vo.dbLookCount}</b></span>
									</p>

								</div>
							</th>

                            <c:if test="${i.count % 9 == 1 && i.count == fn:length(dietList)}">
		                         <td></td>
		                         <td></td>
		                      </c:if>
		                       
		                      <c:if test="${i.count % 9 == 2 && i.count == fn:length(dietList)}">
		                         <td></td>
		                      </c:if> 
							<c:if test="${i.count % 3 == 0}">
								</tr>
							</c:if>
						</c:forEach>
						
					</tbody>

                </table>
            </div>
			<c:if test="${loginuser != null}">
	            <div class="row" align="right">
	                <button type="button" id="write" class="btn btn-outline-primary float-right"  onclick="location.href='<c:url value='/dietBoard/dietWrite' />'"><b>글쓰기</b></button>
	
	            </div> <!-- 관리자만 보이게 하기 -->
	        </c:if>

			<form action="<c:url value='/dietBoard/dietList' />" name="pageForm">
				<div class="row text-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination" id="pagination">
						
							<c:if test="${dpc.prev}">
								<li>
									<a href="#" data-pageNum="${dpc.beginPage-1}">Prev</a>
								</li>
							</c:if>
	
							<c:forEach var="diet" begin="${dpc.beginPage}" end="${dpc.endPage}">
								<li class="${dpc.paging.pageNum == diet ? 'active' : ''}">
									<a href="#" data-pageNum="${diet}">${diet}</a>
								</li>
							</c:forEach>
	
							<c:if test="${dpc.next}">
								<li>
									<a href="#" data-pageNum="${dpc.endPage+1}">Next</a>
								</li>
							</c:if>
							
						</ul>
					</nav>
				</div>
				
				    <input type="hidden" name="pageNum" value="${dpc.paging.pageNum}">
                    <input type="hidden" name="countPerPage" value="${dpc.paging.countPerPage}">
                    <input type="hidden" name="keyword" value="${dpc.paging.keyword}">
                    <input type="hidden" name="condition" value="${dpc.paging.condition}">
                    <input type="hidden" name="order" value="${dpc.paging.order }">
			</form>

            
        </div>
        </div>
        
        <div class="row">
            <%@ include file="../../include/footer.jsp" %>
        </div>
    </div>

    
</body>
<script>
	const pagination = document.getElementById('pagination');	
	pagination.onclick = function(e) {
	e.preventDefault();
	
	const value = e.target.dataset.pagenum;
	
	
	document.pageForm.pageNum.value = value;
	document.pageForm.submit();
}

    $(document).ready(function(){
        
        
        $('.vid').hover(function() {   
            $(this).css('background-color', 'rgb(0, 173, 181)');
            
        });
  
        $('.vid').mouseleave(function() {   
            $(this).css('background-color', '#fff');
            
        });
  
  
    });


	
    
</script>

</html>




