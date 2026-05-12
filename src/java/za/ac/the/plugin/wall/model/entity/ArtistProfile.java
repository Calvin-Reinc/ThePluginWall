/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package za.ac.the.plugin.wall.model.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;

/**
 *
 * @author VUKONA
 */
@Entity
public class ArtistProfile implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "user_id")
    private Long id;
    
    
    @OneToOne
    @MapsId
    @JoinColumn(name = "userId")
    private User user;
    
    @Column(name = "spotify_url")
    private String spotifyUrl;

    @Column(name = "soundcloud_url")
    private String soundCloudUrl;

    @Column(name = "youtube_url")
    private String youtubeUrl;

    public ArtistProfile() {
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getSpotifyUrl() {
        return spotifyUrl;
    }

    public void setSpotifyUrl(String spotifyUrl) {
        this.spotifyUrl = spotifyUrl;
    }

    public String getSoundCloudUrl() {
        return soundCloudUrl;
    }

    public void setSoundCloudUrl(String soundCloudUrl) {
        this.soundCloudUrl = soundCloudUrl;
    }

    public String getYoutubeUrl() {
        return youtubeUrl;
    }

    public void setYoutubeUrl(String youtubeUrl) {
        this.youtubeUrl = youtubeUrl;
    }
    
    

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ArtistProfile)) {
            return false;
        }
        ArtistProfile other = (ArtistProfile) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "za.ac.the.plugin.wall.model.entity.ArtistProfile[ id=" + id + " ]";
    }
    
}
