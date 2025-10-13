package com.inovel.service;

import com.inovel.entity.AuthorStats;

public interface AuthorStatsService {

    // 获取作者统计数据
    AuthorStats getAuthorStats(Long authorId);
}
