package com.hbsd.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: Hanfei
 * @Date: 2017/4/7
 * @Company:http://www.hbsddz.com
 * @Project:daily
 * @Class:${NAME}
 */
public class NoLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/noLoginHbsd.do").forward(request,response);
    }
}
