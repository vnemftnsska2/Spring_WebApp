package org.tnsska2.test;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.tnsska2.domain.BoardVO;
import org.tnsska2.domain.Criteria;
import org.tnsska2.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardDAOTest {

	@Inject
	private BoardDAO dao;
	
	private static Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Test
	public void testCreate()throws Exception{
		
		BoardVO board = new BoardVO();
		board.setTitle("제목 : 테스트");
		board.setContent("내용: 테스트");
		board.setWriter("테스터1");
		dao.create(board);
	}

	@Test
	public void testRead()throws Exception{
		
		logger.info(dao.read(10).toString());
	}
	
	@Test
	public void testUpdate()throws Exception{
		
		BoardVO board = new BoardVO();
		board.setBno(1);
		board.setTitle("제목 : 수정테스트");
		board.setContent("내용 : 수정테스트");
		dao.update(board);
	}
	
	@Test
	public void testDelete()throws Exception{
		
		dao.delete(1);
	}
	
	@Test
	public void testListPage()throws Exception{
		
		int page = 3;
		
		List<BoardVO> list = dao.listPage(page);
		
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
		}
	}
	
	@Test
	public void testListCriteria()throws Exception{
		
		Criteria cri = new Criteria();
		cri.setPage(2);
		cri.setPerPageNum(20);
		
		List<BoardVO> list = dao.listCriteria(cri);
		
		for(BoardVO boarVO : list) {
			logger.info(boarVO.getBno() + ":" + boarVO.getTitle());
		}
	}
}
