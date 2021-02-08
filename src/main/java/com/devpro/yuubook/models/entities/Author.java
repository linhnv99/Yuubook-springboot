package com.devpro.yuubook.models.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "author")
public class Author extends BaseEntity {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "author", fetch = FetchType.LAZY)
    private List<Book> books = new ArrayList<>();

    private String name;

    @Column(name = "show_home")
    private Boolean showHome;

    private String avatar;

    @Lob
    @Column(name = "description", columnDefinition = "text")
    private String desc;

    @Transient
    private MultipartFile file;
}

