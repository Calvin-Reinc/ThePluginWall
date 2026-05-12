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
            HttpSession hs = request.getSession(true);
            
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
            String type = request.getParameter("type");

            // 2. Data Conversion: HTML date input comes as "yyyy-MM-dd"
            Date dob = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);

            // 3. Populate the Entity (The Object)
            String path;
            
            User newUser = new User();
            newUser.setFirstName(firstName);
            newUser.setLastName(lastName);
            newUser.setUsername(artistName);
            newUser.setEmail(email);
            newUser.setDateOfBirth(dob);
            newUser.setId(idNumber);
            newUser.setLocation(location);
            
            ufl.create(newUser);            
            if(type.equals("artist"))
            {
                ArtistProfile art = new ArtistProfile();
                art.setUser(newUser);
                
                afl.create(art);
                
                path = "welcome.jsp";
                hs.setAttribute("user", newUser);
                hs.setAttribute("userA", art);
                
            }else{
                ViewerProfile vp = new ViewerProfile();
                vp.setUser(newUser);
                hs.setAttribute("user", newUser);
                hs.setAttribute("userV", vp);

                vfl.create(vp);
                path = "viewer.jsp";
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher(path);
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
