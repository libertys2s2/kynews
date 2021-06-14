package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*") //board로 시작하는데 뒤는 어떤 문자든 상관 없음
@Log4j
@AllArgsConstructor
public class BoardController {
	private BoardService service;

	@GetMapping("/list")
	public void list(Criteria cri,Model model) { //리스트 메서드 criteria라는 필통을 쓰겟다 선언
		log.info("list:"+ cri);
		model.addAttribute("list",service.getList(cri));   //값이 service로 이동 

		
		int total = service.getTotal(cri);
		log.info("total:"+ total);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
	}
	@GetMapping("/notice")
	public void list0(Criteria cri,Model model) { //리스트 메서드 criteria라는 필통을 쓰겟다 선언
		
		int category=0;
		cri.setCategory(category);
		log.info("list2:"+ cri);
		
		log.info(service.getList2(cri));
		
		model.addAttribute("list2",service.getList2(cri));   //값이 service로 이동 

		
		int total2 = service.getTotal2(cri);
		log.info("total2:"+ total2);
		model.addAttribute("pageMaker",new PageDTO(cri,total2));
	}
	
	
	
	
	
	
	
	@GetMapping("/covid")
	public void list2(Criteria cri,Model model) { //리스트 메서드 criteria라는 필통을 쓰겟다 선언
		
		int category=2;
		cri.setCategory(category);
		log.info("list2:"+ cri);
		
		log.info(service.getList2(cri));
		
		model.addAttribute("list2",service.getList2(cri));   //값이 service로 이동 

		
		int total2 = service.getTotal2(cri);
		log.info("total2:"+ total2);
		model.addAttribute("pageMaker",new PageDTO(cri,total2));
	}
	
	@GetMapping("/sports")
	public void list3(Criteria cri,Model model) { //리스트 메서드 criteria라는 필통을 쓰겟다 선언
		
		int category=3;
		cri.setCategory(category);
		log.info("list2:"+ cri);
		
		log.info(service.getList2(cri));
		
		model.addAttribute("list2",service.getList2(cri));   //값이 service로 이동 

		
		int total2 = service.getTotal2(cri);
		log.info("total2:"+ total2);
		model.addAttribute("pageMaker",new PageDTO(cri,total2));
	}
	
	@GetMapping("/economy")
	public void list4(Criteria cri,Model model) { //리스트 메서드 criteria라는 필통을 쓰겟다 선언
		
		int category=4;
		cri.setCategory(category);
		log.info("list2:"+ cri);
		
		log.info(service.getList2(cri));
		
		model.addAttribute("list2",service.getList2(cri));   //값이 service로 이동 

		
		int total2 = service.getTotal2(cri);
		log.info("total2:"+ total2);
		model.addAttribute("pageMaker",new PageDTO(cri,total2));
	}
	@GetMapping("/IT")
	public void list5(Criteria cri,Model model) { //리스트 메서드 criteria라는 필통을 쓰겟다 선언
		
		int category=5;
		cri.setCategory(category);
		log.info("list2:"+ cri);
		
		log.info(service.getList2(cri));
		
		model.addAttribute("list2",service.getList2(cri));   //값이 service로 이동 

		
		int total2 = service.getTotal2(cri);
		log.info("total2:"+ total2);
		model.addAttribute("pageMaker",new PageDTO(cri,total2));
	}
	
	
	
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()") //로그인 안했을때 
	public void register() {};
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("==========================");
		log.info("register:"+ board);
		if(board.getAttachList() !=null) {
			board.getAttachList().forEach(attach-> log.info(attach));
		}
		log.info("=========================");
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
		
	}
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify:"+ board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}

		
		return "redirect:/board/list" + cri.getListLink();
	}
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,/*@ModelAttribute("cri")*/ Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("remove..."+bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {
			//delete  Attach files
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list" + cri.getListLink(); //위를 줄이면 이와같이 됨
	}

	@GetMapping(value="/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>>getAttachList(Long bno){
		log.info("getAttachList" + bno);
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files.........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
			}catch(Exception e) {
				log.error("delete file error"+e.getMessage());
			}
		});
	}

}
