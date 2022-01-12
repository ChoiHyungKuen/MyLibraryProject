package egovframework.example.manageSession;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SessionTimeoutFilter implements Filter {
public void destroy() {
    // TODO Auto-generated method stub
}
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    HttpServletResponse httpResponse = (HttpServletResponse) response;
    HttpServletRequest httpRequest = (HttpServletRequest)request;
    Integer sessionCount = (Integer) httpRequest.getSession().getServletContext().getAttribute("SESSION_COUNT");//fetching session count from application scope
        if(sessionCount!=null && sessionCount==0 && ! httpRequest.getRequestURL().toString().contains("Error.jsp")){
         //httpRequest.getRequestURL().toString().contains("Error.jsp") - > if it's already redirecting to error.jsp then no redirection 
            httpResponse.sendRedirect("loginView.do");//redirection code
        }
    chain.doFilter(request, response);
}

public void init(FilterConfig fConfig) throws ServletException {
    // TODO Auto-generated method stub
}

}