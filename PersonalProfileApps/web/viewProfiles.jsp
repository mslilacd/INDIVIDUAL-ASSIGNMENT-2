<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Student Profiles</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #ffe6ee; padding: 40px; }
        .container { max-width: 1100px; margin: auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h2 { color: #2c3e50; text-align: center; margin-bottom: 25px; border-bottom: 2px solid #fb9ebb; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #ffe4e1; }
        th { background-color: #fb9ebb; color: white; font-weight: bold; }
        tr:hover { background-color: #fff5f7; }
        .back-link { display: inline-block; color: #ff4d6d; text-decoration: none; font-weight: bold; margin-bottom: 20px; }
        .back-link:hover { text-decoration: underline; }
        .delete-btn { color: #dc3545; text-decoration: none; font-weight: bold; }
        .delete-btn:hover { text-decoration: underline; }
        .msg { padding: 10px; margin-bottom: 15px; border-radius: 4px; text-align: center; font-weight: bold; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.html" class="back-link">← Back to Registration Form</a>
        <h2>All Registered Student Profiles 📑</h2>

        <%
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            String dbURL = "jdbc:derby://localhost:1527/StudentProfilesDB";
            
            String deleteId = request.getParameter("deleteId");
            if (deleteId != null) {
                Connection delConn = null;
                PreparedStatement delPs = null;
                try {
                    delConn = DriverManager.getConnection(dbURL, "app", "app");
                    delPs = delConn.prepareStatement("DELETE FROM PROFILE WHERE studentID = ?");
                    delPs.setString(1, deleteId);
                    int deleted = delPs.executeUpdate();
                    if (deleted > 0) {
        %>
                        <div class="msg">Profile for Student ID <%= deleteId %> has been deleted successfully. ❌</div>
        <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Delete Error: " + e.getMessage() + "</p>");
                } finally {
                    if (delPs != null) try { delPs.close(); } catch(SQLException ex) {}
                    if (delConn != null) try { delConn.close(); } catch(SQLException ex) {}
                }
            }
        %>
        
        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Programme</th>
                    <th>Email</th>
                    <th>Hobbies</th>
                    <th>Introduction</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    int recordCount = 0;
                    
                    try {
                        conn = DriverManager.getConnection(dbURL, "app", "app");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM PROFILE");
                        
                        while (rs.next()) {
                            recordCount++;
                %>
                <tr>
                    <td><%= rs.getString("studentID") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("programme") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("hobbies") %></td>
                    <td><%= rs.getString("introduction") %></td>
                    <td>
                        <a href="viewProfiles.jsp?deleteId=<%= rs.getString("studentID") %>" 
                           class="delete-btn" 
                           onclick="return confirm('Are you sure you want to delete this profile?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='7' style='color:red;'>Connection Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
                        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
                        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
                    }
                    
                    if (recordCount == 0) {
                %>
                <tr>
                    <td colspan="7" style="text-align: center; color: #999;">No database records found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>