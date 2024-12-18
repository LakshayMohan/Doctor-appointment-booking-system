/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EndAppointmentServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the tokenNumber from the request
        int tokenNumber = Integer.parseInt(request.getParameter("tokenNumber"));
        
        // Database connection details (replace with your actual DB details)
        String jdbcURL = "jdbc:mysql://localhost:3306/hackathon";
        String jdbcUsername = "root";
        String jdbcPassword = "DBpassword";
        
        // SQL query to delete the appointment
        String deleteSQL = "DELETE FROM appointments WHERE token_number = ?";

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(deleteSQL)) {
            
            // Set the token number in the prepared statement
            preparedStatement.setInt(1, tokenNumber);
            
            // Execute the delete query
            int rowsAffected = preparedStatement.executeUpdate();
            
            // Check if the appointment was deleted
            if (rowsAffected > 0) {
                // Redirect to the doctorView.jsp page after successful deletion
                response.sendRedirect("doctorView.jsp");
            } else {
                // If no appointment is found for the given tokenNumber
                response.getWriter().println("Error: Appointment not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting appointment: " + e.getMessage());
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Servlet to delete an appointment based on token number";
    }
}
