package com.inovel.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Web MVC 配置
 * 配置CORS、静态资源等
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    /**
     * 配置跨域访问
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOrigins("http://localhost:5173", "http://localhost:3000")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }

    /**
     * 配置静态资源访问
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 书籍上传目录
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:uploads/");

        // 静态资源目录
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }
}
