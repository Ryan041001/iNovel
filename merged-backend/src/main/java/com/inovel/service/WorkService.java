package com.inovel.service;

import com.inovel.entity.Work;
import java.util.List;

public interface WorkService {

    // 获取作品详情
    Work getWorkDetail(Long id);

    // 获取作者的所有作品
    List<Work> getAuthorWorks(Long authorId);

    // 获取所有作品
    List<Work> getAllWorks();

    // 根据分类获取作品
    List<Work> getWorksByCategory(String category);

    // 搜索作品
    List<Work> searchWorks(String keyword);

    // 创建作品
    Work createWork(Work work);

    // 更新作品
    Work updateWork(Work work);

    // 删除作品
    boolean deleteWork(Long id);

    // 增加浏览量
    void increaseViewCount(Long id);

    // 增加点赞数
    void increaseLikeCount(Long id);

    // 增加收藏数
    void increaseCollectCount(Long id);
}
