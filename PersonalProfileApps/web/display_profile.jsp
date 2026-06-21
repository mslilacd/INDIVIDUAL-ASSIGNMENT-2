<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.profile.model.ProfileItem" %>
<!DOCTYPE html>
<html>
<head>
    <title>PersonalProfileApps - Profile Details</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #ffe6ee; color: #333; margin: 0; padding: 20px; }
        .profile-card { max-width: 650px; margin: 50px auto; background: #ffffff; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); overflow: hidden; }
        .profile-header { background: #ffffff; color: #2c3e50; padding: 30px; text-align: center; border-bottom: 2px solid #fb9ebb; }
        .profile-header h1 { margin: 0 0 10px 0; font-size: 28px; color: #2c3e50; }
        .profile-header p { margin: 0; font-size: 16px; color: #34495e; opacity: 0.85; }
        .profile-body { padding: 35px; }
        .info-row { display: flex; margin-bottom: 20px; border-bottom: 1px dashed #fb9ebb; padding-bottom: 12px; }
        .info-label { width: 30%; font-weight: bold; color: #34495e; }
        .info-value { width: 70%; color: #2c3e50; }
        .intro-box { background-color: #fff0f3; border-left: 4px solid #fb9ebb; padding: 15px; border-radius: 4px; font-style: italic; color: #2c3e50; white-space: pre-wrap; }
        .action-links { display: flex; gap: 15px; margin-top: 30px; }
        .action-links a { flex: 1; text-align: center; background-color: #fb9ebb; color: white; padding: 12px 20px; border-radius: 4px; text-decoration: none; font-weight: bold; box-sizing: border-box; transition: all 0.2s ease; }
        .action-links a:hover { background: linear-gradient(135deg, #34495e, #2c3e50); }
        .action-links a.secondary-btn { background-color: #34495e; }
        .action-links a.secondary-btn:hover { background: #ff4d6d; }
    </style>
</head>
<body>

<%
    ProfileItem profile = (ProfileItem) request.getAttribute("userProfile");
    if (profile == null) {
        response.sendRedirect("index.html");
        return;
    }
%>

<div class="profile-card">
    <div class="profile-header">
        <h1><%= profile.getName() %></h1>
        <p><%= profile.getProgramme() %> — Student Information Card</p>
    </div>
    
    <div class="profile-body">
        <div class="info-row">
            <div class="info-label">Student ID:</div>
            <div class="info-value"><%= profile.getStudentID() %></div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Email Address:</div>
            <div class="info-value"><%= profile.getEmail() %></div>
        </div>
        
        <div class="info-row">
            <div class="info-label">Hobbies:</div>
            <div class="info-value"><%= profile.getHobbies() %></div>
        </div>
        
        <div class="info-row" style="display: block;">
            <div class="info-label" style="width: 100%; margin-bottom: 8px;">Self-Introduction:</div>
            <div class="info-value" style="width: 100%;">
                <div class="intro-box"><%= profile.getIntroduction() %></div>
            </div>
        </div>
        
        <div class="action-links">
            <a href="index.html">← Register New</a>
            <a href="viewProfiles.jsp" class="secondary-btn">View Database List 📑</a>
        </div>
    </div>
</div>

</body>
</html>