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
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import za.ac.the.plugin.wall.model.entity.ArtistProfile;
import za.ac.the.plugin.wall.model.entity.User;
import za.ac.the.plugin.wall.model.entity.ViewerProfile;
import za.ac.the.plugin.wall.model.entity.bl.ArtistProfileFacadeLocal;
import za.ac.the.plugin.wall.model.entity.bl.UserFacadeLocal;
import za.ac.the.plugin.wall.model.entity.bl.ViewerProfileFacadeLocal;

/**
 *
 * @author VUKONA
 */
public class UserServlet extends HttpServlet {

    @EJB
    UserFacadeLocal ufl;
    @EJB
    ArtistProfileFacadeLocal afl;
    @EJB
    ViewerProfileFacadeLocal vfl;
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        try {
        // 1. Capture data from the form
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String dobStr = request.getParameter("dob");
        String idNumberStr = request.getParameter("id"); // Captured as String first
        String location = request.getParameter("location");
        String type = request.getParameter("type");
        String pass = request.getParameter("password");
        
        // 2. Data Conversion
        Date dob = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);
        Long idNumber = Long.parseLong(idNumberStr); // Convert to Long for your entity

        // 3. Populate the User Entity
        User newUser = new User();
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(pass); 
        newUser.setDateOfBirth(dob);
        newUser.setLocation(location);
        newUser.setRole(type);
        newUser.setCreation_date(new Date());
        
        // FIX: Setting the ID Number so the database doesn't see NULL
        // Note: Ensure your User.java has a method named 'setIdNumber' or similar
        newUser.setId(idNumber); 
        
        // 4. Persist Core User
        ufl.create(newUser); 
        
        String path;
        if(type.equalsIgnoreCase("Artist")) {
            ArtistProfile art = new ArtistProfile();
            art.setUser(newUser);
            
            // If you added 'genre' to the entity earlier, set it here:
            // String genre = request.getParameter("genre");
            // art.setBio(genre); // Or art.setGenre(genre) if updated
            
            afl.create(art);
            
            
        } else {
            ViewerProfile vp = new ViewerProfile();
            vp.setUser(newUser);
            
            vfl.create(vp);
            
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("sign_in.jsp");
        dispatcher.forward(request, response);

    } catch (Exception e) {
        e.printStackTrace(); 
        request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
        RequestDispatcher errorDispatcher = request.getRequestDispatcher("issue.jsp");
        errorDispatcher.forward(request, response);
    }
    }
}
