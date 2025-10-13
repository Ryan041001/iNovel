package com.inovel.service.impl;

import com.inovel.entity.Work;
import com.inovel.mapper.ChapterMapper;
import com.inovel.mapper.WorkMapper;
import com.inovel.service.WorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class WorkServiceImpl implements WorkService {

    @Autowired
    private WorkMapper workMapper;

    @Autowired
    private ChapterMapper chapterMapper;

    @Override
    public Work getWorkDetail(Long id) {
        Work work = workMapper.selectById(id);
        if (work != null) {
            // 获取字数统计
            Integer wordCount = chapterMapper.sumWordCountByWorkId(id);
            work.setWordCount(wordCount != null ? wordCount : 0);
        }
        return work;
    }

    @Override
    public List<Work> getAuthorWorks(Long authorId) {
        return workMapper.selectByAuthorId(authorId);
    }

    @Override
    public List<Work> getAllWorks() {
        return workMapper.selectAll();
    }

    @Override
    public List<Work> getWorksByCategory(String category) {
        return workMapper.selectByCategory(category);
    }

    @Override
    public List<Work> searchWorks(String keyword) {
        return workMapper.search(keyword);
    }

    @Override
    @Transactional
    public Work createWork(Work work) {
        work.setCreateTime(new Date());
        work.setUpdateTime(new Date());
        work.setViewCount(0);
        work.setLikeCount(0);
        work.setCollectCount(0);
        work.setWordCount(0);
        workMapper.insert(work);
        return work;
    }

    @Override
    @Transactional
    public Work updateWork(Work work) {
        work.setUpdateTime(new Date());
        workMapper.update(work);
        return workMapper.selectById(work.getId());
    }

    @Override
    @Transactional
    public boolean deleteWork(Long id) {
        // 先删除所有章节
        chapterMapper.deleteByWorkId(id);
        // 再删除作品
        return workMapper.deleteById(id) > 0;
    }

    @Override
    public void increaseViewCount(Long id) {
        workMapper.updateViewCount(id);
    }

    @Override
    public void increaseLikeCount(Long id) {
        workMapper.updateLikeCount(id);
    }

    @Override
    public void increaseCollectCount(Long id) {
        workMapper.updateCollectCount(id);
    }
}
