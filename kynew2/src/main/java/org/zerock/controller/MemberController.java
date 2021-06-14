 package org.zerock.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	private static Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	@GetMapping("/signup")
	public String signup() {
		log.info("signup");
		return "signup";
	}
	
	@RequestMapping(value ="/signup",method = RequestMethod.POST)
	public String signup(@ModelAttribute MemberVO vo,AuthVO authvo) {
		
		
		String inputPass = vo.getUserpw();
		String pwd = pwdEncoder.encode(inputPass);
		String userid =vo.getUserid();
		vo.setUserpw(pwd);
		authvo.setUserid(userid);
		authvo.setAuth("ROLE_MEMBER");
		service.Signup(vo);
		service.insertauth(authvo);
		log.info(vo);
		log.info(authvo);
		return "redirect:/board/list";
		
	}

	@GetMapping("/memberch")
	public String memberch() {
		log.info("memberchange");
		return "memberch";
	}
	@RequestMapping(value="/update",method=RequestMethod.POST )
	public String update(MemberVO vo, AuthVO authvo, Model model,HttpSession session  ) {
		String inputPass = vo.getUserpw();
		String pwd = pwdEncoder.encode(inputPass);
		String userid =vo.getUserid();
		vo.setUserpw(pwd);
		authvo.setUserid(userid);
		authvo.setAuth("ROLE_MEMBER");
		log.info("update");
		service.update1(vo);
		service.insertauth(authvo);
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String delete(MemberVO vo,Model model, HttpSession session) {
		log.info("delete");
		service.delete1(vo);
		session.invalidate();
		return "redirect:/";
	}
}
