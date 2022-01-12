<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
                <!-- Sidebar-Start -->
                <div class="col-xs-12 col-md-2">
                    <aside>
                        <h3><i class="icofont icofont-filter"></i> Filter By</h3>
                        <div class="space-30"></div>
                        <div class="sigle-sidebar">
                            <h4>카테고리</h4>
                            <hr>
                            <ul class="list-unstyled menu-tip">
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('일반', 'searchBook', 1)">일반</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('철학', 'searchBook', 1)">철학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('종교', 'searchBook', 1)">종교</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('과학', 'searchBook', 1)">과학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('예술', 'searchBook', 1)">예술</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('언어', 'searchBook', 1)">언어</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('문학', 'searchBook', 1)">문학</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('역사', 'searchBook', 1)">역사</a></li>
                            </ul>
                            <a class="btn btn-primary btn-xs" onclick="javascript:nav.pageSubmitFn('','books',1)">See All</a>
                        </div>
                        <div class="space-20"></div>
                        <div class="sigle-sidebar">
                            <h4>다양하게 자료 보기</h4>
                            <hr>
                            <ul class="list-unstyled menu-tip">
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('new','books',1)">신착자료순으로 보기</a></li>
                                <li><a style="cursor:pointer; cursor:hand;" onclick="javascript:nav.pageSubmitFn('best','books',1)">인기대출순으로 보기</a></li>
                            </ul>
                        </div>
                    </aside>
                </div>
                <!-- Sidebar-End -->
            </div>
        </div>
        <div class="space-80"></div>
    </section>    
  
  <footer class="black-bg text-white">
        <div class="space-60"></div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-4">
                    <a href="#sc1"><img src="images/logo.png" alt=""></a>
                    <div class="space-20"></div>
                    <p>포트폴리오용으로 제작한 도서관 사이트입니다.<br>*간단 설명<br>제작기간: 약 2개월<br>제작 인원: 혼자 개발<br>
                    사용 기술 : <br>전자정부프레임워크+ mybatis + 오라클<br>현재 프로젝트는 aws의 리눅스 서버에 업로드 했습니다.
                    </p>
                    <div class="space-10"></div>
                    <ul class="list-inline list-unstyled social-list">
                        <li><a href="#"><i class="icofont icofont-social-facebook"></i></a></li>
                        <li><a href="#"><i class="icofont icofont-social-twitter"></i></a></li>
                        <li><a href="#"><i class="icofont icofont-social-behance"></i></a></li>
                        <li><a href="#"><i class="icofont icofont-brand-linkedin"></i></a></li>
                    </ul>
                    <div class="space-10"></div>
                    <ul class="list-unstyled list-inline tip yellow">
                        <li><i class="icofont icofont-square"></i></li>
                        <li><i class="icofont icofont-square"></i></li>
                        <li><i class="icofont icofont-square"></i></li>
                    </ul>
                </div>
                <div class="col-xs-12 col-sm-4 col-md-3 col-md-offset-1">
                    <h4 class="text-white">Contact Me</h4>
                    <div class="space-20"></div>
                    <table class="table border-none addr-dt">
                        <tr>
                            <td><i class="icofont icofont-social-google-map"></i></td>
                            <td><address>서울시 중랑구</address></td>
                        </tr>
                        <tr>
                            <td><i class="icofont icofont-email"></i></td>
                            <td>gudrms1592@naver.com</td>
                        </tr>
                        <tr>
                            <td><i class="icofont icofont-phone"></i></td>
                            <td>010-2254-1570</td>
                        </tr>
                        <tr>
                            <td><i class="icofont icofont-brainstorming"></i></td>
                            <td>제작자 : 최형근</td>
                        </tr>
                    </table>
                </div>
                <div class="col-xs-12 col-sm-4 col-md-3 col-md-offset-1">
                    <h4 class="text-white">Useful Link(기능없음)</h4>
                    <div class="space-20"></div>
                    <ul class="list-unstyled menu-tip">
                        <li><a href="#">Costumer Service</a></li>
                        <li><a href="#">Help Desk</a></li>
                        <li><a href="#">Forum</a></li>
                        <li><a href="#">Staff Profile</a></li>
                        <li><a href="#">Live Chat</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="space-60"></div>
    </footer>