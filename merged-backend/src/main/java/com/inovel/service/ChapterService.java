package com.inovel.service;

import com.inovel.entity.Chapter;
import java.util.List;

public interface ChapterService {

    // 获取章节详情
    Chapter getChapterDetail(Long id);

    // 获取作品的所有章节
    List<Chapter> getWorkChapters(Long workId);

    // 获取指定章节
    Chapter getChapterByNum(Long workId, Integer chapterNum);

    // 创建章节
    Chapter createChapter(Chapter chapter);

    // 更新章节
    Chapter updateChapter(Chapter chapter);

    // 删除章节
    boolean deleteChapter(Long id);

    // 增加浏览量
    void increaseViewCount(Long id);
}
