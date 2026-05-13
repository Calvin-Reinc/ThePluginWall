/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import za.ac.the.plugin.wall.model.entity.ArtistProfile;
import za.ac.the.plugin.wall.model.entity.Post;
import za.ac.the.plugin.wall.model.entity.bl.ArtistProfileFacadeLocal;
import za.ac.the.plugin.wall.model.entity.bl.PostFacadeLocal;

/**
 *
 * @author VUKONA
 */
public class DeletePostServlet extends HttpServlet {


    @EJB
    private PostFacadeLocal pfl;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String postIdStr = request.getParameter("postId");
        HttpSession session = request.getSession();

        if (postIdStr != null && session != null) {
            try {
                // 1. Identify the user and the post
                ArtistProfile artist = (ArtistProfile) session.getAttribute("userA");
                Long postId = Long.parseLong(postIdStr);
                Post post = pfl.find(postId);
                
                if (post != null && artist != null) {
                    // 2. Remove from database and force a sync
                    pfl.remove(post);
                    pfl.flush(); // Forces the DB to update immediately 

                    // 3. REFRESH SESSION DATA
                    // Fetch fresh list from DB using the artist's ID 
                    List<Post> updatedPosts = pfl.findByArtist(artist.getId());
                    
                    // Recalculate stats for the dashboard display 
                    int updatedLikes = (int)session.getAttribute("totalLikes");
                    int updatedComments = (int)session.getAttribute("totalComments");
;
                    for (Post p : updatedPosts) {
                        updatedLikes -= p.getLikes();
                        updatedComments -= p.getComments().size();
                    }

                    // 4. Overwrite the stale session attributes [cite: 52, 65]
                    session.setAttribute("posts", updatedPosts);
                    session.setAttribute("totalLikes", updatedLikes);
                    session.setAttribute("totalComments", updatedComments);
                    
                    // 5. Redirect back to the Dashboard Servlet to ensure full sync
                    response.sendRedirect("ArtistDashServlet.do?status=deleted");
                    return;
                }
            } catch (Exception e) {
                // If something fails, redirect with an error message
                response.sendRedirect("ArtistDashServlet.do?error=delete_failed");
                return;
            }
        }
        // Fallback safety redirect
        response.sendRedirect("artist_dashboard.jsp");
    }

}
