# INDIVIDUAL-ASSIGNMENT-2
CSC584 
AIZATUL SHARMILAH BINTI JAMALUDIN
2024699982

Short Briefing :
The user enters student data (Student ID , name, program code, email, hobbies and introduction of themselves) into a form. While the controller captures the data, bundles it into a JavaBean, loads the database network and executes a direct SQL statement to store it inside a database. After the forms is succesfully submitted, There is an interface that displays the details immediately after the registration. Furthermore, all the records were recorded in a database using select statement and prints them into an interactive html table, where the admin can review the data and delete it. 

List Implemented System ;
1. index.html : front registration form
2. ProfileServlet.java : Backend controller that catche data using direct SQL line
3. ProfileItem.java: JavaBean object used to temporarily hold and carry data between files
4. display_profile.jsp: Page that showing a success card for registered student.
5. viewProfiles.jsp : Dashboard that pulls all profiles from the database into a table and handles deletions.
6. StudentProfilesDB : Physical database that hold profile table data.
