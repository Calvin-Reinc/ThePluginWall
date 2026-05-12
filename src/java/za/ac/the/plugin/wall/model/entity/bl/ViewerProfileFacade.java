/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.model.entity.bl;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import za.ac.the.plugin.wall.model.entity.ViewerProfile;

/**
 *
 * @author VUKONA
 */
@Stateless
public class ViewerProfileFacade extends AbstractFacade<ViewerProfile> implements ViewerProfileFacadeLocal {

    @PersistenceContext(unitName = "ThePluginWallPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ViewerProfileFacade() {
        super(ViewerProfile.class);
    }
    
}
