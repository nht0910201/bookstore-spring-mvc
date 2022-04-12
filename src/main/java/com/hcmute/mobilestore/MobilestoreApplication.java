package com.hcmute.mobilestore;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@SpringBootApplication
public class MobilestoreApplication {

	public static void main(String[] args) {
		SpringApplication.run(MobilestoreApplication.class, args);
	}

}
