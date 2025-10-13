package com.inovel.service;

import com.inovel.entity.Book;
import com.inovel.entity.UserShelf;
import com.inovel.mapper.BookMapper;
import com.inovel.mapper.UserBookShelfMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserBookShelfService {

    @Autowired
    private UserBookShelfMapper userBookShelfMapper;
    @Autowired
    private BookMapper bookMapper;

    public List<Book> getBooksByUser(Long userId, String keyword) {
        List<UserShelf> shelf = userBookShelfMapper.findByUserId(userId);
        if (shelf.isEmpty())
            return new ArrayList<>();
        List<Long> bookIds = shelf.stream().map(UserShelf::getBookId).toList();

        if (keyword != null && !keyword.isEmpty()) {
            return bookMapper.findByIdsAndKeyword(bookIds, keyword);
        } else {
            return bookMapper.findByIds(bookIds);
        }
    }

    public void addBook(Long userId, Long bookId) {
        userBookShelfMapper.addBook(userId, bookId);
    }

    public void removeBook(Long userId, Long bookId) {
        userBookShelfMapper.removeBook(userId, bookId);
    }

    public boolean existsByUserIdAndBookId(Long userId, Long bookId) {
        return userBookShelfMapper.existsByUserIdAndBookId(userId, bookId) > 0;
    }
}
