package com.inovel.entity;

import lombok.Data;

import java.util.Date;

/**
 * 作品实体类 - 从原iNovel的ebookinfo整合而来
 */
@Data
public class Work {
    private Long id; // 作品ID
    private String title; // 作品标题
    private String cover; // 封面图片路径
    private String category; // 作品分类
    private String description;// 作品简介
    private Long authorId; // 作者ID
    private String authorName; // 作者名称
    private Integer status; // 状态: 0-草稿, 1-连载中, 2-已完结
    private Integer wordCount; // 字数统计
    private Integer viewCount; // 浏览量
    private Integer likeCount; // 点赞数
    private Integer collectCount; // 收藏数
    private Date createTime; // 创建时间
    private Date updateTime; // 更新时间
}
