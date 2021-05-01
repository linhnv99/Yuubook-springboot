package com.devpro.yuubook.models.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

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

    private String slug;
}

