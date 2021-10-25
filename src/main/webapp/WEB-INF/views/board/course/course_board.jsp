<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
       
        

        #course {
          color: rgb(0, 173, 181);
          font-size: 45px;
          font-weight: bold;
          cursor: pointer;
          
          margin-left: 20px;
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
          
            margin-top: 5px;
        
        }





        .vid {
            margin: 25px 5px;
            padding: 5px;
            border: 1px solid #ccc;
            /* background: rgb(0, 173, 181); */
 
        }



        .vid .video {
            /* border: 1px solid #fff; */
            background: #fff;
            padding: 10px;
            cursor: pointer;
        }


        .subject {
            height: 70px;
            margin: 20px 30px 50px 30px;
        }

        .category {
            display: block;
            text-align: left;
            margin: 5px 0;
            padding: 5px 0;
            border-bottom: 1px solid #ccc; 
            font-size: 13px;
            font-weight: 500;
            color: #5a5a5a;
        }

        .auth {
            text-align: left;
            font-size: 15px;
            padding: 0 13px;
            overflow: hidden;
            margin-top: 30px;
        }

        .auth span {
            float: right;
            font-size: 14px;
            padding-left: 22px;
            
            position: relative;
            top: 4px;
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

		.active {
			background-color: #643691; 
		}
				
 		.search-area {
			margin-top: 15px;
			margin-right: 10px;
		} 
		
		.search-none {
			margin: 40px;
			font-size: 20px;
			text-align: center;
		}
		
		.form-control {
			margin-right : 5px;
		}
		.form-inline {
			margin-left:5px;
			margin-bottom : 20px;
		}
    /* 		td .text-center {
  			width: 80px;
  		} */
		
      
    </style>
</head>

<body>
    
    <div class="container-fluid h-100">

        <div class="row">
            <%@ include file="../../include/header.jsp" %>
        </div>
  
        <!-- <div class="row">
                
            <div class="col-sm-5">
                <span id="title">자유게시판</span>
            </div>

            <div class="col-sm-7">
                <div id="btn-list" class="row" align="right">
                    <div class="btn-group text-center" role="group" aria-label="Basic outlined example">
                    <button type="button" class="btn btn-info btn-active" id="all">전체</button>
                    <button type="button" class="btn btn-info">자유글</button>
                    <button type="button" class="btn btn-info">소식/정보</button>
                    <button type="button" class="btn btn-info">홍보</button>
                    <button type="button" class="btn btn-info">꿀팁</button>
                    <button type="button" class="btn btn-info">기타</button>&nbsp;&nbsp;&nbsp;
                </div>
                
                <input type="text" placeholder="Search">
                  
                <button type="button" class="btn" aria-label="Left Align">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                </button>

                </div>
            </div>
        </div> -->

        <div class="row">
        	<div class="container">
                <div class="row">
                    <div class="col-sm-5" align="left">
                        <span id="course">운동 강의</span>
                    </div>
                    <div id="btn-list" class="row" align="right">
                        <div id="category-btn" class="btn-group text-center " role="group" aria-label="Basic outlined example">
                            <button type="button" class="btn btn-info ${param.category == '' ? 'active' : ''}" value="">전체</button>
                            <button type="button" class="btn btn-info ${param.category == 'swimming' ? 'active' : ''}" value="swimming">수영</button>
                            <button type="button" class="btn btn-info ${param.category == 'badminton' ? 'active' : ''}" value="badminton">배드민턴</button>
                            <button type="button" class="btn btn-info ${param.category == 'squash' ? 'active' : ''}" value="squash">스쿼시</button>
                            <button type="button" class="btn btn-info ${param.category == 'bicycle' ? 'active' : ''}" value="bicycle">자전거</button>
                            <button type="button" class="btn btn-info ${param.category == 'running' ? 'active' : ''}" value="running">달리기</button>
                            <button type="button" class="btn btn-info ${param.category == 'hiking' ? 'active' : ''}" value="hiking">등산</button>
                            <button type="button" class="btn btn-info ${param.category == 'training' ? 'active' : ''}" value="training">홈트짐트</button>
                            <button type="button" class="btn btn-info ${param.category == 'pilates' ? 'active' : ''}" value="pilates">필라테스</button>
                            <button type="button" class="btn btn-info ${param.category == 'golf' ? 'active' : ''}" value="golf">골프</button>
                            <button type="button" class="btn btn-info ${param.category == 'skate' ? 'active' : ''}" value="skate">스케이트</button>
                            <button type="button" class="btn btn-info ${param.category == 'etc' ? 'active' : ''}" value="etc">기타</button>&nbsp;&nbsp;&nbsp;
                        </div>
                        
                        
                    
                    </div>
                	<div class="form-inline search-area pull-right">
                            	<select id="order" class="form-control col-sm-2" >
                            		<option value="date" ${pc.paging.order == 'date'? 'selected':'' }>최신순</option>
                            		<option value="view" ${pc.paging.order == 'view'? 'selected':'' }>조회수순</option>
                            		<option value="reply" ${pc.paging.order == 'reply'? 'selected':'' }>댓글수순</option>
                            		<option value="like" ${pc.paging.order == 'like'? 'selected':'' }>좋아요순</option>
                            		<c:if test="${loginuser.memberManagerYN=='YES' }">
	                            		<option value="report" ${pc.paging.order == 'report'? 'selected':'' }>신고수순</option>
                            		</c:if>
                            		
                            	</select>
                            	
                            	
                                <select id="search-category" class="form-control col-sm-2" >
                                    <option value="">강의 전체</option>
                                    <option value="swimming" ${param.category == 'swimming' ? 'selected' : '' }>수영</option>
                                    <option value="badminton" ${param.category == 'badminton' ? 'selected' : '' }>배드민턴</option>
                                    <option value="squash" ${param.category == 'squash' ? 'selected' : '' }>스쿼시</option>
                                    <option value="bicycle" ${param.category == 'bicycle' ? 'selected' : '' }>자전거</option>
                                    <option value="running" ${param.category == 'running' ? 'selected' : '' }>달리기</option>
                                    <option value="hiking" ${param.category == 'hiking' ? 'selected' : '' }>등산</option>
                                    <option value="training" ${param.category == 'training' ? 'selected' : '' }>홈트짐트</option>
                                    <option value="pilates" ${param.category == 'pilates' ? 'selected' : '' }>필라테스</option>
                                    <option value="golf" ${param.category == 'golf' ? 'selected' : '' }>골프</option>
                                    <option value="skate" ${param.category == 'skate' ? 'selected' : '' }>스케이트</option>
                                    <option value="etc" ${param.category == 'etc' ? 'selected' : '' }>기타</option>
                                 </select>
                            
                            	
                            	
                            	<select id="search-condition" class="form-control col-sm-2">
	                                <option value="title" ${param.condition == 'title' ? 'selected' : '' }>제목</option>
	                                <option value="content" ${param.condition == 'content' ? 'selected' : '' }>내용</option>
	                                <option value="titleContent" ${param.condition == 'titleContent' ? 'selected' : '' }>제목+내용</option>
                            	</select>
                           
                            	
                            
	                            <input type="text" id="search-keyword" placeholder="Search" class="form-control" value="${param.keyword}">
	                             
	                            <button type="button" id="search-btn" class="btn" aria-label="Left Align">
	                                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
	                            </button>
                    </div>    
                
            </div>
            
        </div>  
        
		
		
		        
        
  
  
  
	<div class="container text-center"> 

        <div class="row margin-top-5">

            <table class="table">

                <tbody>
                
					<c:choose>
					    
					    <c:when test="${fn:length(courseList) == 0}">
					        <p class="search-none">검색 결과가 없습니다.</p>
					    </c:when>
					    
					    <c:otherwise>
							<c:forEach var="vo" varStatus="i" items="${courseList}">		                   	   
		                       <c:if test="${i.count % 3 == 1}">
		                          <tr class="course"> 
		                       </c:if>  
		                              <td scope="col" class="text-center" style="width: 33%;">
		                                  <div class="vid">                               
		                                      <div class="video" ${(loginuser.memberManagerYN=="YES" && vo.cbReportCount > 0)? 'style="background-color:red"':'' } onclick="location.href='<c:url value="/courseBoard/detail?cbNum=${vo.cbNum}&pageNum=${pc.paging.pageNum}&category=${pc.paging.category}&condition=${pc.paging.condition}&keyword=${pc.paging.keyword}&order=${pc.paging.order}" />'">
		                                         <%--  <a href="<c:url value='/courseBoard/detail?cbNum=${vo.cbNum}&pageNum=${pc.paging.pageNum}&category=${pc.paging.category}&condition=${pc.paging.condition}&keyword=${pc.paging.keyword}' />"> --%> <!-- 여기도 detail요청 링크를 거니까 조회수가 2씩 증가함... -->
		                                          <img src="https://img.youtube.com/vi/${vo.cbYouCode}/mqdefault.jpg" width="280px" alt="${vo.cbYouCode}" /><!-- </a>  -->                            
		                                          
		                                          <p class="subject"><span class="category">${vo.cbCategory}</span><a href="#">${fn:replace(fn:replace(fn:replace(vo.cbTitle, replaceChar2,"&gt;"),replaceChar1,"&lt;"),replaceChar,"<br/>") }</a></p>
		                                          <p class="auth">관리자 &nbsp;&nbsp;
		                                          	  <small class="writeday"><fmt:formatDate value="${vo.cbRegDate}" pattern="yy.MM.dd" /></small>  
		                                              <span class="glyphicon glyphicon-comment" aria-hidden="true"><b>${vo.crCount}</b></span>
		                                              <span class="glyphicon glyphicon-eye-open" aria-hidden="true"><b>${vo.cbLookCount}</b></span>
		                                          	  
		                                          </p>
		                                      </div>
		                                  </div>
		                              </td> 
		                       
				                      <c:if test="${i.count % 9 == 1 && i.count == fn:length(courseList)}">
				                         <td></td>
				                         <td></td>
				                      </c:if>
				                       
				                      <c:if test="${i.count % 9 == 2 && i.count == fn:length(courseList)}">
				                         <td></td>
				                      </c:if>                    
		                       
		       				   <c:if test="${i.count % 3 == 0}">
		                          </tr>
		                       </c:if>
		                    </c:forEach> 					   
					    </c:otherwise> 
					
					</c:choose>
                                                                  
                </tbody>
              </table>
        </div>

            <div class="row" align="right">
                <c:if test="${loginuser.memberManagerYN == 'YES'}">
                	<button type="button" class="btn btn-outline-primary" onclick="location.href='<c:url value="/courseBoard/write?category=${param.category}" />' "><b>글쓰기</b></button>
            	</c:if>
            </div>


        <div class="row text-center">
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <c:if test="${pc.prev}"> 
	                    <li class="page-item"><a class="page-link" href="<c:url value='/courseBoard/?pageNum=${pc.beginPage - 1}&category=${param.category}&condition=${param.condition}&keyword=${param.keyword}&order=${pc.paging.order }' />">Prev</a></li>
	                </c:if>  
	                <c:forEach var="pageNum" begin="${pc.beginPage}" end="${pc.endPage}"> 
	                    <li class="page-item ${pc.paging.pageNum == pageNum ? 'active' : ''}">
	                    	<a class="page-link" href="<c:url value='/courseBoard/?pageNum=${pageNum}&category=${param.category}&condition=${param.condition}&keyword=${param.keyword}&order=${pc.paging.order }' />">${pageNum}</a>
	                    </li>
					</c:forEach>


<!-- 	                <li class="page-item"><a class="page-link" href="#">2</a></li>
	                    <li class="page-item"><a class="page-link" href="#">3</a></li>
	                    <li class="page-item"><a class="page-link" href="#">4</a></li>
	                    <li class="page-item"><a class="page-link" href="#">5</a></li> -->
	                <c:if test="${pc.next}">   
	                    <li class="page-item"><a class="page-link" href="<c:url value='/courseBoard/?pageNum=${pc.endPage + 1}&category=${param.category}&condition=${param.condition}&keyword=${param.keyword}&order=${pc.paging.order }' />">Next</a></li>
                	</c:if> 
                </ul>
                </nav>
        </div> 
	
	</div> <!-- div class="container text-center" -->
        
        <div class="row">
            <%@ include file="../../include/footer.jsp" %>
        </div>

        
    </div>
    
    <script defer>
    
/*        const msg = '${msg}';
       if(msg === 'registSuccess') {
          alert('게시글이 등록되었습니다.');
       } else if(msg === 'deleteSuccess') {
          alert('삭제가 완료되었습니다.');
       } */
       
      $(document).ready(function(){
            
            
            $('.vid').hover(function() {   
                $(this).css('background-color', 'rgb(0, 173, 181)');
                
            });
      
            $('.vid').mouseleave(function() {   
                $(this).css('background-color', '#fff');
                
            });
      
      
        });
      
      
      $(function() { // start jQuery

    	  // 운동강의 클릭하면..
    	  $('#course').click(function() {
    		  location.href='<c:url value="/courseBoard/?category=" />';
    	  });
    	  
    	  // 카테고리별 보여주기
    	  $('#category-btn > .btn-info').click(function() {
    		  const category = $(this).val();
	  		  location.href = '/wefit/courseBoard/?category=' + category;	  		  
    		  
    	  });
      
      
      	  // 검색기능 구현
		  $('#search-btn').click(function() {
			  const category = $('#search-category').val();
			  const condition = $('#search-condition').val();
			  const keyword = $('#search-keyword').val();
			  const order = $('#order').val();
			  location.href = '/wefit/courseBoard/?category=' + category + '&condition=' + condition + '&keyword=' + keyword + '&order=' + order;
		  });  
      	  
      	  
		  $('#search-keyword').keydown(function(key){ //keydown은 키 누르면
				if(key.keyCode === 13) {//13번은 엔터키
					$('#search-btn').click(); //엔터키 누르면 검색버튼을 클릭한거랑 동일한 이벤트처리를 해주고싶다.
				}				
		  });
      
      
      }); // end jQuery
      
  </script>
</body>
</html>