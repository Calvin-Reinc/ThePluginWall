/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.web;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import za.ac.the.plugin.wall.model.entity.ArtistProfile;
import za.ac.the.plugin.wall.model.entity.Post;
import za.ac.the.plugin.wall.model.entity.bl.PostFacadeLocal;

/**
 *
 * @author khali
 */
public class PostServlet extends HttpServlet {

   @EJB
    private PostFacadeLocal pf;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        ArtistProfile artist = (ArtistProfile) session.getAttribute("userA"); // Match LoginServlet attribute [cite: 30]

        if (artist == null) {
            response.sendRedirect("sign_in.jsp");
            return;
        }

        String content = request.getParameter("content");
        
        if (content != null && !content.trim().isEmpty()) {
            Post newPost = new Post();
            newPost.setContent(content);
            newPost.setArtist(artist);
            
            pf.create(newPost);
        }

        response.sendRedirect("ArtistDashServlet.do");
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
