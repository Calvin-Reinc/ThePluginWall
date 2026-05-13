/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.model.entity.bl;

import java.util.List;
import javax.ejb.Local;
import za.ac.the.plugin.wall.model.entity.Comment;

/**
 *
 * @author khali
 */
@Local
public interface CommentFacadeLocal {
    void flush();
    
    void create(Comment comment);

    void edit(Comment comment);

    void remove(Comment comment);

    Comment find(Object id);

    List<Comment> findAll();

    List<Comment> findRange(int[] range);

    int count();
    
}
