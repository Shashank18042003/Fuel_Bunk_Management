package com.example.demo.ExceptionHandling;


public class UnauthorizedException  extends RuntimeException {

    public UnauthorizedException(String message) {
        super(message);
    }
}