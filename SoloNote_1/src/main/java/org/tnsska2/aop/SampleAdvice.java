package org.tnsska2.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class SampleAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleAdvice.class);
	
	@Before("execution(* org.tnsska2.service.MessageService*.*(..))")
	public void startLog() {
		
		logger.info("-----------------------");
		logger.info("-----------------------");
	}
}
