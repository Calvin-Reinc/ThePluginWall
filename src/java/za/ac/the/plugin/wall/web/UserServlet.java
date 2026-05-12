/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.web;


import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author VUKONA
 */
public class UserServlet extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Capture data from the form using your specific 'name' attributes
            String firstName = request.getParameter("fname");
            String lastName = request.getParameter("lname");
            String artistName = request.getParameter("username");
            String email = request.getParameter("email");
            String dobStr = request.getParameter("dob");
            Long idNumber = Long.parseLong(request.getParameter("id")); // Fixed the name conflict
            String bio = request.getParameter("bio");
            String location = request.getParameter("location");

            // 2. Data Conversion: HTML date input comes as "yyyy-MM-dd"
            Date dob = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);

            // 3. Populate the Entity (The Object)
            /*
            User newUser = new User();
            newUser.setFirstName(firstName);
            newUser.setLastName(lastName);
            newUser.setUsername(artistName);
            newUser.setEmail(email);
            newUser.setDateOfBirth(dob);
            newUser.setIdNumber(idNumber);
            newUser.setBio(bio);
            newUser.setLocation(location);
            */

            // 4. Industry Step: Attach the object to the request
            // This allows the next page to "see" the artist data
            //request.setAttribute("registeredUser", newUser);

            // 5. Use RequestDispatcher to forward to the welcome page
            RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            // Professional error handling: log the error and tell the user
            e.printStackTrace(); 
            request.setAttribute("errorMessage", "Registration failed. Please check your details.");
            RequestDispatcher errorDispatcher = request.getRequestDispatcher("sign_in.jsp");
            errorDispatcher.forward(request, response);
        }
            
    }



}
