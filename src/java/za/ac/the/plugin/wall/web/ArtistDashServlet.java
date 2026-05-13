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
import za.ac.the.plugin.wall.model.entity.User;
import za.ac.the.plugin.wall.model.entity.bl.ArtistProfileFacadeLocal;
import za.ac.the.plugin.wall.model.entity.bl.PostFacadeLocal;

/**
 *
 * @author khali
 */
public class ArtistDashServlet extends HttpServlet {

    @EJB
    private PostFacadeLocal pf;
    @EJB
    private ArtistProfileFacadeLocal af;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        // 1. Get the USER object (the account)
        User user = (User) session.getAttribute("user"); 

        if (user != null) {
            // 2. Use a custom query to find the profile linked to this User ID
            // We search the ArtistProfile table for the one linked to this user
            ArtistProfile artistProfile = af.findByUserId(user.getId());

            if (artistProfile != null) {
                // 3. Get the posts and force the LAZY load
                List<Post> artistPosts = artistProfile.getPosts();
                if (artistPosts != null) {
                    artistPosts.size(); 
                }

                // 4. Calculate stats from the artist's list
                int totalLikes = 0;
                int totalComments = 0;
                for(Post p : artistPosts) {
                    totalLikes += p.getLikes();
                // Null check for comments to prevent crashing
                    if(p.getComments() != null) {
                        totalComments += p.getComments().size();
                    }
                }

                request.setAttribute("posts", artistPosts);
                request.setAttribute("totalLikes", totalLikes);
                request.setAttribute("totalComments", totalComments);

                request.getRequestDispatcher("artist_dashboard.jsp").forward(request, response);
            } else {
                response.sendRedirect("issue.jsp");
            }
        }
    }


    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
