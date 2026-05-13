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
import za.ac.the.plugin.wall.model.entity.Post;
import za.ac.the.plugin.wall.model.entity.bl.PostFacadeLocal;

/**
 *
 * @author khali
 */
public class PostPageServlet extends HttpServlet {

    @EJB
    private PostFacadeLocal pf;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("postId");
        
        if (idParam != null) {
            Long postId = Long.parseLong(idParam);
            // Fetch the specific post
            Post singlePost = pf.find(postId);
            
            
            if (singlePost != null) {
                pf.refresh(singlePost);
                request.setAttribute("selectedPost", singlePost);
                request.getRequestDispatcher("post_page.jsp").forward(request, response);
            }
        }
        
        // If post not found, go back to feed
        response.sendRedirect("FeedServlet.do");
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
