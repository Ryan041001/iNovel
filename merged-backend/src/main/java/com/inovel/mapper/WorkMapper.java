package com.inovel.mapper;

import com.inovel.entity.Work;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WorkMapper {

    // 根据ID查询作品
    Work selectById(@Param("id") Long id);

    // 根据作者ID查询作品列表
    List<Work> selectByAuthorId(@Param("authorId") Long authorId);

    // 查询所有作品
    List<Work> selectAll();

    // 根据分类查询作品
    List<Work> selectByCategory(@Param("category") String category);

    // 搜索作品(标题/作者)
    List<Work> search(@Param("keyword") String keyword);

    // 插入作品
    int insert(Work work);

    // 更新作品
    int update(Work work);

    // 删除作品
    int deleteById(@Param("id") Long id);

    // 更新统计数据
    int updateViewCount(@Param("id") Long id);

    int updateLikeCount(@Param("id") Long id);

    int updateCollectCount(@Param("id") Long id);

    // 根据作者ID获取作品数量
    int countByAuthorId(@Param("authorId") Long authorId);
}
