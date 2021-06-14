package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	//@Select("select * from tbl_board where bno >0")  메인페이지
	public List<BoardVO> getList();
	public List<BoardVO> getListWithPaging(Criteria cri); // xml에 있는 id 와 일치시켜주면 연결이됨
	public int getTotalCount(Criteria cri);
	
	
	public void insert(BoardVO board);
	public void insertSelectKey(BoardVO board);
	public BoardVO read(Long bno);
	public int delete(Long bno);
	public int update(BoardVO board);

	public List<BoardVO> getList0();//공지사항
	
	//코로나 페이지
	public int getTotalCount2(Criteria cri);
	public List<BoardVO> getListWithPaging2(Criteria cri); // xml에 있는 id 와 일치시켜주면 연결이됨 
	public List<BoardVO> getList2(); //코로롱
	

	
	public List<BoardVO> getList3(); //스포츠
	public List<BoardVO> getList4();// 경제 
	public List<BoardVO> getList5();//IT
	
	
	public void updateReplyCnt(@Param("bno")Long bno,@Param("amount") int amount);
	
}
