package packages;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uname   = request.getParameter("name");
        String uemail  = request.getParameter("email");
        String upwd    = request.getParameter("pass");
        String reupwd  = request.getParameter("re_pass");
        String umobile = request.getParameter("contact");
        String role    = request.getParameter("role");

        if (uname == null || uname.trim().isEmpty()) {
            request.setAttribute("status", "invalidName");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        if (uemail == null || uemail.trim().isEmpty()) {
            request.setAttribute("status", "invalidEmail");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        if (upwd == null || upwd.trim().isEmpty()) {
            request.setAttribute("status", "invalidPassword");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        if (!upwd.equals(reupwd)) {
            request.setAttribute("status", "invalidConfirmPassword");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        if (umobile == null || umobile.trim().isEmpty()) {
            request.setAttribute("status", "invalidMobile");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        if (umobile.length() != 10) {
            request.setAttribute("status", "invalidMobileLength");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        if (role == null || role.trim().isEmpty()) {
            request.setAttribute("status", "invalidRole");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/eng", "root", "madhu");

            PreparedStatement pst = con.prepareStatement(
                "insert into users4(uname,upwd,uemail,umobile,role) values(?,?,?,?,?)"
            );

            pst.setString(1, uname);
            pst.setString(2, upwd);
            pst.setString(3, uemail);
            pst.setString(4, umobile);
            pst.setString(5, role);

            int rowcount = pst.executeUpdate();

            if (rowcount > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }

            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}