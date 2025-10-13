package com.inovel.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 用户实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    /**
     * 用户ID
     */
    private Long id;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 密码(加密)
     */
    private String password;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 头像URL
     */
    private String avatar;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 性别(0-未知,1-男,2-女)
     */
    private Integer gender;

    /**
     * 状态(1-正常,0-禁用)
     */
    private Integer status;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}
