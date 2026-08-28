package packages;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class loginservlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uemail = request.getParameter("username");
        String upwd   = request.getParameter("password");
        String role   = request.getParameter("role");

        HttpSession session = request.getSession();

        if (uemail == null || uemail.trim().isEmpty()) {
            request.setAttribute("status", "invalidEmail");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (upwd == null || upwd.trim().isEmpty()) {
            request.setAttribute("status", "invalidPassword");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (role == null || role.trim().isEmpty()) {
            request.setAttribute("status", "invalidRole");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/eng", "root", "madhu");

            PreparedStatement pst = con.prepareStatement(
                "SELECT * FROM users4 WHERE uemail=? AND upwd=? AND role=? AND status='active'"
            );

            pst.setString(1, uemail.trim());
            pst.setString(2, upwd.trim());
            pst.setString(3, role.trim());

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                session.setAttribute("user_id", rs.getInt("id"));   // VERY IMPORTANT
                session.setAttribute("name", rs.getString("uname"));
                session.setAttribute("role", rs.getString("role"));

                if ("student".equals(role)) {
                    response.sendRedirect(request.getContextPath()+"/student/dashboard.jsp");
                }
                else if ("faculty".equals(role)) {
                    response.sendRedirect(request.getContextPath()+"/faculty/dashboard.jsp");
                }
                else if ("admin".equals(role)) {
                    response.sendRedirect(request.getContextPath()+"/admin/dashboard.jsp");
                }
                return;
            }

            else {

                request.setAttribute("status", "failed");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
