<%-- 
    Document   : doctorView
    Created on : 10-Nov-2024, 1:01:33 am
    Author     : mayankmer
--%>

<%@ page import="appointmentDAO.AppointmentBookingDAO" %>
<%@ page import="pojoPackage.Patient" %>
<%@ page import="pojoPackage.Appointment" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>

<%
    // Retrieve the appointment data
    String query = "SELECT * FROM appointments";
    Connection con = AppointmentBookingDAO.getConnection();
    ArrayList<Appointment> appointments = new ArrayList<>();
    
    if (con != null) {
        try (PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Appointment e = new Appointment();
                // Populate your Appointment object from ResultSet
                e.setStatus(rs.getInt("status"));
                e.setPatient_name(rs.getString("patient_name"));
                e.setDate(rs.getString("date"));
                e.setSlot_number(rs.getInt("slot_number"));
                appointments.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } else {
        out.println("Database connection failed. Please try again later.");
    }
    // Set appointments as a request attribute
    request.setAttribute("appointments", appointments);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2, h3 {
            color: #333;
        }
        .profile-info {
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .profile-info h2, .profile-info p {
            margin: 0;
            padding: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #4CAF50;
            color: white;
            text-align: center;
        }
        td {
            text-align: center;
        }
        button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
        }
        button:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3>Your Appointments</h3>
        <table>
            <thead>
                <tr>
                    <th>Sr. No.</th>
                    <th>Patient Name</th>
                    <th>Appointment Date</th>
                    <th>Token Number</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    request.getAttribute("appointments");
                    int srNo = 1;
                    for (Appointment appointment : appointments) {
                        if (appointment.getStatus() == 1) {
                %>
                    <tr>
                        <td><%= srNo++ %></td>
                        <td><%= appointment.getPatient_name() %></td>
                        <td><%= appointment.getDate() %></td>
                        <td><%= appointment.getSlot_number() %></td>
                        <td>
                            <form action="EndAppointment" method="post" style="display:inline;">
                                <input type="hidden" name="tokenNumber" value="<%= appointment.getSlot_number() %>"/>
                                <button type="submit">End Appointment</button>
                            </form>
                        </td>
                    </tr>
                <% 
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>

