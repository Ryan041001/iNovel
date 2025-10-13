package com.inovel;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * iNovel 应用启动类
 * 整合了iNovel和iReader两个项目的功能
 * 
 * @author iNovel Team
 * @version 1.0.0
 */
@SpringBootApplication
@MapperScan("com.inovel.mapper")
public class INovelApplication {

    public static void main(String[] args) {
        SpringApplication.run(INovelApplication.class, args);
        System.out.println("\n========================================");
        System.out.println("   iNovel 后端服务启动成功!");
        System.out.println("   访问地址: http://localhost:8080");
        System.out.println("========================================\n");
    }
}
