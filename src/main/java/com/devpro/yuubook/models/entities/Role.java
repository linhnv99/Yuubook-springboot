package com.devpro.yuubook.models.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;

@Entity
@Getter
@Setter
@Table(name = "role")
public class Role extends BaseEntity implements GrantedAuthority {

    @ManyToMany(fetch = FetchType.EAGER, mappedBy = "roles")
    private List<User> users = new ArrayList<User>();

    private String name;
    @Lob
    @Column(name = "description", columnDefinition = "text")
    private String desc;

    @Override
    public String getAuthority() {
        return this.name;
    }
}
