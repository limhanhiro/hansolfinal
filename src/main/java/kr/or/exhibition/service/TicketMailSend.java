package kr.or.exhibition.service;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

import kr.or.exhibition.vo.ExhibitionPaymentMypage;

@Service
public class TicketMailSend {
	public String mailSend(ExhibitionPaymentMypage expm,String memberEmail)  {
		boolean result = false;
		// 이메일 설정
		Properties prop = System.getProperties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
		prop.put("mail.smtp.port", 587); // java버전 465
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable", true); // 추가 암호화통신사용
		prop.put("mail.smtp.ssl.protocols", "TLSv1.2"); // 추가 
		// prop.put("mail.smtp.ssl.enable", true); // 주석
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		// 인증정보설정(gmail 로그인)
		Session session = Session.getDefaultInstance(prop, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() { //비밀번호 인증코드
				PasswordAuthentication pa = new PasswordAuthentication("finalpro3team@gmail.com", "anwlek3wh!");
				return pa;
			}
		});
		// 이메일을 작성해서 전송하는 객체 생성
		MimeMessage msg = new MimeMessage(session);

		try {
			msg.setSentDate(new Date()); // 메일 전송날짜 설정
			// 보내는사람 정보
			msg.setFrom(new InternetAddress("fianl3team@gmail.com", "무지다 관리자"));
			// 받는사람정보
			InternetAddress to = new InternetAddress(memberEmail);
			msg.setRecipient(Message.RecipientType.TO, to);
			// 이메일 제목설정
			msg.setSubject("[Musée d'art]"+expm.getExhibitionTitle()+"이메일 발권 ", "UTF-8");
			// 이메일 내용설정
			msg.setContent("<h1>Musée d'art입니다.</h1>"+"<h3>"+expm.getExhibitionTitle()+" 티켓 발권이 완료되었습니다. 사용에 관한 자세한 사항은 홈페이지를 참고해주세요.</h3>"+"<h3>예약 날짜"+expm.getBookDate()+"</h3>"+
							"<h3>시간"+expm.getExhibitionTimeStart()+"~"+expm.getExhibitionTimeEnd()+"</h3>"+"<h3>주문 번호"+expm.getPaymentNo()+"</h3>", "text/html;charset=UTF-8");
			// 이메일 전송
			Transport.send(msg);
			result = true;
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result) {
			return "ok";
		}else {
			return "no";
		}
		
	}
}
