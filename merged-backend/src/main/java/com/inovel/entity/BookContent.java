package com.inovel.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 章节内容实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookContent {

    /**
     * 章节ID
     */
    private Long id;

    /**
     * 书籍ID
     */
    private Long bookId;

    /**
     * 章节序号
     */
    private Integer chapterOrder;

    /**
     * 章节标题
     */
    private String title;

    /**
     * 章节内容(HTML)
     */
    private String content;

    /**
     * 字数
     */
    private Integer wordCount;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    public String getChapterTitle() {
        return this.title;
    }

    public void setChapterTitle(String chapterTitle) {
        this.title = chapterTitle;
    }

    public String getChapterContent() {
        return this.content;
    }

    public void setChapterContent(String chapterContent) {
        this.content = chapterContent;
    }
}
