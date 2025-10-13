package com.inovel.controller;

import com.inovel.entity.AuthorStats;
import com.inovel.response.Result;
import com.inovel.service.AuthorStatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 作者数据统计控制器
 */
@RestController
@RequestMapping("/api/author")
public class AuthorController {

    @Autowired
    private AuthorStatsService authorStatsService;

    /**
     * 获取作者统计数据
     */
    @GetMapping("/{authorId}/stats")
    public Result<AuthorStats> getAuthorStats(@PathVariable Long authorId) {
        AuthorStats stats = authorStatsService.getAuthorStats(authorId);
        return Result.success(stats);
    }
}
