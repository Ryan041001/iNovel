package com.inovel.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 阅读批注实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Annotation {

    /**
     * 批注ID
     */
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 书籍ID
     */
    private Long bookId;

    /**
     * 章节ID
     */
    private Long chapterId;

    /**
     * 批注内容
     */
    private String content;

    /**
     * 批注位置
     */
    private String position;

    /**
     * 高亮颜色
     */
    private String color;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}
