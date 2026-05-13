/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.model.entity.bl;

import java.util.List;
import javax.ejb.Local;
import za.ac.the.plugin.wall.model.entity.ArtistProfile;
import za.ac.the.plugin.wall.model.entity.Post;

/**
 *
 * @author khali
 */
@Local
public interface PostFacadeLocal {
    List<Post> findAllByArtist(ArtistProfile artist);
    void createPost(Post post);
    void refresh(Post post);
    void flush();
    List<Post> findAllFresh();
    List<Post> findAllAndRefresh();
    
    void create(Post post);

    void edit(Post post);

    void remove(Post post);

    Post find(Object id);

    List<Post> findAll();

    List<Post> findRange(int[] range);

    int count();
    
    List<Post> findAllWithDetails();
    
}
