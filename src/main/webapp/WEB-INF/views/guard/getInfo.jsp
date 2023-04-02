<%--<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>--%>
<%--<%@ page import="java.sql.*" %>--%>
<%--<%@ page import="java.util.ArrayList" %>--%>
<%--<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>--%>
<%--<%--%>
<%--  // 1. JDBC 드라이버 로딩--%>
<%--  Class.forName("com.mysql.cj.jdbc.Driver");--%>

<%--  Connection conn = null;--%>
<%--  Statement stmt = null;--%>
<%--  ResultSet rs = null;--%>

<%--  ArrayList serialNumList = new ArrayList();--%>
<%--  ArrayList latitudeList = new ArrayList();--%>
<%--  ArrayList longitudeList = new ArrayList();--%>
<%--  ArrayList txTimeList = new ArrayList();--%>
<%--  try {--%>
<%--    String jdbcDriver = "jdbc:mysql://localhost:3306/insight?" +--%>
<%--            "useUnicode=true&characterEncoding=euckr";--%>
<%--    String dbUser = "test";--%>
<%--    String dbPass = "1234";--%>

<%--    String query = "SELECT serial_num, h_lat, h_long, substring(tx_time, 1) as tx_time FROM history ORDER BY tx_time desc limit 30";--%>

<%--    // 2. 데이터베이스 커넥션 생성--%>
<%--    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);--%>

<%--    // 3. Statement 생성--%>
<%--    stmt = conn.createStatement();--%>

<%--    // 4. 쿼리 실행--%>
<%--    rs = stmt.executeQuery(query);--%>

<%--    // 5. 쿼리 실행 결과 출력--%>
<%--    while(rs.next()) {--%>
<%--      serialNumList.add(rs.getString("serial_num"));--%>
<%--      latitudeList.add(rs.getString("h_lat"));--%>
<%--      longitudeList.add(rs.getString("h_long"));--%>
<%--      txTimeList.add(rs.getString("tx_time"));--%>
<%--    }--%>
<%--    ObjectMapper objectMapper1 = new ObjectMapper();--%>
<%--    String serialNum = objectMapper1.writeValueAsString(serialNumList);--%>
<%--    ObjectMapper objectMapper2 = new ObjectMapper();--%>
<%--    String latitude = objectMapper2.writeValueAsString(latitudeList);--%>
<%--    ObjectMapper objectMapper3 = new ObjectMapper();--%>
<%--    String longitude = objectMapper3.writeValueAsString(longitudeList);--%>
<%--    ObjectMapper objectMapper4 = new ObjectMapper();--%>
<%--    String txTime = objectMapper4.writeValueAsString(txTimeList);--%>

<%--%>--%>