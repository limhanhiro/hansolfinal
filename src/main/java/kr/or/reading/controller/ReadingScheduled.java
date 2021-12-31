package kr.or.reading.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.reading.model.service.ReadingService;

@Component
public class ReadingScheduled {
	
	@Autowired
	private ReadingService service;
	
	//매일 00시 00분 00초에 black_end랑 일치하면 블랙리스트에서 삭제
	@Scheduled(cron = "0 0 0 * * *")
	public void blackListCheck() {
		SimpleDateFormat format = new SimpleDateFormat ("yy/MM/dd HH:mm:ss");
		Date time = new Date();
		String time1 = format.format(time);
		service.timeOutBlackList(time1);
	}
	
}
