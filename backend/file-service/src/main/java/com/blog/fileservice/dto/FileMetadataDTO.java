package com.blog.fileservice.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class FileMetadataDTO {
    private Long id;
    private String originalFileName;
    private String storedFileName;
    private String contentType;
    private Long fileSize;
    private String seaweedfsFileId;
    private String downloadUrl;
    private Long uploadedBy;
    private LocalDateTime uploadedAt;
    private String description;
    private String accessLevel;
}
