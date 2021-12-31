package show.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Component;

import show.service.ShowService;

@Component
public class Scheduled {
	@Autowired
	private ShowService service;
	
	@org.springframework.scheduling.annotation.Scheduled(cron = "0 0 9 * * *")
	public void cancelReserv() {
		service.cancelReserv();
	}
	
}
