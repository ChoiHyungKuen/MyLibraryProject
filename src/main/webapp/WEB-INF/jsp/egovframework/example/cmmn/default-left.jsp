<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var left = 
{
	pageSubmitFn : function(pageName) {
		
		$("#pageName").val(pageName);

		if(pageName == "mainMenu") {
			
			$("#frm").attr("action", "main.do");	
		} else if(pageName == "logout") {
			
			$("#frm").attr("action", "logout.do");	
		}
		
		$("#frm").submit();
	}
}

$(document).ready(function(){	

});
</script>

<form id="frm" name="frm">
	
</form>

	<div class="sidebar" data-color="orange" data-image="images/bootstrap/full-screen-image-3.jpg">
        <!--
            Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
            Tip 2: you can also add an image using data-image tag
        -->
        <div class="logo">
            <a href="http://www.creative-tim.com" class="logo-text">
                HANQ TEAM
            </a>
        </div>
		<div class="logo logo-mini">
			<a href="http://www.creative-tim.com" class="logo-text">
				Ct
			</a>
		</div>

    	<div class="sidebar-wrapper">

            <div class="user">
                <div class="photo">
                    <img src="images/bootstrap/default-avatar.PNG" />
                </div>
                <div class="info">
                    <a data-toggle="collapse" href="#collapseExample" class="collapsed">
                        HANQ
                        <b class="caret"></b>
                    </a>
                    <div class="collapse" id="collapseExample">
                        <ul class="nav">
                            <li><a href="#">My Profile</a></li>
                            <li><a href="#">Edit Profile</a></li>
                            <li><a href="#">Settings</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <ul class="nav">
                <li prop="menu" class="active" id="mainMenu">
                    <a href="#" onclick="javascript:left.pageSubmitFn('mainMenu')">
                        <i class="pe-7s-graph"></i>
                        <p>HOME</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>