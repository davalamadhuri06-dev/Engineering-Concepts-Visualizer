<%@ page import="java.sql.*"%>
<%
Integer sid=(Integer)session.getAttribute("user_id");
if(sid==null)return;

int cid=Integer.parseInt(request.getParameter("cid"));

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/eng","root","madhu");

PreparedStatement chk=con.prepareStatement(
"SELECT id FROM student_progress WHERE student_id=? AND concept_id=?");

chk.setInt(1,sid);
chk.setInt(2,cid);

ResultSet rs=chk.executeQuery();

if(rs.next()){
 PreparedStatement up=con.prepareStatement(
 "UPDATE student_progress SET last_opened=NOW() WHERE id=?");
 up.setInt(1,rs.getInt(1));
 up.executeUpdate();
}else{
 PreparedStatement ins=con.prepareStatement(
 "INSERT INTO student_progress(student_id,concept_id) VALUES(?,?)");
 ins.setInt(1,sid);
 ins.setInt(2,cid);
 ins.executeUpdate();
}
%>

