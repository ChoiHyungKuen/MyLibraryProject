<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	#sessionCounter {
		color : "white";
		margin-top :20px;
	}
</style>
<script type="text/javascript">

var nav = 
{
   	findMainMenuFn : function() {
	   navAjaxFn.ajaxCallFn({url: "mainMenuList.do" });
	},
	
	pageSubmitFn : function(param, pageName, page) {
		
		if(pageName.indexOf('#') != -1) {

			location.href = "/sample/"+ pageName;	
		} else {		
			
			if(pageName == 'libroBookContent') {

				$("#bookId").val(param);
			} else if(pageName == 'searchBook') {

				$("#classification").val(param);
			} else if(pageName == 'books') {
				
				$("#order").val(param);
			}

			$("#page").val(page);
			
			$("#navFrm").attr("action", pageName+".do");	
			
			$("#navFrm").submit();
		} 
	}, 
	clickNotification : function() {
		<c:choose>
			<c:when test="${ notificationCnt == 0 }">
				alert("확인하실 메시지가 없습니다.");	
			</c:when>
			<c:otherwise>
				 var check = confirm("메시지를 확인하시겠습니까? ");
				 if(check) {
	
					var url = "notificationView.do";
					var opt = "width=650, height=400";
							
					window.open(url, "", opt);	 
				 }
			</c:otherwise>
		</c:choose>
	},
	clickLogin : function(){
			
		var url = "loginView.do";
		var opt = "width=650, height=400";
			
		window.open(url, "", opt);
	},
	clickMyBook : function(memberId){
		
		$("#memberId").val(memberId);

		$("#navFrm").attr("method", "POST");	
		$("#navFrm").attr("action", "myBook.do");	
		$("#navFrm").submit();
	}, 
	clickMyProfile : function(){
		
		<c:choose>
			<c:when test="${ loginVO !=null }" >
				var url = "myProfile.do";
				var opt = "width=700, height=600";
					
				window.open(url+"?memberId="+"<c:out value='${ loginVO.id }'/>", "", opt);
			</c:when>
			<c:otherwise>
				alert("자동 로그아웃 되셨습니다. 다시 로그인해주세요.");
			</c:otherwise>
		</c:choose>

	}, 
	clickRegisterMember : function() {
			
		var url = "termsOfRegisterView.do";
		var opt = "width=900, height=800";
			
		window.open(url, "", opt);	
	},
	clickFindMemberInfo : function() {

		var url = "findMemberInfo.do";
		var opt = "width=850, height=500";
			
		window.open(url, "", opt);	
	}
}

var navAjaxFn = 
{
	ajaxCallFn : function(options) {
	     var that = this;	// 이 객체를 나중에 ajax 성공시에도 사용하기 위해 전역 변수로 지정 
		      
	     var settings = {
		         
		         url : "mainMenuList.do"
		      }
		      
		      settings = $.extend({}, settings, options);
		   
		      $.ajax({
		         
		           type          : "POST",
		           url           : settings.url,
		           async         : false,
		           beforeSend    : function(xhr) {           
		         
		           },
		           success    : function(result) {
		              
		            var jsonRes = JSON.parse(result);
		            $.each(jsonRes, function (i, item) {

                        var strMenu = "";
                        var anchorUrl =""; 
                        
		            	if(item.innerLinkYn == 'Y') {
		            		anchorUrl = item.menuUrl;
		            	} else {
		            		anchorUrl = "#";
		            	}
                        
							
		               	strMenu += '<li class="' +item.menuClass+ '" name="'+ item.menuNm  +'">'
										+ '<a href="'+ anchorUrl +'" onclick="javascript:nav.pageSubmitFn(\'\', \'' + item.menuUrl + '\',\'1\')">'
            								+ item.menuNm 
        								+ '</a>'
		                           	+ '</li>';
		                            
		                         $("#mainmenu ul").append(strMenu);
		            });
		           },
		           error      : function() {
		              
		              alert("main menu 조회시 Error 발생");
		           }
		       }); 
		   }
}

$(document).ready(function(){

	nav.findMainMenuFn();
	var pageName = "<c:out value="${param.pageName}" />";
	
	if(pageName == 'books') {
		$("body").attr("data-spy", "spyscroll");
		$("body").attr("data-target", ".navbar-default");
		$("#mainmenu ul li.active").removeClass("active");
		$("#mainmenu ul li:last-child").addClass("active");
	} else {
		$("body").attr("data-spy", "scroll");
		$("body").attr("data-target", "#mainmenu");
	}
	

});
</script>

<form id="navFrm" name="navFrm">
	<input type="hidden" id="order"  name="order" />
	<input type="hidden" id="pageName"  name="pageName" />
	<input type="hidden" id="bookId"  name="bookId" />
	<input type="hidden" id="classification"  name="classification" />
	<input type="hidden" id="memberId"  name="memberId" />	
	<input type="hidden" id="page"  name="page" />
</form>
    
    <nav class="relative" id="sc1">
        <!-- Header-background-markup -->
        <div class="header-bg relative home-slide">
            <div class="item">
                <img src="images/slide/library1.jpg" alt="library">
            </div>
            <div class="item">
                <img src="images/slide/library2.jpg" alt="library">
            </div>
            <div class="item">
                <img src="images/slide/library3.jpg" alt="library">
            </div>
            <div class="item">
                <img src="images/slide/library4.jpg" alt="library">
            </div>
        </div>
        <!-- Mainmenu-markup-start -->
        <div class="mainmenu-area navbar-fixed-top" data-spy="affix" data-offset-top="10">
            <nav class="navbar">
                <div class="container">
                    <div class="navbar-header">
                        <div class="space-10"></div>
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainmenu">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <!--Logo-->
                        <a href="#sc1" class="navbar-left show" onclick="javascript:nav.pageSubmitFn('','main',1)"><img src="images/logo.png" alt="library"></a>
                        <div class="space-10"></div>
                    </div>
                    <!--Toggle-button-->

                    <!--Active User-->
                    <div class="nav navbar-right">
                    	<c:if test="${ loginVO !=null }"> 
                        <a href="#" onclick="javascript:nav.clickNotification()"><img src="images/notification.png" class="badge-notification"  alt="library" /></a>
                        <span class="badge"><c:out value="${ notificationCnt }"/></span>
                        </c:if>
                        <div class="active-user navbar-left active">
                            <ul class="list-unstyled">
                                <li>
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    
                                        <img src="images/studying.png" class="img-circle img-thumbnail" alt="library" />
                                    </a> 	
                                    <ul class="dropdown-menu">
                                  		<c:if test="${loginVO != null}">
                                        <li>
                                            <a href="#" onclick="javascript:nav.clickMyProfile()"> <span><i class="icofont icofont-user"></i></span> 나의 정보</a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="javascript:nav.clickMyBook('<c:out value="${loginVO.id}"/>')"> <span><i class="icofont icofont-read-book"></i></span> 내 서재</a>
                                        </li>
                                  		<li>
											<a><span><i class="icofont icofont-ui-rating"></i></span> ${loginVO.name}님 환영합니다. </a> 
										</li>
										<li>
											<a href="#" onclick="javascript:nav.pageSubmitFn('', 'logout','1')"> <span><i class="icofont icofont-logout"></i></span> 로그아웃</a>
										</li>
										</c:if>
										<c:if test="${loginVO == null }">
											<li>
												<a href="#" onclick="javascript:nav.clickRegisterMember()"><span><i class="icofont icofont-read-book-alt"></i></span> 회원가입</a>
											</li>
											<li>
												<a href="#" onclick="javascript:nav.clickFindMemberInfo()"><span><i class="icofont icofont-key"></i></span> ID/PW 찾기</a>
											</li>
											<li>
												<a href="#" onclick="javascript:nav.clickLogin()"><span><i class="icofont icofont-login"></i></span> 로그인</a>
											</li>
										</c:if>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!--Mainmenu list-->
                    <div class="navbar-right in fade" id="mainmenu">
                        <ul class="nav navbar-nav nav-white text-uppercase">
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        <div class="space-100"></div>