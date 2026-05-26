package com.blog.fileservice.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "files")
@Getter
@Setter
public class FileMetadata {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String originalFileName;
    
    @Column(nullable = false, unique = true)
    private String storedFileName;
    
    @Column(nullable = false)
    private String contentType;
    
    @Column(nullable = false)
    private Long fileSize;
    
    @Column(nullable = false)
    private String seaweedfsFileId;
    
    private String seaweedfsUrl;
    
    @Column(nullable = false)
    private Long uploadedBy;
    
    @Column(nullable = false)
    private LocalDateTime uploadedAt;
    
    private LocalDateTime deletedAt;
    
    @Column(nullable = false)
    private Boolean isDeleted = false;
    
    private String description;
    
    @Column(nullable = false)
    private String accessLevel = "PUBLIC"; // PUBLIC, PRIVATE, RESTRICTED
    
    /**
     * Intent: Initialize uploadedAt timestamp automatically prior to database persistence.
     */
    @PrePersist
    protected void onCreate() {
        uploadedAt = LocalDateTime.now();
    }
}
