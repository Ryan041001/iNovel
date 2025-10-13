package com.inovel.entity;

import lombok.Data;

import java.util.Date;

/**
 * 章节实体类 - 从原iNovel的chapterinfo整合而来
 */
@Data
public class Chapter {
    private Long id; // 章节ID
    private Long workId; // 所属作品ID
    private Integer chapterNum; // 章节序号
    private String title; // 章节标题
    private String content; // 章节内容
    private Integer wordCount;// 字数
    private Integer viewCount;// 浏览量
    private Date createTime; // 创建时间
    private Date updateTime; // 更新时间
}
