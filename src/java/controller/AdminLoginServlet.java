package controller;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class AdminLoginServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hackathon";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "DBpassword";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isAuthenticated = authenticateAdmin(username, password);
        
        if (isAuthenticated) {
            response.sendRedirect("adminView.jsp");
        } else {
            response.getWriter().println("<script>alert('Invalid credentials'); window.location.href = 'adminLogin.html';</script>");
        }
    }

    private boolean authenticateAdmin(String username, String password) {
        boolean isValid = false;
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ? AND role = 'admin'";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, username);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    isValid = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isValid;
    }
}
