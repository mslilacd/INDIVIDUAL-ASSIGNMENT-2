package com.profile.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.profile.model.ProfileItem;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    //method to get direct connection (error memanjang)
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        String dbURL = "jdbc:derby://localhost:1527/StudentProfilesDB";
        return DriverManager.getConnection(dbURL, "app", "app");
    }

    //method to make sure the table is exists
    private void checkAndCreateTable(Connection conn) {
        String createTableSQL = "CREATE TABLE PROFILE ("
                + "studentID VARCHAR(50) NOT NULL PRIMARY KEY, "
                + "name VARCHAR(100), "
                + "programme VARCHAR(50), "
                + "email VARCHAR(100), "
                + "hobbies VARCHAR(200), "
                + "introduction VARCHAR(1000))";
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(createTableSQL);
        } catch (SQLException e) {
            //error
            if (!"42X05".equals(e.getSQLState())) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        //getting input
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String intro = request.getParameter("intro");
        
        String[] rawHobbies = request.getParameterValues("hobbies");
        String finalHobbies; 

        if (rawHobbies != null && rawHobbies.length > 0) {
            finalHobbies = String.join(", ", rawHobbies);
        } else {
            finalHobbies = "None selected";
        }

        //populate javabean obj
        ProfileItem profile = new ProfileItem();
        profile.setStudentID(studentId);
        profile.setName(name);
        profile.setProgramme(program);
        profile.setEmail(email);
        profile.setHobbies(finalHobbies);
        profile.setIntroduction(intro);
        
        
        boolean isSaved = false;
        String INSERT_SQL = "INSERT INTO PROFILE (studentID, name, programme, email, hobbies, introduction) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = getConnection()) {
            //verfying 
            checkAndCreateTable(connection);
            
            //executing preparedstatement
            try (PreparedStatement ps = connection.prepareStatement(INSERT_SQL)) {
                ps.setString(1, profile.getStudentID());
                ps.setString(2, profile.getName());
                ps.setString(3, profile.getProgramme());
                ps.setString(4, profile.getEmail());
                ps.setString(5, profile.getHobbies());
                ps.setString(6, profile.getIntroduction());
                
                isSaved = ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.out.println("--- Servlet SQL Execution Error ---");
            e.printStackTrace();
        }
        
        //forwarding
        if (isSaved) {
            request.setAttribute("userProfile", profile);
            request.getRequestDispatcher("display_profile.jsp").forward(request, response);
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='font-family:\"Segoe UI\",sans-serif; text-align:center; margin-top:50px; background-color:#ffe6ee; padding:40px;'>");
            response.getWriter().println("<div style='background:white; max-width:500px; margin:auto; padding:30px; border-radius:8px; box-shadow:0 4px 12px rgba(0,0,0,0.1); border-top:6px solid #fb9ebb;'>");
            response.getWriter().println("<h3 style='color:#dc3545;'>❌ Error: Failed to save record directly inside Servlet.</h3>");
            response.getWriter().println("<p>Please verify that your Java DB (Derby) server is turned on and you used a <strong>unique Student ID</strong>.</p>");
            // Prints the stack trace element info to browser page temporarily to help us look at the crash reason if it fails again
            response.getWriter().println("<br><a href='index.html' style='background-color:#fb9ebb; color:white; padding:10px 20px; text-decoration:none; font-weight:bold; border-radius:4px;'>← Go Back to Form</a>");
            response.getWriter().println("</div></div>");
        }
    } 
}