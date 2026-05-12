/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.model.entity.bl;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import za.ac.the.plugin.wall.model.entity.ArtistProfile;

/**
 *
 * @author VUKONA
 */
@Stateless
public class ArtistProfileFacade extends AbstractFacade<ArtistProfile> implements ArtistProfileFacadeLocal {

    @PersistenceContext(unitName = "ThePluginWallPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ArtistProfileFacade() {
        super(ArtistProfile.class);
    }
    
}
