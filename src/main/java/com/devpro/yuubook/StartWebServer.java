package com.devpro.yuubook;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class StartWebServer {
	/*
	 * Khởi chạy webserver (tomcat)
	 * 
	 */
	public static void main(String[] args) {
		SpringApplication.run(StartWebServer.class, args);
	}
}
