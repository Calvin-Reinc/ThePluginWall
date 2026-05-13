/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.model.entity.bl;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import za.ac.the.plugin.wall.model.entity.Post;

/**
 *
 * @author khali
 */
@Stateless
public class PostFacade extends AbstractFacade<Post> implements PostFacadeLocal {

    @PersistenceContext(unitName = "ThePluginWallPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PostFacade() {
        super(Post.class);
    }
    
    public List<Post> findAllWithDetails() {
        return em.createQuery(
            "SELECT DISTINCT p FROM Post p LEFT JOIN FETCH p.comments LEFT JOIN FETCH p.artist", 
            Post.class).getResultList();
    }
    
    @Override
    public List<Post> findAllAndRefresh() {
        List<Post> posts = findAll();
        for (Post p : posts) {
            em.refresh(p); // 'em' is your @PersistenceContext EntityManager
        }
        return posts;
    }
    
    @Override
    public List<Post> findAllFresh() {
        return em.createQuery("SELECT p FROM Post p", Post.class)
            .setHint("javax.persistence.cache.retrieveMode", "BYPASS")
            .getResultList();
    }
    
    @Override
    public List<Post> findByArtist(Long artistId) {
        return em.createQuery("SELECT p FROM Post p WHERE p.artist.id = :id", Post.class)
                 .setParameter("id", artistId)
                 .getResultList();
    }
    
    @Override
    public void flush() {
        getEntityManager().flush();
    }
    
    @Override
    public void refresh(Post post) {
        em.refresh(em.merge(post));
    }
}
