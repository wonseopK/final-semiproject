<%@page import="java.sql.Timestamp"%>
<%@page import="data.dao.ReservationDao"%>
<%@page import="data.dto.ReservationDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//한글 앤코딩
request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
String carname = request.getParameter("carname");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");
String postcode = request.getParameter("postcode");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String pw = request.getParameter("pw");
String w1 = request.getParameter("date");
String w2 = request.getParameter("date2");
String w3 = request.getParameter("date3");
String w4 = request.getParameter("time");
String w5 = request.getParameter("time1");
String w6 = request.getParameter("time2");

ReservationDto dto = new ReservationDto();


dto.setName(name);
dto.setCarname(carname);
dto.setAddr1(addr1);
dto.setAddr2(addr2);
dto.setPostcode(postcode);
dto.setPw(pw);
dto.setWriteday(w1 + w2 + w3 + w4 + w5 + ":" + w6);

ReservationDao dao = new ReservationDao();
dao.insertData(dto);

System.out.println(name);
System.out.println(addr1);

String path = "../index.jsp?main=reservation/reservationclear.jsp";
response.sendRedirect(path);
%>