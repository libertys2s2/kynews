package org.zerock.service;

import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;

public interface MemberService {
	
	public void Signup(MemberVO member);
	public void update1(MemberVO member);
	public void delete1(MemberVO member);
	public void insertauth(AuthVO auth);
}
