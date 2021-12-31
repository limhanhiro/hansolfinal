package kr.or.member.controller;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.or.member.vo.Member;

@Component
@Aspect
public class PasswordEncAdivice {
	@Autowired
	private SHA256Enc enc;
	
	@Pointcut(value="execution(* kr.or.member.service..*Service.*Pw(kr.or.member.vo.Member))")
	public void encPointcut() {}
	//암호화에서 뺄라면 포인트 컷에서 걸러 주거나 기존에 만든 포인트 컷에서 안걸리게 빼주거나해줘야한다
	//멤버서비스중 매개변수가 Member 타입인거.
	//before처리
	@Before(value="encPointcut()")
	public void encPassword(JoinPoint jp) throws Exception{
		String methodName = jp.getSignature().getName();
		Object[] args = jp.getArgs();
		Member m = (Member)args[0];
		String inputPass = m.getMemberPassword();
		String encPass = enc.encData(inputPass);
		m.setMemberPassword(encPass);
		System.out.println("메소드명 :" + methodName);
		System.out.println("암호화 전 비밀번호 :" +inputPass);
		System.out.println("암호화 비밀번호 :" +encPass);
	}
//	@Pointcut(value="execution(* kr.or.member.service..*Service.changePw(..))")
//	public void changePwPointcut() {}
//	@Before(value="changePwPointcut()")
//	public void changePw(JoinPoint jp) throws Exception{
//		Object[] args = jp.getArgs();
//		PwChangeVo pc = (PwChangeVo)args[0];
//		String oldPw = pc.getOldPassword();
//		String newPw = pc.getNewPassword();
//		pc.setOldPassword(enc.encData(oldPw));
//		pc.setNewPassword(enc.encData(newPw));
//	}
}