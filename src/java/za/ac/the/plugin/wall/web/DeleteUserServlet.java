/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.web;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import za.ac.the.plugin.wall.model.entity.User;
import za.ac.the.plugin.wall.model.entity.bl.UserFacadeLocal;

/**
 *
 * @author VUKONA
 */
public class DeleteUserServlet extends HttpServlet {


    @EJB
    UserFacadeLocal ufl;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Get the current session
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. Identify the user to be deleted
            User user = (User) session.getAttribute("user");

            if (user != null) {
                try {
                    // 3. Database Operation: Remove user from Derby
                    // This will also trigger the removal of ArtistProfile if Cascade is set
                    ufl.remove(user);

                    // 4. Security: Invalidate the session so the user is logged out
                    session.invalidate();

                    // 5. Navigation: Redirect to home page
                    response.sendRedirect("index.jsp?status=account_deleted");
                    return;
                    
                } catch (Exception e) {
                    // Log error and redirect back if it fails
                    response.sendRedirect("edit_profile.jsp?error=delete_failed");
                    return;
                }
            }
        }
        
        // Fallback if no session or user is found
        response.sendRedirect("index.jsp");
    }


}
