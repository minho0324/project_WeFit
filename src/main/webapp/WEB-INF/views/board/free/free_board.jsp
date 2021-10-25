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
        
        .footer{
            background-color: red;
            height: 50px;
        }
        .section{
            background-color: yellowgreen;
            height: 500px;

        }
        .sidebar{
            background-color: yellow;
            position: fixed;
            right: 15px ;
            top: 250px;
        }
       
        

        #title {
       	margin-top: 20px;
           margin-bottom: 20px;
          color: rgb(0, 173, 181);
          font-size: 45px;
          font-weight: bold;
          text-align: left;
        }

        #all {
          font-weight: bold;
        }

        input {
          padding: 5px;
          border: 1px solid lightgray;
          border-radius: 10px;
          width: 200px;
        }

        .page-link {
          color:rgb(0, 173, 181);
        }
        #btn-list {
          margin-top: 60px;
          margin-bottom: 10px;
        }
        
        .search-inline {
        	margin-bottom:10px;
        }
        thead > tr > th:nth-child(2){
        	
		  	width: 600px;
        }
        #title{
        	overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			width: 600px;
			height: 20px;
        }
        
      

    </style>
</head>

<body>
    
    <div class="container-fluid h-100">

        <div class="row">
            <%@ include file="../../include/header.jsp" %>
        </div>
        
   		<div class="container text-center">
        <div class="row">
                
          <div class="col-sm-5" align="left">
            <span id="title">자유게시판</span>
          </div>
            <div id="btn-list" class="row" align="right">
              <div class="btn-group text-center" role="group" aria-label="Basic outlined example">
                <button type="button" class="btn btn-info ${param.condition==''? 'active':'' }" id="allBtn">전체</button>
                <button type="button" class="btn btn-info ${param.condition=='[자유글]'? 'active':'' }" id="freeBtn">자유글</button>
                <button type="button" class="btn btn-info ${param.condition=='[소식/정보]'? 'active':'' }" id="infoBtn">소식/정보</button>
                <button type="button" class="btn btn-info ${param.condition=='[홍보]'? 'active':'' }" id="advertBtn">홍보</button>
                <button type="button" class="btn btn-info ${param.condition=='[꿀팁]'? 'active':'' }" id="tipBtn">꿀팁</button>
                <button type="button" class="btn btn-info ${param.condition=='[기타]'? 'active':'' }" id="etcBtn">기타</button>&nbsp;&nbsp;&nbsp;
              </div>
            </div>
              
			<div class="form-inline search-inline pull-right">
            	<select id="order" class="form-control col-sm-2" >
              		<option value="date" ${pc.paging.order == 'date'? 'selected':'' }>최신순</option>
              		<option value="view" ${pc.paging.order == 'view'? 'selected':'' }>조회수순</option>
              		<option value="reply" ${pc.paging.order == 'reply'? 'selected':'' }>댓글수순</option>
              		<option value="like" ${pc.paging.order == 'like'? 'selected':'' }>좋아요순</option>
              		<c:if test="${loginuser.memberManagerYN=='YES' }">
               			<option value="report" ${pc.paging.order == 'report'? 'selected':'' }>신고수순</option>
              		</c:if>
              		
              	</select>
	             <input id="search-input" type="text" placeholder="Search" class="form-control" value="${pc.paging.keyword }">
	           
	             <button type="button" class="btn" aria-label="Left Align" id="searchBtn">
	               <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
	             </button>
			
			</div>
        </div>
          

        

            <div class="row margin-top-5">
                <table class="table table-hover table-responsive">
                    <thead class="bg-info">
                      <tr>
                        <th scope="col" class="text-center">번호</th>
                        <th scope="col" class="text-center">제목</th>
                        <th scope="col" class="text-center">글쓴이</th>
                        <th scope="col" class="text-center">날짜</th>
                        <th scope="col" class="text-center">조회</th>
                      </tr>
                    </thead>	
                    <tbody>
                    <c:if test="${fn:length(freeList) == 0 }">
						 <tr>
						 	<td colspan=5><p class="search-none">검색 결과가 없습니다.</p></td>
					 	<tr>
					</c:if>
                    <c:forEach var="arr" items="${freeList }">
                    
                      <tr ${(loginuser.memberManagerYN=="YES" && arr.fbReportCount > 0)? "style='background-color:red'":"" } onclick="location.href='<c:url value="/freeBoard/freeDetail?fbNum=${arr.fbNum }&pageNum=${pc.paging.pageNum}&keyword=${pc.paging.keyword }&condition=${pc.paging.condition }&category=${pc.paging.category }&order=${pc.paging.order }" />'">
                        
                        <th scope="col" class="text-center">${arr.fbNum }</th>
                        <th scope="col" class="title">${fn:replace(fn:replace(fn:replace(arr.fbTitle,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") }&nbsp;&nbsp;&nbsp;[${arr.fbReplyCount}]</th>
                        <th scope="col" class="text-center">${arr.memberNick }</th>
                        <th scope="col" class="text-center"><fmt:formatDate value="${arr.fbRegDate }" pattern="yyyy-MM-dd"/></th>
                        <th scope="col" class="text-center">${arr.fbLookCount }</th>
                      </tr>
                    </c:forEach>
                    <!-- 
                        <tr>
                          <th scope="col" class="text-center">23</th>
                          <th scope="col">[자유글] 운동 많이 하고 계시나요?</th>
                          <th scope="col" class="text-center">야옹이</th>
                          <th scope="col" class="text-center">2021-09-02</th>
                          <th scope="col" class="text-center">153</th>
                      </tr>
                      
                        <tr>
                          <th scope="col" class="text-center">23</th>
                          <th scope="col">[자유글] 운동 많이 하고 계시나요?</th>
                          <th scope="col" class="text-center">야옹이</th>
                          <th scope="col" class="text-center">2021-09-02</th>
                          <th scope="col" class="text-center">153</th>
                      </tr>
                      
                        <tr>
                          <th scope="col" class="text-center">23</th>
                          <th scope="col">[자유글] 운동 많이 하고 계시나요?</th>
                          <th scope="col" class="text-center">야옹이</th>
                          <th scope="col" class="text-center">2021-09-02</th>
                          <th scope="col" class="text-center">153</th>
                      </tr>
                      
                        <tr>
                          <th scope="col" class="text-center">23</th>
                          <th scope="col">[자유글] 운동 많이 하고 계시나요?</th>
                          <th scope="col" class="text-center">야옹이</th>
                          <th scope="col" class="text-center">2021-09-02</th>
                          <th scope="col" class="text-center">153</th>
                      </tr>
                      
                        <tr>
                          <th scope="col" class="text-center">23</th>
                          <th scope="col">[자유글] 운동 많이 하고 계시나요?</th>
                          <th scope="col" class="text-center">야옹이</th>
                          <th scope="col" class="text-center">2021-09-02</th>
                          <th scope="col" class="text-center">153</th>
                      </tr>
                      
                        <tr>
                          <th scope="col" class="text-center">23</th>
                          <th scope="col">[자유글] 운동 많이 하고 계시나요?</th>
                          <th scope="col" class="text-center">야옹이</th>
                          <th scope="col" class="text-center">2021-09-02</th>
                          <th scope="col" class="text-center">153</th>
                      </tr>
                      
                        <tr>
                            <th scope="col" class="text-center">23</th>
                            <th scope="col">[자유글] 운동 많이 하고 계시나요?</th>
                            <th scope="col" class="text-center">야옹이</th>
                            <th scope="col" class="text-center">2021-09-02</th>
                            <th scope="col" class="text-center">153</th>
                        </tr>
                        -->
                    </tbody>
                  </table>
            </div>

            <div class="row" align="right">
                <button type="button" id="write" class="btn btn-outline-primary" onclick="location.href='<c:url value="/freeBoard/freeWrite" />'"><b>글쓰기</b></button>
             </div>
			</div>
            <div class="row text-center">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                      <c:if test="${pc.prev }">
	                    <li class="page-item"><a class="page-link" href="<c:url value='/freeBoard/?pageNum=${pc.beginPage-1 }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />">Prev</a></li>
                      </c:if>
                      
                      <c:forEach var="page" begin="${pc.beginPage }" end="${pc.endPage }">
                      	<li class="page-item ${page == pc.paging.pageNum? 'active':''}"><a class="page-link" href="<c:url value='/freeBoard/?pageNum=${page }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />">${page }</a></li>
                      </c:forEach>
               
                      
                      <c:if test="${pc.next }">
	                    <li class="page-item"><a class="page-link" href="<c:url value='/freeBoard/?pageNum=${pc.endPage+1 }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />">Next</a></li>
                      </c:if>
                    </ul>
                  </nav>
            </div> 

        <div class="row">
            <%@ include file="../../include/footer.jsp" %>
        </div>
		
        
    </div>
    <script>
	    if(window.location.pathname.indexOf("/noticeBoard") !== -1){
			$('#subMenuNotice').css("font-size","18px").css("font-weight","700");
		} else if(window.location.pathname.indexOf("/freeBoard") !== -1){
			$('#subMenuFree').css("font-size","18px").css("font-weight","700");
		}
    	
    	$('#allBtn').click(function(){
    		location.href=`<c:url value="/freeBoard/?condition=&keyword=${pc.paging.keyword} " />`
    	});
    	$('#freeBtn').click(function(){
    		location.href=`<c:url value="/freeBoard/?condition=[자유글]&keyword=${pc.paging.keyword} " />`
    	});
    	$('#infoBtn').click(function(){
    		location.href=`<c:url value="/freeBoard/?condition=[소식/정보]&keyword=${pc.paging.keyword} " />`
    	});
    	$('#advertBtn').click(function(){
    		location.href=`<c:url value="/freeBoard/?condition=[홍보]&keyword=${pc.paging.keyword} " />`
    	});
    	$('#tipBtn').click(function(){
    		location.href=`<c:url value="/freeBoard/?condition=[꿀팁]&keyword=${pc.paging.keyword} " />`
    	});
    	$('#etcBtn').click(function(){
    		location.href=`<c:url value="/freeBoard/?condition=[기타]&keyword=${pc.paging.keyword} " />`
    	});
    	$('#searchBtn').click(function(){
    		location.href=`<c:url value="/freeBoard/?condition=${pc.paging.condition}&keyword="/>`+$('#search-input').val()+"&order="+$('#order').val();
    	});
    	$('#search-input').keyup(function(e){
    		if(e.keyCode == 13) {
	    		location.href=`<c:url value="/freeBoard/?condition=${pc.paging.condition}&keyword="/>`+$('#search-input').val()+"&order="+$('#order').val();
    		}
    	});
    	
    </script>
    
</body>
</html>