package com.inovel.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 书籍实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Book {

    /**
     * 书籍ID
     */
    private Long id;

    /**
     * 书名
     */
    private String title;

    /**
     * 作者
     */
    private String author;

    /**
     * 封面图URL
     */
    private String cover;

    /**
     * 分类
     */
    private String category;

    /**
     * 简介
     */
    private String description;

    /**
     * 文件路径
     */
    private String filePath;

    /**
     * 文件类型(txt/epub/pdf)
     */
    private String fileType;

    /**
     * 文件大小(字节)
     */
    private Long fileSize;

    /**
     * 总章节数
     */
    private Integer totalChapters;

    /**
     * 总字数
     */
    private Long totalWords;

    /**
     * 状态(1-正常,0-下架)
     */
    private Integer status;

    /**
     * 浏览次数
     */
    private Long views;

    /**
     * 上传者ID
     */
    private Long uploadUserId;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;

    /**
     * 简介（与 description 兼容）
     */
    private String intro;

    /**
     * 是否免费（1-免费，0-收费）
     */
    private Integer isFree;

    /**
     * 出版社
     */
    private String publisher;

    /**
     * 出版时间
     */
    private LocalDateTime publishTime;

    /**
     * ISBN
     */
    private String isbn;

    /**
     * 品牌
     */
    private String brand;

    /**
     * 上传者ID（与 uploadUserId 兼容）
     */
    private Long uploaderId;

    /**
     * 可见性
     */
    private String visibility;

    // 兼容 setUploader_id 调用
    public void setUploader_id(Long uploaderId) {
        this.uploaderId = uploaderId;
    }
}
