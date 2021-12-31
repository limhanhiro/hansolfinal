package kr.or.space.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.space.model.service.SpaceService;

@Component
public class SpaceScheduled {
	@Autowired
	private SpaceService service;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void insertSpaceBlack() {
		service.insertSpaceBlack();
	}
	
	@Scheduled(cron = "0 0 0 * * *")
	public void blackListCheck() {
		SimpleDateFormat format = new SimpleDateFormat ("yy/MM/dd HH:mm:ss");
		Date time = new Date();
		String time1 = format.format(time);
		service.cancleBlackList(time1);
	}
	
}
