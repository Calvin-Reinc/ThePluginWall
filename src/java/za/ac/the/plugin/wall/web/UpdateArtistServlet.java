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
import za.ac.the.plugin.wall.model.entity.bl.ArtistProfileFacadeLocal;
import za.ac.the.plugin.wall.model.entity.bl.UserFacadeLocal;

/**
 *
 * @author VUKONA
 */
public class UpdateArtistServlet extends HttpServlet {

    
    @EJB
    UserFacadeLocal ufl;
    @EJB
    ArtistProfileFacadeLocal afl;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        ArtistProfile artist = (ArtistProfile) session.getAttribute("userA");

        if (user != null && artist != null) {
            try {
                // 2. Update User details (from your initial naming: fname, lname, username, location)
                user.setFirstName(request.getParameter("fname"));
                user.setLastName(request.getParameter("lname"));
                user.setUsername(request.getParameter("username"));
                user.setLocation(request.getParameter("location"));

                // 3. Update Artist Profile details
                artist.setSpotifyUrl(request.getParameter("spotify"));
                artist.setSoundCloudUrl(request.getParameter("soundcloud"));
                artist.setYoutubeUrl(request.getParameter("youtube"));
                artist.setBio(request.getParameter("bio"));

                // 4. Call the Facades to update the database (Derby)
                ufl.edit(user);
                afl.edit(artist);

                // 5. Update the session with the refreshed objects
                session.setAttribute("user", user);
                session.setAttribute("userA", artist);

                // 6. Success redirect back to the dashboard
                response.sendRedirect("artist_dashboard.jsp?status=updated");
                
            } catch (Exception e) {
                // If something fails (e.g. database constraint), send an error
                response.sendRedirect("edit_profile.jsp?error=database");
            }
        } else {
            // If session expired
            response.sendRedirect("sign_in.jsp");
        }
    }


}
