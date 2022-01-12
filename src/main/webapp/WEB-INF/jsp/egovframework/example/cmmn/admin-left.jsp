<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">

var adminLeftFn = 
{
	pageSubmitFn : function(pageName) {

		$("#adminLeftFrm").attr("action", pageName+".do");	
		
		$("#adminLeftFrm").submit();
	}
}

$(document).ready(function() {

});
</script>

<form id="adminLeftFrm" name="adminLeftFrm">
	
</form>    
<!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu">                
                  <li class="active">
                      <a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('admin-main')">
                          <i class="icon_house_alt"></i>
                          <span>Dashboard</span>
                      </a>
                  </li>
                  <li><a href="#" class="" onclick="javascript:adminLeftFn.pageSubmitFn('manageMenu')">
                          <i class="fa fa-bars"></i>
                          <span>메뉴 관리</span>
                      </a>
                  </li>
				  <li class="sub-menu">
                      <a href="javascript:;" class="">
                          <i class="fa fa-book"></i>
                          <span>도서 관리</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
                      <ul class="sub">
                          <li><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('manageBooks')">도서 관리 테이블</a></li>         
                          <li><a href="#" onclick="javascript:adminLeftFn.pageSubmitFn('addBookInfoMain')">도서 추가</a></li>
                      </ul>
                  </li>       
                  <li><a href="#" class="" onclick="javascript:adminLeftFn.pageSubmitFn('manageInfoBoard')">
                          <i class="fa fa-comments-o"></i>
                          <span>게시판 관리</span>
                      </a>
                  </li>
                  <li>                     
                      <a class="" href="#" onclick="javascript:adminLeftFn.pageSubmitFn('manageCalendar')">
                          <i class="fa fa-calendar"></i>
                          <span>도서관 일정 관리</span>
                      </a>       
                  </li>
                  
                  <li>                     
                      <a class="" href="#" onclick="javascript:adminLeftFn.pageSubmitFn('manageLibroInformation')">
                          <i class="fa fa-bullhorn"></i>
                          <span>도서관 이용안내 관리</span>
                      </a>
                                         
                  </li>
                             <!-- 
                  <li class="sub-menu">
                      <a href="javascript:;" class="">
                          <i class="icon_table"></i>
                          <span>Tables</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
                      <ul class="sub">
                          <li><a class="" href="basic_table.html">Basic Table</a></li>
                      </ul>
                  </li>
                  
                  <li class="sub-menu">
                      <a href="javascript:;" class="">
                          <i class="icon_documents_alt"></i>
                          <span>Pages</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
                      <ul class="sub">                          
                          <li><a class="" href="profile.html">Profile</a></li>
                          <li><a class="" href="login.html"><span>Login Page</span></a></li>
                          <li><a class="" href="blank.html">Blank Page</a></li>
                          <li><a class="" href="404.html">404 Error</a></li>
                      </ul>
                  </li> -->
                  
              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->