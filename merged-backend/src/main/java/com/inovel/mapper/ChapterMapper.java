package com.inovel.mapper;

import com.inovel.entity.Chapter;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ChapterMapper {

    // 根据ID查询章节
    Chapter selectById(@Param("id") Long id);

    // 根据作品ID查询章节列表
    List<Chapter> selectByWorkId(@Param("workId") Long workId);

    // 根据作品ID和章节号查询章节
    Chapter selectByWorkIdAndChapterNum(@Param("workId") Long workId, @Param("chapterNum") Integer chapterNum);

    // 插入章节
    int insert(Chapter chapter);

    // 更新章节
    int update(Chapter chapter);

    // 删除章节
    int deleteById(@Param("id") Long id);

    // 根据作品ID删除所有章节
    int deleteByWorkId(@Param("workId") Long workId);

    // 更新浏览量
    int updateViewCount(@Param("id") Long id);

    // 获取作品的章节总数
    int countByWorkId(@Param("workId") Long workId);

    // 获取作品的总字数
    Integer sumWordCountByWorkId(@Param("workId") Long workId);
}
