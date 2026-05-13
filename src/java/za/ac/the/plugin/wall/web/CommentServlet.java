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
import za.ac.the.plugin.wall.model.entity.Comment;
import za.ac.the.plugin.wall.model.entity.Post;
import za.ac.the.plugin.wall.model.entity.User;
import za.ac.the.plugin.wall.model.entity.bl.CommentFacadeLocal;
import za.ac.the.plugin.wall.model.entity.bl.PostFacadeLocal;

/**
 *
 * @author khali
 */
public class CommentServlet extends HttpServlet {
    @EJB
    private CommentFacadeLocal cf;
    @EJB
    private PostFacadeLocal pf;
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Retrieve the logged-in User object stored during login
        User user = (User) session.getAttribute("user"); 

        if (user == null) {
            response.sendRedirect("sign_in.jsp");
            return;
        }

        String text = request.getParameter("commentText");
        String postIdStr = request.getParameter("postId");

        if (text != null && !text.trim().isEmpty() && postIdStr != null) {
            Long postId = Long.parseLong(postIdStr);
            Post post = pf.find(postId);

            if (post != null) {
                Comment comment = new Comment();
                comment.setText(text);
                comment.setPost(post);    // Links comment to the specific Post
                comment.setAuthor(user);  // Links comment to the User who wrote it
                
                if (post.getComments() != null) {
                    post.getComments().add(comment);
                }
                
                cf.create(comment);
                cf.flush();
            }
            
        }
        String source = request.getParameter("source"); 
        String postId = request.getParameter("postId");

        if ("singlePost".equals(source)) {
            // Redirect back to the specific post page
            response.sendRedirect("PostPageServlet.do?postId=" + postId);
        } else {
            // Go back to the general feed
            response.sendRedirect("FeedServlet.do");
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
