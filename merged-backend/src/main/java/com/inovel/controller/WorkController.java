package com.inovel.controller;

import com.inovel.entity.Work;
import com.inovel.response.Result;
import com.inovel.service.WorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 作品管理控制器
 */
@RestController
@RequestMapping("/api/work")
public class WorkController {

    @Autowired
    private WorkService workService;

    /**
     * 获取作品详情
     */
    @GetMapping("/{id}")
    public Result<Work> getWorkDetail(@PathVariable Long id) {
        Work work = workService.getWorkDetail(id);
        if (work != null) {
            return Result.success(work);
        }
        return Result.fail("作品不存在");
    }

    /**
     * 获取作者的所有作品
     */
    @GetMapping("/author/{authorId}")
    public Result<List<Work>> getAuthorWorks(@PathVariable Long authorId) {
        List<Work> works = workService.getAuthorWorks(authorId);
        return Result.success(works);
    }

    /**
     * 获取所有作品
     */
    @GetMapping("/list")
    public Result<List<Work>> getAllWorks() {
        List<Work> works = workService.getAllWorks();
        return Result.success(works);
    }

    /**
     * 根据分类获取作品
     */
    @GetMapping("/category/{category}")
    public Result<List<Work>> getWorksByCategory(@PathVariable String category) {
        List<Work> works = workService.getWorksByCategory(category);
        return Result.success(works);
    }

    /**
     * 搜索作品
     */
    @GetMapping("/search")
    public Result<List<Work>> searchWorks(@RequestParam String keyword) {
        List<Work> works = workService.searchWorks(keyword);
        return Result.success(works);
    }

    /**
     * 创建作品
     */
    @PostMapping
    public Result<Work> createWork(@RequestBody Work work) {
        Work created = workService.createWork(work);
        return Result.success(created);
    }

    /**
     * 更新作品
     */
    @PutMapping("/{id}")
    public Result<Work> updateWork(@PathVariable Long id, @RequestBody Work work) {
        work.setId(id);
        Work updated = workService.updateWork(work);
        return Result.success(updated);
    }

    /**
     * 删除作品
     */
    @DeleteMapping("/{id}")
    public Result<Boolean> deleteWork(@PathVariable Long id) {
        boolean deleted = workService.deleteWork(id);
        if (deleted) {
            return Result.success(true);
        }
        return Result.fail("删除失败");
    }

    /**
     * 增加浏览量
     */
    @PostMapping("/{id}/view")
    public Result<Void> increaseViewCount(@PathVariable Long id) {
        workService.increaseViewCount(id);
        return Result.success(null);
    }

    /**
     * 点赞
     */
    @PostMapping("/{id}/like")
    public Result<Void> increaseLikeCount(@PathVariable Long id) {
        workService.increaseLikeCount(id);
        return Result.success(null);
    }

    /**
     * 收藏
     */
    @PostMapping("/{id}/collect")
    public Result<Void> increaseCollectCount(@PathVariable Long id) {
        workService.increaseCollectCount(id);
        return Result.success(null);
    }
}
