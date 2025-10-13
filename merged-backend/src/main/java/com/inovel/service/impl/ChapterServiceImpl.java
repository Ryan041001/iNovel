package com.inovel.service.impl;

import com.inovel.entity.Chapter;
import com.inovel.mapper.ChapterMapper;
import com.inovel.service.ChapterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class ChapterServiceImpl implements ChapterService {

    @Autowired
    private ChapterMapper chapterMapper;

    @Override
    public Chapter getChapterDetail(Long id) {
        return chapterMapper.selectById(id);
    }

    @Override
    public List<Chapter> getWorkChapters(Long workId) {
        return chapterMapper.selectByWorkId(workId);
    }

    @Override
    public Chapter getChapterByNum(Long workId, Integer chapterNum) {
        return chapterMapper.selectByWorkIdAndChapterNum(workId, chapterNum);
    }

    @Override
    @Transactional
    public Chapter createChapter(Chapter chapter) {
        chapter.setCreateTime(new Date());
        chapter.setUpdateTime(new Date());
        chapter.setViewCount(0);
        // 计算字数
        if (chapter.getContent() != null) {
            chapter.setWordCount(chapter.getContent().length());
        }
        chapterMapper.insert(chapter);
        return chapter;
    }

    @Override
    @Transactional
    public Chapter updateChapter(Chapter chapter) {
        chapter.setUpdateTime(new Date());
        // 重新计算字数
        if (chapter.getContent() != null) {
            chapter.setWordCount(chapter.getContent().length());
        }
        chapterMapper.update(chapter);
        return chapterMapper.selectById(chapter.getId());
    }

    @Override
    @Transactional
    public boolean deleteChapter(Long id) {
        return chapterMapper.deleteById(id) > 0;
    }

    @Override
    public void increaseViewCount(Long id) {
        chapterMapper.updateViewCount(id);
    }
}
