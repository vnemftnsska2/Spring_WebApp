package org.tnsska2.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.tnsska2.domain.Criteria;
import org.tnsska2.domain.PageMaker;
import org.tnsska2.domain.ReplyVO;
import org.tnsska2.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	@Inject
	private ReplyService service;

	// 댓글 등록 컨트롤러
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO vo) {
		System.out.println("컨트롤러 접속 확인 : 댓글 등록");
		ResponseEntity<String> entity = null;
		try {
			service.addReply(vo);
			System.out.println("컨트롤러 접속 확인 : 성공");
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("컨트롤러 접속 확인 : 실패");
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 리스트 출력
	@RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") Integer bno) {

		ResponseEntity<List<ReplyVO>> entity = null;
		try {
			entity = new ResponseEntity<>(service.listReply(bno), HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 수정 컨트롤러
	@RequestMapping(value = "/{rno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> update(@PathVariable("rno") Integer rno, @RequestBody ReplyVO vo) {

		ResponseEntity<String> entity = null;
		try {
			vo.setRno(rno); // rno를 PathVariable 어노테이션을 통해 받아온 값으로 바꿔준 후
			service.modifyReply(vo);

			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 삭제 컨트롤러
	@RequestMapping(value = "/{rno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("rno") Integer rno) {

		ResponseEntity<String> entity = null;

		try {

			service.removeReply(rno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 페이징 처리 컨트롤러
	@RequestMapping(value = "/{bno}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bno") Integer bno,
			@PathVariable("page") Integer page) {

		ResponseEntity<Map<String, Object>> entity = null;

		try {
			
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<ReplyVO> list = service.listReplyPage(bno, cri);
			
			map.put("list", list);
			
			int replyCount = service.count(bno);
			pageMaker.setTotalCount(replyCount);
			
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			
		} catch (Exception e) {

			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

}
