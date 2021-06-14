package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.AuthMapper;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberSerivcempl implements MemberService {
	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	@Setter(onMethod_=@Autowired)
	private AuthMapper authmapper;

	@Override
	public void Signup(MemberVO member) {
		// TODO Auto-generated method stub
		log.info("sign up"+member);
		mapper.insert(member);
	}

	@Override
	public void insertauth(AuthVO auth) {
		// TODO Auto-generated method stub
		log.info("auth: "+auth);
		authmapper.insertauth(auth);
	}

	@Override
	public void update1(MemberVO member) {
		// TODO Auto-generated method stub
		log.info("update"+member);
		mapper.update(member);
		
	}

	@Override
	public void delete1(MemberVO member) {
		// TODO Auto-generated method stub
		log.info("delete"+member);
		mapper.delete(member);
	}
	
}
