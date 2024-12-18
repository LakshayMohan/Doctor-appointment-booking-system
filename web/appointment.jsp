<%-- 
    Document   : appointment
    Created on : 09-Nov-2024, 11:37:19 pm
    Author     : mayankmer
--%>

<%@page import="java.util.List"%>
<%@page import="pojoPackage.Doctor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Book an Appointment</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <header>
        <h1>Book an Appointment</h1>
    </header>

    <div class="appointment-form">
        <form action="GetAvailableDoctors" method="POST">
            <!-- Specialty Dropdown -->
            <label for="specialty">Choose Specialty:</label>
            <select id="specialty" name="specialty">
                <option value="">--Select Specialty--</option>
                <option value="physician">Physician</option>
                <option value="cardiologist">Cardiologist</option>
                <option value="dermatologist">Dermatologist</option>
                <!-- Add more specialties as needed -->
            </select>

            <!-- Date Picker -->
            Choose Date:<input type="date" id="appointmentDate" name="appointmentDate">

            <!-- Submit Button -->
            <button type="submit">Show Available Doctors</button>
        </form>
    </div>

    <!-- Available Doctors Table -->
    <h2>Available Doctors:</h2>
    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Specialty</th>
                <th>Experience</th>
                <th>Book</th>
            </tr>
        </thead>
        <tbody>
            <!-- Table rows will be populated by servlet -->
            <% 
                List<Doctor> availableDoctors = (List<Doctor>) request.getAttribute("availableDoctors");
                if (availableDoctors != null && !availableDoctors.isEmpty()) {
                    for (Doctor doctor : availableDoctors) { 
            %>
                        <tr>
                            <td><%= doctor.getName() %></td>
                            <td><%= doctor.getSpecialty() %></td>
                            <td><%= doctor.getYoe()%> years</td>
                            <td>
                                <!-- Book Button -->
                                <form action="Appointment" method="POST" style="display:inline;">
                                    <input type="hidden" name="licenseNumber" value="<%= doctor.getLnNum()%>">
                                    <button type="submit">Book</button>
                                </form>
                            </td>
                        </tr>
            <% 
                    } 
                } else { 
            %>
                    <tr>
                        <td colspan="6">No doctors available for the selected specialty and date.</td>
                    </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>


