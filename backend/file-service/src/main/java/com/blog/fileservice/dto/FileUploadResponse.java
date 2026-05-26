package com.blog.fileservice.dto;

import lombok.Data;

@Data
public class FileUploadResponse {
    private Long fileId;
    private String originalFileName;
    private String storedFileName;
    private String contentType;
    private Long fileSize;
    private String seaweedfsFileId;
    private String downloadUrl;
    private String message;
}
