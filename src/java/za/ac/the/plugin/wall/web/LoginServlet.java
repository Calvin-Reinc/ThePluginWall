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
public class LoginServlet extends HttpServlet {

    @EJB
    private UserFacadeLocal ufl;
    @EJB
    private ArtistProfileFacadeLocal afl;
    @EJB
    private ViewerProfileFacadeLocal vfl;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Use a custom method in your facade to find the user
        User user = ufl.findByEmail(email); 

        if (user != null && user.getPassword().equals(password)) {
            // SUCCESS: Start the Session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);

            // ROUTE: Based on Role [cite: 33]
            if ("Artist".equals(user.getRole())) {
                ArtistProfile artist = afl.find(user.getId());
                session.setAttribute("userA", artist);
                response.sendRedirect("artist_dashboard.jsp");
            } else {
                ViewerProfile viewer = vfl.find(user.getId());
                session.setAttribute("userV", viewer);
                response.sendRedirect("viewer_feed.jsp");
            }
        } else {
            // FAIL: Back to sign-in with error
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("sign_in.jsp").forward(request, response);
        }
    }

    

}
