package com.inovel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 页面路由控制器
 */
@Controller
public class PageController {

    /**
     * 个人中心页面
     */
    @GetMapping("/user-center")
    public String userCenter(Model model) {
        model.addAttribute("pageTitle", "个人中心 - 书海阁");
        return "user-center";
    }

    /**
     * 作者中心页面
     */
    @GetMapping("/author-center")
    public String authorCenter(Model model) {
        model.addAttribute("pageTitle", "作者中心 - 书海阁");
        return "author-center";
    }

    /**
     * 首页
     */
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("pageTitle", "书海阁 - 在线小说阅读平台");
        return "index";
    }

    /**
     * 分类页面
     */
    @GetMapping("/category")
    public String category(Model model) {
        model.addAttribute("pageTitle", "分类浏览 - 书海阁");
        return "category";
    }

    /**
     * 书籍详情页面
     */
    @GetMapping("/book-detail")
    public String bookDetail(Model model) {
        model.addAttribute("pageTitle", "书籍详情 - 书海阁");
        return "book-detail";
    }

    /**
     * 阅读页面
     */
    @GetMapping("/read")
    public String read(Model model) {
        model.addAttribute("pageTitle", "阅读 - 书海阁");
        return "read";
    }
}
