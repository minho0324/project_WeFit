<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<% pageContext.setAttribute("replaceChar", "\n"); %>
<% pageContext.setAttribute("replaceChar1", "<"); %>
<% pageContext.setAttribute("replaceChar2", ">"); %>


<body>
   <style>
   
      
      .col-md-6 h2 {
         color: rgb(0, 173, 181);
         font-weight:700;
      }
      
      .col-md-12 h2 {
         color: rgb(0, 173, 181);
         font-weight:700;
      }
        
        
        .section{
            height: 1200px;
        }
        .sidebar{
            background-color: yellow;
            position: fixed;
            right: 15px ;
            top: 250px;
        }
        .section .main_img {
            width: 100%;
           /*  height: 400px; */
        }
        .carousel-inner .item {
            vertical-align: middle;
            width: 100%;
            height: 360px;
        }

        .carousel-inner .item img {
            max-width:100%; 
            max-height:100%;
            display:inline-block;
            vertical-align:middle;
        }

        .item h3{
            color: black;
            font-weight: bold;
            font-size: 24px;
            line-height: 30px;
        }

        .container {
            margin: 0px;
            padding: 0px;
            width: 100%;
            height: 800px;
        }
        
        .glyphicon-bullhorn {        
           margin-right: 2px;
           color: #a8a89e;
        }

      .reply {
         font-size: 8px;      
      }
      
      
      


        .vid .video {
            /* border: 1px solid #fff; */
            background: #fff;
            
            cursor: pointer;
        }


        .subject {
           height: 20px;
            margin-top: 10px;
        }

        .auth {
            text-align: left;
            font-size: 10px;
            padding: 0 13px;
            overflow: hidden;
            margin: 5px 0 0 0;
        }

        .auth span {
            float: right;
            font-size: 10px;
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
        
      .inactvie {      
         display : none;
      }
      
      h2 > .btn-light  {         
         float: right;
         background-color: rgb(0, 173, 181);
         color: #fff;
         opacity: 50%;
      }
      
      #diet > h2 {
         overflow: hidden;
      }
      
      #market > h2 {
         overflow: hidden;
      }
      
      #diet {
         border-right: 1px solid #ccc;         
      }
      
      .container > .secondary {
         margin-top: 130px;
         padding : 10px;
      }
      
      .container > .third {
         margin-top: 10px;
      }
      
      .title {
        font-weight: bold;
        font-size: 12px;
        margin: 0 3px 15px 3px;
        height: 60px;
      }
      .title-hover:hover{
      	cursor: pointer;
      }
      
      .category {
         overflow: hidden;
         margin: 3px;
      }
      
      .icon {
         float: right;
      }
      
      .notice > .well {
         padding-bottom: 10px;
         height:600px;
         overflow: auto;
      }
      
      .sentence {
         margin-bottom: 17px;
      }



    </style>
    
    <div class="container-fluid h-100">

        <div class="row">
            <%@ include file="include/header.jsp" %>
        </div>

        <div class="row"> 
            <div class="section">

                <div class="container">
                
                   <div class="col-md-12">
                       <img src="${pageContext.request.contextPath }/resources/img/main/main.png" alt="main" width="100%" class="main_img">
                   </div>
                    
                    
                    <div class="row secondary">
                       <div id="diet" class="col-md-6">
                         <h2><span id="dietTitle" class="title-hover">오늘의 식단</span><button type="button" id="dietBtn" class="btn btn-light">></button></h2>
                         
                         <table class="table">
                          <tbody>
                                
                           <c:forEach var="arr" varStatus="i" items="${dietlist }">
                              <c:if test="${i.count % 4 == 3 }">
                                 <tr class="diet hidden inactive">
                              </c:if>
                              <c:if test="${i.count % 4 == 1 }">
                                 <tr class="diet">
                              </c:if>
                                    <td scope="col" class="text-center">                                 
                                              <div class="vid">                               
                                                  <div class="video" onclick="location.href='<c:url value="/dietBoard/dietDetail?dbNum=${arr.dbNum }" />'">
                                                        <c:if test="${arr.dbRealImage1 != null }">
                                                <img
                                                   src="/upload/board/diet/${arr.memberNick}/${arr.dbRealImage1}"
                                                   width="200px" height="150px" alt="vid01">
                                             </c:if>
                                             <c:if test="${arr.dbRealImage1 == null }">
                                                <img
                                                   src="${pageContext.request.contextPath }/resources/img/logo/logo.png"
                                                   width="200px" height="150px" alt="vid01">
                                             </c:if>
                                                  
                                                      <p class="subject"><a href="#">${fn:replace(fn:replace(fn:replace(arr.dbTitle,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") }</a></p>
                                                      <p class="auth">${arr.memberNick } &nbsp;&nbsp;
                                                           <small class="writeday"><fmt:formatDate value="${arr.dbRegDate }" pattern="MM.dd" /></small>  
                                                          <span class="glyphicon glyphicon-comment" aria-hidden="true"><b>${arr.drCount }</b></span>
                                                          <span class="glyphicon glyphicon-eye-open" aria-hidden="true"><b>${arr.dbLookCount }</b></span>
                                                           
                                                      </p>
                                                  </div>
                                              </div>
                                    </td>
                                    <c:if test="${i.count%2==0 }">
                                       </tr>
                                    
                                    </c:if>
                                  </c:forEach>
                          </tbody>         
                        </table>
                      </div>
                      
                      
                       
                       <div id="market" class="col-md-6">
                         <h2><span id="marketTitle" class="title-hover">장터</span><button type="button" id="marketBtn" class="btn btn-light">></button></h2>
                         
                         <table class="table">
                          <tbody>
                             <c:forEach var="arr" varStatus="i" items="${marketlist }">
                              <c:if test="${i.count % 4 == 3 }">
                                 <tr class="market hidden inactive">
                              </c:if>
                              <c:if test="${i.count % 4 == 1 }">
                                 <tr class="market">
                              </c:if>
                              <td scope="col" class="text-center">                                 
                                        <div class="vid">                               
                                            <div class="video" onclick="location.href='<c:url value="/marketBoard/market_detail?mbNum=${arr.mbNum }&pageNum=1&keyword=&condition=" />'">
                                                  <c:if test="${arr.mbRealImage1 != null }">
                                          <img
                                             src="/upload/board/market/${arr.memberNum}/${arr.mbRealImage1}"
                                             width="200px" height="150px" alt="vid01">
                                       </c:if>
                                       <c:if test="${arr.mbRealImage1 == null }">
                                          <img
                                             src="${pageContext.request.contextPath }/resources/img/logo/logo.png"
                                             width="200px" height="150px" alt="vid01">
                                       </c:if>
                                            
                                                <p class="subject"><a href="#">${fn:replace(fn:replace(fn:replace(arr.mbTitle,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") }</a></p>
                                                <p class="auth">${arr.memberNick } &nbsp;&nbsp;
                                                     <small class="writeday"><fmt:formatDate value="${arr.mbRegDate }" pattern="MM.dd" /></small>  
                                                    <span class="glyphicon glyphicon-comment" aria-hidden="true"><b>${arr.mbReplyCount }</b></span>
                                                    <span class="glyphicon glyphicon-eye-open" aria-hidden="true"><b>${arr.mbLookCount }</b></span>
                                                     
                                                </p>
                                            </div>
                                        </div>
                              </td>
                              <c:if test="${i.count%2==0 }">
                                 </tr>
                              </c:if>
                            </c:forEach>
                              
                          </tbody>         
                        </table>
                      </div>      
                  </div> <!-- end secondary -->
                
                <div class="row third">   
                
                <div class="col-md-9">
                   <div class="col-md-12">
                         <h2><span id="courseTitle" class="title-hover">운동강의</span></h2>
                         
                         <table class="table">
                          <tbody>
                                <c:forEach items="${courselist }" var="arr" varStatus="i">
                                    <c:if test="${i.count % 2 == 1 }">
                                       <tr>
                                    </c:if>
                                   
                                    <td width="20%">      
                                        <a href="<c:url value="/courseBoard/detail?cbNum=${arr.cbNum}&pageNum=1&category=&condition=&keyword=" />">
                                        <img src="https://img.youtube.com/vi/${arr.cbYouCode}/mqdefault.jpg" width="170px" alt="" /></a>
                                    </td>    
                                    <td width="30%">    
                                            <p class="title"><a href="<c:url value="/courseBoard/detail?cbNum=${arr.cbNum}&pageNum=1&category=&condition=&keyword=" />">${fn:replace(fn:replace(fn:replace(arr.cbTitle,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") }</a></p>   
                                            
                                            <div class="category">${arr.cbCategory }
                                               <span class="icon">
                                                  <span class="glyphicon glyphicon-eye-open" aria-hidden="true"><b>${arr.cbLookCount }</b></span>&nbsp;&nbsp;&nbsp;&nbsp;
                                                  <span class="glyphicon glyphicon-comment" aria-hidden="true"><b>${arr.crCount }</b></span>              
                                              </span>
                                            </div> <!—end category—>                
                                    </td>
                                   
                                   <c:if test="${i.count % 2 == 0 }">
                                      </tr>
                                   </c:if>
                                </c:forEach>
                              
                          </tbody>         
                        </table>
                      </div>
                   
                   <div class="row">    
                       <div class="col-md-6">                        
                        <div class="col-md-12">
                               <h2><span id="freeTitle" class="title-hover">자유게시판</span></h2>
                               
                               <table class="table">
                                <tbody>
                                      <c:forEach var="arr" items="${freelist }">
                                         <tr>
                                       <td class="col-md-3">${fn:split(arr.fbTitle,']')[0] }]</td>
                                       <td class="col-md-7"><a href="<c:url value="/freeBoard/freeDetail?fbNum=${arr.fbNum }" />">${fn:replace(fn:replace(fn:replace(fn:split(arr.fbTitle,']')[1],replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") } <span class="reply">[${arr.fbReplyCount }]</span></a></td>
                                       <td class="col-md-2"><fmt:formatDate value="${arr.fbRegDate }" pattern="MM.dd" /></td>
                                       </tr>
                                      </c:forEach>
                                </tbody>         
                              </table>
                            </div>
                        
                        </div>
                        
                        <div class="col-md-6">
                        
                        <img src="${pageContext.request.contextPath }/resources/img/main/main4.jpg" alt="" style="width:100%;">
                             
                        </div>
                     
                     </div>
                </div>
                    

                    
                <div class="col-md-3 notice">
                    <div class="well">
                       <h4><span id="noticeTitle" class="title-hover">공지사항</span></h4>
                       
                       <br />
                       <c:forEach var="arr" items="${noticelist }">
                          <p class="sentence">
                              <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span>
                              <span class="notice"><a href="<c:url value="/noticeBoard/noticeDetail?nbNum=${arr.nbNum }"/>">${fn:replace(fn:replace(fn:replace(arr.nbTitle ,replaceChar2,"&gt;" ),replaceChar1,"&lt;"),replaceChar,"<br/>") } </a></span>
                           </p>
                       
                       </c:forEach>
                    </div>
                </div>
                 </div> 
                    
                  </div> <!— end container —>

            </div> <!—  end section —>
            
            
            
        </div> <!— end row —>



        <div class="row">
            <%@ include file="include/footer.jsp" %>
        </div>
      
        
    </div>
    
</body>

<script>
   $(function() { //start jQuery
      
      $('#dietBtn').click(function (){
         $(".diet").toggleClass("hidden inactive");         
      }); //dietBtn 클릭 이벤트 끝
      
      $('#marketBtn').click(function (){
         $(".market").toggleClass("hidden inactive");         
      }); //marketBtn 클릭 이벤트 끝
      
      $('#dietTitle').click(function(){
    	 location.href="<c:url value="/dietBoard/dietList"/>"; 
      });
      $('#marketTitle').click(function(){
    	  location.href="<c:url value="/marketBoard/market_board"/>"; 
      });
      $('#courseTitle').click(function(){
    	  location.href="<c:url value="/courseBoard/"/>"+"?category="; 
      })
      $('#freeTitle').click(function(){
    	  location.href="<c:url value="/freeBoard/"/>";
      })
      $('#noticeTitle').click(function(){
    	  location.href="<c:url value="/noticeBoard/"/>";
      })
   }); //end jQuery
   
   
</script>
</html>