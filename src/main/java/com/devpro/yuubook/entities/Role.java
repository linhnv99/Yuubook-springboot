package com.devpro.yuubook.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;

@Entity
@Table(name = "role")
public class Role extends BaseEntity implements GrantedAuthority {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1246140592057874482L;

	@ManyToMany(fetch = FetchType.EAGER, mappedBy = "roles")
	private List<User> users = new ArrayList<User>();

	@Column(name = "name", nullable = false)
	private String name;

	@Lob
	@Column(name = "description", columnDefinition = "text")
	private String desc;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	@Override
	public String getAuthority() {
		return this.name;
	}
}
