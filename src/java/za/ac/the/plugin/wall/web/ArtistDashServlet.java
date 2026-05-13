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
        ArtistProfile currentUser = (ArtistProfile) session.getAttribute("userA");

        if (currentUser != null) {
            // 1. REFRESH the object from the database to get the real collection
            // This ensures you get ONLY this artist's posts and the latest counts
            currentUser = af.find(currentUser.getId()); 

            // 2. Force the LAZY collection to load while the session is open
            List<Post> artistPosts = currentUser.getPosts();
            if (artistPosts != null) {
                artistPosts.size(); // This "wakes up" the list from the DB
            }

            // 3. Calculate stats ONLY from this artist's list
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
