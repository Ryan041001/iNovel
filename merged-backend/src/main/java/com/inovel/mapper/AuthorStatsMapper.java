package com.inovel.mapper;

import com.inovel.entity.AuthorStats;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AuthorStatsMapper {

    // 获取作者统计数据
    AuthorStats getAuthorStats(@Param("authorId") Long authorId);

    // 获取作者今日浏览量
    Integer getTodayViews(@Param("authorId") Long authorId);

    // 获取作者本周浏览量
    Integer getWeekViews(@Param("authorId") Long authorId);

    // 获取作者本月浏览量
    Integer getMonthViews(@Param("authorId") Long authorId);
}
