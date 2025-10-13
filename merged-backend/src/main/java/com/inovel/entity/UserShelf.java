package com.inovel.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 用户书架实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserShelf {

    /**
     * 书架ID
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
     * 最后阅读章节
     */
    private Integer lastChapter;

    /**
     * 阅读进度(百分比)
     */
    private BigDecimal readingProgress;

    /**
     * 是否收藏
     */
    private Integer isFavorite;

    /**
     * 添加时间
     */
    private LocalDateTime addTime;

    /**
     * 最后阅读时间
     */
    private LocalDateTime lastReadTime;

    /**
     * 书籍信息(关联查询时使用)
     */
    private Book book;
}
