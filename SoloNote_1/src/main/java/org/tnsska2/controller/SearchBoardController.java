package org.tnsska2.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.tnsska2.domain.BoardVO;
import org.tnsska2.domain.PageMaker;
import org.tnsska2.domain.SearchCriteria;
import org.tnsska2.service.BoardService;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {

	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	@Inject
	private BoardService service;
	
	// 게시글 리스트 출력
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void listPage(@ModelAttribute("cri")SearchCriteria cri,
			Model model) throws Exception {
		
		logger.info(cri.toString());
		
		// model.addAttribute("list", service.listCriteria(cri));
		model.addAttribute("list", service.listSearchCriteria(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);	// 현재 페이지에 보여지는 게시글 개수
		//pageMaker.setTotalCount(service.listCountCriteria(cri));	// 게시글 총 개수
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		
		model.addAttribute("pageMaker", pageMaker);
	}
	
	// 게시글 등록 페이지 이동
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET()throws Exception{
		logger.info("register get........");
	}
	
	// 게시글 등록 완료
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BoardVO board, RedirectAttributes rttr)throws Exception{
		
		logger.info("register post......");
		logger.info(board.toString());
		
		service.regist(board);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		/*return "/board/success";*/
		return "redirect:/sboard/list";		  
	}
	
	// 게시글 조회
	@RequestMapping(value="/readPage", method=RequestMethod.GET)
	public void read(@RequestParam("bno")int bno,
			@ModelAttribute("cri") SearchCriteria cri,
			Model model)throws Exception{
		
		model.addAttribute(service.read(bno));
	}
	
	// 게시글 삭제
	@RequestMapping(value="/removePage", method=RequestMethod.POST)
	public String remove(@RequestParam("bno")int bno,
			SearchCriteria cri,
			RedirectAttributes rttr)throws Exception{
		
		service.remove(bno);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/sboard/list";
	}
	
	// 게시글 수정 페이지 이동
	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
	public void modifyPagingGET(int bno, 
			@ModelAttribute("cri") SearchCriteria cri
			,Model model)throws Exception{
		
		model.addAttribute(service.read(bno));
	}
	
	// 게시글 수정 완료
	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
	public String modifyPagingPOST(BoardVO board
			, SearchCriteria cri
			, RedirectAttributes rttr)throws Exception{
		
		logger.info(cri.toString());
		service.modify(board);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		logger.info(rttr.toString());
		
		return "redirect:/sboard/list";
	}
}
