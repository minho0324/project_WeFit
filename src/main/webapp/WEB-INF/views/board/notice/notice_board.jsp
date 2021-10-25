<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
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

        .titlebox h2 {
            /* border-bottom: 1px solid rgb(0, 173, 181); */
            margin-top: 20px;
            margin-bottom: 20px;
            font-size: 45px;
            font-weight: bold;
            color: rgb(0, 173, 181);
            text-align: left;
        }
        
        #search-parts {
        	margin-left:10px;
        	margin-bottom: 25px;
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


        


        /* .course {      
            box-sizing: border-box;        
        } */

       

        

        
    </style>
</head>

<body>

    <div class="container-fluid h-100">
        <div class="row">
            <%@ include file="../../include/header.jsp" %>
            
        </div>
        
        <div class="container text-center">


            <div class="row">
                <div class="col-sm-8">
                    <div class="titlebox">
                        <h2>공지사항</h2>
                    </div>
                </div>
            
            
            	
		    </div>
		    <div class="pull-right col-sm-5" id="search-parts" align="right">
           		<form id='searchForm' class="form-inline" action="<c:url value='/noticeBoard/noticeList' />" method='get'>
           			<select id="order" name="order" class="form-control col-sm-2" >
                   		<option value="date" ${pc.paging.order == 'date'? 'selected':'' }>최신순</option>
                   		<option value="view" ${pc.paging.order == 'view'? 'selected':'' }>조회수순</option>
                   		<option value="reply" ${pc.paging.order == 'reply'? 'selected':'' }>댓글수순</option>
                   		<option value="like" ${pc.paging.order == 'like'? 'selected':'' }>좋아요순</option>
                   		<c:if test="${loginuser.memberManagerYN=='YES' }">
                    		<option value="report" ${pc.paging.order == 'report'? 'selected':'' }>신고수순</option>
                   		</c:if>
                   		
                   	</select>
	    			<select class="form-control search-select" name="condition" id="condition">
						<option value="titleContent" ${pc.paging.condition == 'titleContent' ? 'selected' : ''}>전체</option>
						<option value="title" ${pc.paging.condition == 'title' ? 'selected' : ''}>제목</option>
						<option value="content" ${pc.paging.condition == 'content' ? 'selected' : ''}>내용</option>
                   	</select>
                  
               		<input type="text" id="search-input" class="form-control search-input" name="keyword" placeholder="Search" value="${pc.paging.keyword }">
                   	<button type="button" class="btn" aria-label="Left Align" id="searchBtn">
                 			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
               		</button>
                   
	    		</form>
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
					<c:if test="${fn:length(noticeList) == 0 }">
						 <tr>
						 	<td colspan=5><p class="search-none">검색 결과가 없습니다.</p></td>
					 	<tr>
					</c:if>
					<c:forEach var="arr" items="${noticeList }">
                    
                      <tr ${(loginuser.memberManagerYN=="YES" && arr.nbReportCount > 0)? "style='background-color:red'":"" } onclick="location.href='<c:url value="/noticeBoard/noticeDetail?nbNum=${arr.nbNum }&pageNum=${pc.paging.pageNum}&keyword=${pc.paging.keyword }&condition=${pc.paging.condition }&category=${pc.paging.category }&order=${pc.paging.order }" />'">
                        <th scope="col" class="text-center">${arr.nbNum }</th>
                        <th scope="col">${fn:replace(fn:replace(fn:replace(arr.nbTitle,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") }&nbsp;&nbsp;&nbsp;[${arr.nbReplyCount}]</th>
                        <th scope="col" class="text-center">관리자</th>
                        <th scope="col" class="text-center"><fmt:formatDate value="${arr.nbRegDate }" pattern="yyyy-MM-dd"/></th>
                        <th scope="col" class="text-center">${arr.nbLookCount }</th>
                      </tr>
                    </c:forEach>
                    	
  						


                    </tbody>
                </table>

                
            </div>
			
           <div class="row" align="right">
                <button type="button" id="write" class="btn btn-outline-primary" onclick="location.href='<c:url value="/noticeBoard/noticeWrite" />'"><b>글쓰기</b></button>
             </div>
			</div>
            <div class="row text-center">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                      <c:if test="${pc.prev }">
	                    <li class="page-item"><a class="page-link" href="<c:url value='/noticeBoard/?pageNum=${pc.beginPage-1 }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />">Prev</a></li>
                      </c:if>
                      
                      <c:forEach var="page" begin="${pc.beginPage }" end="${pc.endPage }">
                      	<li class="page-item ${page == pc.paging.pageNum? 'active':''}"><a class="page-link" href="<c:url value='/noticeBoard/?pageNum=${page }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />">${page }</a></li>
                      </c:forEach>
               
                      
                      <c:if test="${pc.next }">
	                    <li class="page-item"><a class="page-link" href="<c:url value='/noticeBoard/?pageNum=${pc.endPage+1 }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />">Next</a></li>
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
   	$('#searchBtn').click(function(){
   		
   		const condition = $('#condition').val();
		const keyword = $('#search-input').val();
		const order = $('#order').val();
			
   		
		  location.href = '/wefit/noticeBoard/?condition=' + condition + '&keyword=' + keyword+ '&order=' + order;
	});
   	
   	$('#search-input').keydown(function(key){ 
		if(key.keyCode === 13) {
			key.preventDefault();
			$('#searchBtn').click(); 
		}				
  });

  </script>
    
</body>
</html>