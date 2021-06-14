package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;




@Log4j
@Service //서비스라는걸 선언? 해주는것
public class BoardServicempl implements BoardService {
	
	//spring 4.3 이상에서 자동처리 
	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register....." +board);
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		board.getAttachList().forEach(attach ->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		log.info("get....." +bno);
		return mapper.read(bno);
	}
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		log.info("modify......"+board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board) ==1;
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() >0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		//return mapper.update(board) == 1;
		return modifyResult;  // 주기적으로  파일과 데이터 베이스를 비교하는 방법을 활용 
	}
	@Transactional
	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		log.info("remove ..... " +bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {    //메서드 이름은 같지만 매개변수가 다른것 overriding
		// TODO Auto-generated method stub
		log.info("getList......");
		return mapper.getList();
	}

	@Override
	public List<BoardVO> getList(Criteria cri){ //메인게시판
		log.info("get List with criteria:" +cri);
		return mapper.getListWithPaging(cri);
	}
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
		
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		// TODO Auto-generated method stub
		log.info("get Attach list by bno" + bno);
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<BoardVO> getList2() {    //메서드 이름은 같지만 매개변수가 다른것 overriding
		// TODO Auto-generated method stub
		log.info("getList......");
		return mapper.getList2();
	}
	@Override
	public List<BoardVO> getList2(Criteria cri) {
		log.info("get List with criteria2:" +cri);
		return mapper.getListWithPaging2(cri);
	}

	@Override
	public int getTotal2(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("get total count");
		return mapper.getTotalCount2(cri);
	}

	@Override
	public List<BoardVO> getList3(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("get List with criteria3:" +cri);
		return mapper.getListWithPaging2(cri);
	}
	@Override
	public List<BoardVO> getList4(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("get List with criteria4:" +cri);
		return mapper.getListWithPaging2(cri);
	}

	@Override
	public List<BoardVO> getList5(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("get List with criteria5:" +cri);
		return mapper.getListWithPaging2(cri);
	}

	@Override
	public List<BoardVO> getList0(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("get List with criteria0:" +cri);
		return mapper.getListWithPaging2(cri);
	}

	
	
	
/* AllArgsConstructor을 지우고
 * 
 * public class BoardServicempl implements BoardService{
 * 
 * @Setter(onMethod_ = @Autowired)
 * private BoardMapper mapper;
 * 
 * 
 *}로 쓸수 있음
 * */
}



