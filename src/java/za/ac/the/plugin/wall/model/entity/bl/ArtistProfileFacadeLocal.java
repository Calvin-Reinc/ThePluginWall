/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.model.entity.bl;

import java.util.List;
import javax.ejb.Local;
import za.ac.the.plugin.wall.model.entity.ArtistProfile;

/**
 *
 * @author VUKONA
 */
@Local
public interface ArtistProfileFacadeLocal {
    ArtistProfile findByUserId(Long userId);
    //

    void create(ArtistProfile artistProfile);

    void edit(ArtistProfile artistProfile);

    void remove(ArtistProfile artistProfile);

    ArtistProfile find(Object id);

    List<ArtistProfile> findAll();

    List<ArtistProfile> findRange(int[] range);

    int count();
    
}
