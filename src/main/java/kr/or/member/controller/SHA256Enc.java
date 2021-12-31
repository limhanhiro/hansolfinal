package kr.or.member.controller;

import java.security.MessageDigest;

import org.springframework.stereotype.Component;

@Component
public class SHA256Enc {
	public String encData(String data) throws Exception{
		
		//spring security의 MessageDigest 객체를 이용한 암호화
		MessageDigest mDigest = MessageDigest.getInstance("SHA-256");
		
		//매개변수로 받은 값을 byte 배열로 변환 하여 mDigest객체에 저장 (SHA-256으로 변환 완료)
		mDigest.update(data.getBytes());
		//SHA-256 으로 변환된 데이터를 byte[]로 꺼냄
		byte[] msgStr = mDigest.digest(); // byte 는 정수타입  표현 범위 -> -128 ~ 127 총 256개 표현
		//0~ 255로 변환 하여 문자열로 표현
		StringBuffer sb = new StringBuffer();
		for(int i=0;i<msgStr.length;i++) {
			byte tmp = msgStr[i];
			String tmpText = Integer.toString((tmp & 0xff)+0x100,16).substring(1);
			sb.append(tmpText);
		}
		return sb.toString();
	}
}