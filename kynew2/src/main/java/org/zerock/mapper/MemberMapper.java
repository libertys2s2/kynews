package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);
	public void insert(MemberVO vo);
	public void update(MemberVO vo);
	public void delete(MemberVO vo);
	

}
