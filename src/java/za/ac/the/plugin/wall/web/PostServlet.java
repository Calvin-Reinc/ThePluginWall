/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import za.ac.the.plugin.wall.model.entity.ArtistProfile;
import za.ac.the.plugin.wall.model.entity.Post;
import za.ac.the.plugin.wall.model.entity.bl.PostFacadeLocal;

/**
 *
 * @author khali
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class PostServlet extends HttpServlet {

   @EJB
    private PostFacadeLocal pf;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
       // 1. MUST BE FIRST: Handle the file before getting parameters
        Part filePart = request.getPart("file");
        String content = request.getParameter("content"); // Get text after

        String finalFileName = null;
        String uploadPath = "C:/plugin_uploads"; // Ensure this folder exists!

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            if (fileName != null && !fileName.isEmpty()) {
                String pureFileName = new File(fileName).getName();
                finalFileName = UUID.randomUUID().toString() + "_" + pureFileName;

                File fileToSave = new File(uploadPath + File.separator + finalFileName);

                // Use Buffer for a "Force Write"
                try (InputStream input = filePart.getInputStream();
                        OutputStream output = new java.io.BufferedOutputStream(new FileOutputStream(fileToSave))) {

                    byte[] buffer = new byte[8192]; // 8KB buffer
                    int length;
                    while ((length = input.read(buffer)) != -1) {
                        output.write(buffer, 0, length);
                    }
                    output.flush(); // Force the data out of memory onto the disk
                }
                System.out.println("FILE SAVED TO: " + fileToSave.getAbsolutePath());
            }
        }

        // 2. Database Logic
        HttpSession session = request.getSession();
        ArtistProfile artist = (ArtistProfile) session.getAttribute("userA");

        if (artist != null && ((content != null && !content.trim().isEmpty()) || finalFileName != null)) {
            Post newPost = new Post();
            newPost.setContent(content);
            newPost.setArtist(artist);
            newPost.setImageName(finalFileName);
            newPost.setLikes(0);
            pf.create(newPost);
        }

        response.sendRedirect("ArtistDashServlet.do");
    }


}
