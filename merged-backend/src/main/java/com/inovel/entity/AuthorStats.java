package com.inovel.entity;

import lombok.Data;

/**
 * 作者数据统计实体类
 */
@Data
public class AuthorStats {
    private Long authorId; // 作者ID
    private Integer totalWorks; // 总作品数
    private Integer totalWords; // 总字数
    private Integer totalViews; // 总浏览量
    private Integer totalLikes; // 总点赞数
    private Integer totalCollects;// 总收藏数
    private Integer totalFans; // 粉丝数
    private Integer todayViews; // 今日浏览量
    private Integer weekViews; // 本周浏览量
    private Integer monthViews; // 本月浏览量
}
