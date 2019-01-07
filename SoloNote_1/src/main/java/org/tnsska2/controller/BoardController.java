package org.tnsska2.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.tnsska2.domain.BoardVO;
import org.tnsska2.domain.Criteria;
import org.tnsska2.domain.PageMaker;
import org.tnsska2.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(BoardVO board, Model model)throws Exception{
		logger.info("register get........");
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BoardVO board, RedirectAttributes rttr)throws Exception{
		
		logger.info("register post......");
		logger.info(board.toString());
		
		service.regist(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		/*return "/board/success";*/
		return "redirect:/board/listAll";		  
	}
	
	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void listAll(Model model, Criteria cri)throws Exception{
		
		logger.info("show list Page with Criteria.............");
		model.addAttribute("list", service.listCriteria(cri));
	}
	
	@RequestMapping(value = "/read", method=RequestMethod.GET)
	public void read(@RequestParam("bno")int bno, Model model)throws Exception{
		
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value = "/remove", method=RequestMethod.POST)
	public String remove(@RequestParam("bno")int bno, RedirectAttributes rttr)throws Exception{
	
		service.remove(bno);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyGET(int bno, Model model)throws Exception{
		
		model.addAttribute(service.read(bno));
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BoardVO board, RedirectAttributes rttr)throws Exception{
		
		logger.info("modify post..............");
		
		service.modify(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/listAll";
	}
	
	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void listPage(Criteria cri, Model model)throws Exception{
		
		logger.info(cri.toString());
		
		model.addAttribute("list", service.listCriteria(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(131);
		
		model.addAttribute("pageMaker", pageMaker);
	}
}
