package com.inovel.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 统一响应结果类
 * 
 * @param <T> 响应数据类型
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result<T> {

    /**
     * 是否成功
     */
    private Boolean success;

    /**
     * 响应消息
     */
    private String message;

    /**
     * 响应数据
     */
    private T data;

    /**
     * 状态码
     */
    private Integer code;

    /**
     * 成功响应(无数据)
     */
    public static <T> Result<T> success() {
        return new Result<>(true, "操作成功", null, 200);
    }

    /**
     * 成功响应(带数据)
     */
    public static <T> Result<T> success(T data) {
        return new Result<>(true, "操作成功", data, 200);
    }

    /**
     * 成功响应(带消息和数据)
     */
    public static <T> Result<T> success(String message, T data) {
        return new Result<>(true, message, data, 200);
    }

    /**
     * 失败响应
     */
    public static <T> Result<T> fail(String message) {
        return new Result<>(false, message, null, 500);
    }

    /**
     * 失败响应(带状态码)
     */
    public static <T> Result<T> fail(String message, Integer code) {
        return new Result<>(false, message, null, code);
    }

    /**
     * 失败响应(带数据和状态码)
     */
    public static <T> Result<T> fail(String message, T data, Integer code) {
        return new Result<>(false, message, data, code);
    }
}
