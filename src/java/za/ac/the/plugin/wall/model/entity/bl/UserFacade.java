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
import javax.persistence.Query;
import za.ac.the.plugin.wall.model.entity.User;

/**
 *
 * @author VUKONA
 */
@Stateless
public class UserFacade extends AbstractFacade<User> implements UserFacadeLocal {

    @PersistenceContext(unitName = "ThePluginWallPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UserFacade() {
        super(User.class);
    }
    
    /* 
       the artistProfile must contain Followers(List or colection)
    */
    @Override
    public User findByEmail(String email) {
        Query q = em.createQuery("SELECT u FROM User u WHERE u.email = :mail");
        q.setParameter("ma", email);
        User us = (User)q.getSingleResult();
        return us;
    }
    
}
    
    
    
