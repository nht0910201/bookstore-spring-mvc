package com.hcmute.cinema.filters;

import com.hcmute.cinema.models.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter",
        value = {"/account/profile/*", "/admin/*"})
public class AuthFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        boolean auth = (boolean) session.getAttribute("auth");
        User authUser = (User) session.getAttribute("authUser");
        int role = (int) session.getAttribute("role");

        if (!auth) {
            res.sendRedirect("/auth/login");
            return;
        }

//        if (req.getRequestURI().equals("/Admin/Manage")) {
//            if (role == 2) {
//                res.sendRedirect("/Home");
//                return;
//            }
//        }

        chain.doFilter(request, response);
    }
}
