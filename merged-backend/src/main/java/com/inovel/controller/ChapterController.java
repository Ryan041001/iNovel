package com.inovel.controller;

import com.inovel.entity.Chapter;
import com.inovel.response.Result;
import com.inovel.service.ChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 章节管理控制器
 */
@RestController
@RequestMapping("/api/chapter")
public class ChapterController {

    @Autowired
    private ChapterService chapterService;

    /**
     * 获取章节详情
     */
    @GetMapping("/{id}")
    public Result<Chapter> getChapterDetail(@PathVariable Long id) {
        Chapter chapter = chapterService.getChapterDetail(id);
        if (chapter != null) {
            // 增加浏览量
            chapterService.increaseViewCount(id);
            return Result.success(chapter);
        }
        return Result.fail("章节不存在");
    }

    /**
     * 获取作品的所有章节
     */
    @GetMapping("/work/{workId}")
    public Result<List<Chapter>> getWorkChapters(@PathVariable Long workId) {
        List<Chapter> chapters = chapterService.getWorkChapters(workId);
        return Result.success(chapters);
    }

    /**
     * 根据作品ID和章节号获取章节
     */
    @GetMapping("/work/{workId}/num/{chapterNum}")
    public Result<Chapter> getChapterByNum(@PathVariable Long workId,
            @PathVariable Integer chapterNum) {
        Chapter chapter = chapterService.getChapterByNum(workId, chapterNum);
        if (chapter != null) {
            // 增加浏览量
            chapterService.increaseViewCount(chapter.getId());
            return Result.success(chapter);
        }
        return Result.fail("章节不存在");
    }

    /**
     * 创建章节
     */
    @PostMapping
    public Result<Chapter> createChapter(@RequestBody Chapter chapter) {
        Chapter created = chapterService.createChapter(chapter);
        return Result.success(created);
    }

    /**
     * 更新章节
     */
    @PutMapping("/{id}")
    public Result<Chapter> updateChapter(@PathVariable Long id, @RequestBody Chapter chapter) {
        chapter.setId(id);
        Chapter updated = chapterService.updateChapter(chapter);
        return Result.success(updated);
    }

    /**
     * 删除章节
     */
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteChapter(@PathVariable Long id) {
        boolean deleted = chapterService.deleteChapter(id);
        if (deleted) {
            return Result.success(true);
        }
        return Result.fail("删除失败");
    }
}
