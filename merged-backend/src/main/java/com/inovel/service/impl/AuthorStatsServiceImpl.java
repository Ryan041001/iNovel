package com.inovel.service.impl;

import com.inovel.entity.AuthorStats;
import com.inovel.mapper.AuthorStatsMapper;
import com.inovel.service.AuthorStatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthorStatsServiceImpl implements AuthorStatsService {

    @Autowired
    private AuthorStatsMapper authorStatsMapper;

    @Override
    public AuthorStats getAuthorStats(Long authorId) {
        AuthorStats stats = authorStatsMapper.getAuthorStats(authorId);
        if (stats != null) {
            // 获取时间维度统计
            stats.setTodayViews(authorStatsMapper.getTodayViews(authorId));
            stats.setWeekViews(authorStatsMapper.getWeekViews(authorId));
            stats.setMonthViews(authorStatsMapper.getMonthViews(authorId));
        }
        return stats;
    }
}
