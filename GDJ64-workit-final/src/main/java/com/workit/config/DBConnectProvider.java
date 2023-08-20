package com.workit.config;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AccountStatusUserDetailsChecker;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsChecker;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import com.workit.member.model.dao.MemberDao;
import com.workit.member.model.vo.MemberVO;

@Component
public class DBConnectProvider implements AuthenticationProvider{
	@Autowired
	private MemberDao dao;
	@Bean
	public BCryptPasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException{
		String memberId=authentication.getName();
		String password=(String)authentication.getCredentials();
		MemberVO loginMember=dao.selectMemberByParam(Map.of("memberId",memberId));
		if(loginMember==null||!encoder().matches(password, loginMember.getPassword())) { //로그인 실패 시
			throw new BadCredentialsException("인증 실패했습니다.");
		}else {
			if(loginMember.isCredentialsNonExpired()) { //입,퇴사일에 따라 로그인 실패
				return new UsernamePasswordAuthenticationToken(loginMember,password, loginMember.getAuthorities()); //인증된 객체							
			}else {
				throw new BadCredentialsException("인증 실패했습니다.");
			}
		}
	}

	@Override
	public boolean supports(Class<?> authentication) { //토큰 타입과 일치하면 인증
		return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}
}
