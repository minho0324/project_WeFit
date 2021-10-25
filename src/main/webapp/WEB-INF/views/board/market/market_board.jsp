<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<% pageContext.setAttribute("replaceChar", "\n"); %>
<% pageContext.setAttribute("replaceChar1", "<"); %>
<% pageContext.setAttribute("replaceChar2", ">"); %>

<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    


    <style>

        body {
            width: 100%;
        }

        .row>h2 {
            width: 100%;
            
            margin-bottom: 20px;
            padding: 20px 0px 20px 10px;
            font-size: 40px;
            font-weight: bold;
            color: rgb(0, 173, 181);
            
        }

        .table {
            border-collapse: collapse;
            margin-top: 50px;
        }

        .table > thead > tr {
            background: rgb(220, 221, 221);
            text-align: center;
        }


        .table a img {
            width: 240px;
            height: 220px;
            padding: 5px;
        }

        .table tbody tr td {
            text-align: center;
            border-top-width: 0px;
            border: 1px solid #d9edf7;
        }


        .search-sec {
            margin-top:20px;
            
        }
	
		.gray-row{
			background: rgb(220, 221, 221);
			padding:20px 20px;
		}
		#searchInput{
		  padding: 5px;
          border: 1px solid lightgray;
          
          width: 200px;
		}

        .table tr td a {
            text-decoration: none;
            color: darkgrey;

        }

        .table tr td a h2 {
            font-size: 25px;
            color: black;
        }

        .table tr td a h3 {
            font-size: 18px;

        }

        .tools {
            text-align: center;
            
        }

        .header-sec {
            height: 140px;
            
        }
        .footer-sec {
            margin-top: 20px;
        }

        #write {
            position: absolute;
            top: 1455px;
            left: 850px;
        }
        .side_bar {
            position: fixed;
            top: 500px;
            left: 1550px;
        }
        #course {
          color: rgb(0, 173, 181);
          font-size: 45px;
          font-weight: bold;
          cursor: pointer;
          
          margin-left: 20px;
        }
        .vid {
            margin: 25px 5px;
            padding: 5px;
            border: 1px solid #ccc;
            /* background: rgb(0, 173, 181); */
 
        }
        .vid .video {
            /* border: 1px solid #fff; */
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
    </style>

</head>

<body>

    <div class="container-fluid h-100">
	    <!--헤더-->
    	<div class="row">
            <%@ include file="../../include/header.jsp" %>
        </div>
        <div class="container text-center"> 
        	<div class="row">
	            <h2 align="left">중고장터</h2>
			</div>
			<div class="row gray-row">
				<button class="btn btn-default" onclick="location.href='<c:url value="/marketBoard/market_board?category=buy" />'">삽니다</button>
	      		<button class="btn btn-default" onclick="location.href='<c:url value="/marketBoard/market_board?category=sell" />'">팝니다</button>
	      		<button class="btn btn-default" onclick="location.href='<c:url value="/marketBoard/market_board?category=share" />'">나눠요</button>
	      		<button class="btn btn-default" onclick="location.href='<c:url value="/marketBoard/market_board" />'">전체 보기</button><br/>
	      		<div class="search-sec row pull-right">
                	<form class="form-inline" action="<c:url value='/marketBoard/market_board' />">
						<select id="order" name="order" class="form-control col-sm-2" >
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
                    		<option value="price" ${pc.paging.order == 'price'? 'selected':'' }>가격순</option>
                    	</select>
		                <!--검색 조건-->
		                <select class="search-condition form-control" name="condition">
	                        <option value="title" ${param.condition == 'title' ? 'selected' : '' }>상품이름</option>
	                        <option value="addr" ${param.condition == 'addr' ? 'selected' : '' }>지역</option>
                       	</select>
                         <c:if test="${loginuser != null && loginuser.memberLatitude != 0.0 }">
	                        <select class="form-control" id="search-distance" name="distance" >
		                      	<option value="15000" ${param.distance==15000? 'selected':'' }>거리선택</option>
		                       	<option value="2" ${param.distance==2? 'selected':'' }>2km 이내</option>
		                       	<option value="5" ${param.distance==5? 'selected':'' }>5km 이내</option>
		                       	<option value="10" ${param.distance==10? 'selected':'' }>10km 이내</option>
	                        </select>
                        </c:if>
           				<input type="hidden" name="category" value="${pc.paging.category }"/>
                        <!--검색창, 버튼-->
                        <input id="searchInput" type="text" name="keyword" placeholder="Search" class="form-control" value=${pc.paging.keyword }>
                        <button type="submit" class="btn" aria-label="Left Align">
                        	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                        </button>
           				<c:if test="${loginuser!=null }">
		                	<input type="hidden" name="latitude" value="${loginuser.memberLatitude}">
		                	<input type="hidden" name="longitude" value="${loginuser.memberLongitude}">	
		                </c:if>
					</form>
            	</div>
			</div>
			<div class="row margin-top-5">

	            <table class="table">
	
	                <tbody>
	                
						<c:choose>
						    
						    <c:when test="${fn:length(product) == 0}">
						        <p class="search-none">검색 결과가 없습니다.</p>
						    </c:when>
						    
						    <c:otherwise>
								<c:forEach var="vo" varStatus="i" items="${product}">		                   	   
			                       <c:if test="${i.count % 3 == 1}">
			                          <tr class="course"> 
			                       </c:if>  
			                              <td scope="col" class="text-center" style="width: 33%" onclick="location.href='<c:url value='/marketBoard/market_detail?mbNum=${vo.mbNum }&pageNum=${pc.paging.pageNum }&keyword=${pc.paging.keyword }&condition=${pc.paging.condition }' />'">
			                                  <div class="vid" >                               
			                                      <div class="video" ${(loginuser.memberManagerYN=="YES" && vo.mbReportCount > 0)? 'style="background-color:red"':'' }>
			                                         <%--  <a href="<c:url value='/courseBoard/detail?cbNum=${vo.cbNum}&pageNum=${pc.paging.pageNum}&category=${pc.paging.category}&condition=${pc.paging.condition}&keyword=${pc.paging.keyword}' />"> --%> <!-- 여기도 detail요청 링크를 거니까 조회수가 2씩 증가함... -->
			                                          <c:if test="${vo.mbImageCount == 0 }">
				                                          <img src="${pageContext.request.contextPath }/resources/img/logo/logo.png" width="280px" height="160px" alt="" /><!-- </a>  -->                            
			                                          
			                                          </c:if>
			                                          <c:if test="${vo.mbImageCount != 0 }">
				                                          <img src="/upload/board/market/${vo.memberNum}/${vo.mbRealImage1}" width="280px" height="160px" alt="" /><!-- </a>  -->                            
			                                          
			                                          </c:if>
														
																	                                          
			                                          <p class="subject">
			                                          		<span class="category">
			                                          			<c:if test="${vo.mbType == 'sell' }"> 팝니다</c:if> 
																<c:if test="${vo.mbType == 'buy' }"> 삽니다</c:if> 
																<c:if test="${vo.mbType == 'share' }"> 나눠요</c:if>
		                                          			</span>
			                                          		<a href="#">${fn:replace(fn:replace(fn:replace(vo.mbTitle,replaceChar2,"&gt;"),replaceChar1,"&lt;"),replaceChar,"<br/>") }</a><br>
			                                          		<a href="#">${vo.mbAddrBasic}</a><br>
															
															<a href="#">가격: ${vo.mbPrice }원</a>
	                                          		  </p>
			                                          <p class="auth">${vo.memberNick } &nbsp;&nbsp;
			                                          	  <small class="writeday"><fmt:formatDate value="${vo.mbRegDate}" pattern="yy.MM.dd" /></small>  
			                                              <span class="glyphicon glyphicon-comment" aria-hidden="true"><b>${vo.mbReplyCount }</b></span>
			                                              <span class="glyphicon glyphicon-eye-open" aria-hidden="true"><b>${vo.mbLookCount}</b></span>
			                                          	  
			                                          </p>
			                                      </div>
			                                  </div>
			                              </td> 
			                       
					                      <c:if test="${i.count % 9 == 1 && i.count == fn:length(product)}">
					                         <td></td>
					                         <td></td>
					                      </c:if>
					                       
					                      <c:if test="${i.count % 9 == 2 && i.count == fn:length(product)}">
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
	        <!--글쓰기 버튼-->
		            
	        <button id="writeBtn" type="button" class="btn btn-outline-primary pull-right">글쓰기</button>
        </div>
        <!-- 페이징 버튼-->
		<form action="<c:url value='/marketBoard/market_board' />" name="pageForm">
			<div class="row text-center">
				<nav aria-label="Page navigation example">
					<ul class="pagination" id="pagination">
						
						<c:if test="${pc.prev }">
							<li class="page-item">
								<a class="page-link" href="<c:url value='/marketBoard/market_board/?pageNum=${pc.beginPage-1 }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />">이전</a>
							</li>
						</c:if>

						<c:forEach var="i" begin="${pc.beginPage}" end="${pc.endPage}">
							<li class="page-item ${i == pc.paging.pageNum? 'active':''}">
								<a href="<c:url value='/marketBoard/market_board?pageNum=${i }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />" >${i }</a>
							</li>
						</c:forEach>
							<c:if test="${pc.next }">
							<li class="page-item">
								<a class="page-link" href="<c:url value='/marketBoard/market_board/?pageNum=${pc.endPage+1 }&condition=${pc.paging.condition }&keyword=${pc.paging.keyword }&order=${pc.paging.order }' />" >다음</a>
							</li>
							</c:if>
					</ul>
				</nav>
			</div>
			    <input type="hidden" name="pageNum" value="${pc.paging.pageNum}">
                <input type="hidden" name="countPerPage" value="${pc.paging.countPerPage}">
                <input type="hidden" name="keyword" value="${pc.paging.keyword}">
                <input type="hidden" name="condition" value="${pc.paging.condition}">
                <c:if test="${loginuser!=null }">
                	<input type="hidden" name="latitude" value="${loginuser.memberLatitude}">
                	<input type="hidden" name="longitude" value="${loginuser.memberLongitude}">	
                </c:if>
		</form>
        <div class="row">
            <%@ include file="../../include/footer.jsp" %>
        </div>
	    
	    
    </div>
    
        
    
</body>

<script>
	$(document).ready(function(){
		$('#writeBtn').click(function() {
			if(${loginuser==null}){
				alert('로그인이 필요합니다.');
				history.back();
				return;
			}else{
				location.href="<c:url value='/marketBoard/market_write' />"
			}
		});
		$('.vid').hover(function() {   
            $(this).css('background-color', 'rgb(0, 173, 181)');
            
        });
  
        $('.vid').mouseleave(function() {   
            $(this).css('background-color', '#fff');
            
        });
		
		
	})
	
	 
	
	
</script>




</html>


