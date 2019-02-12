package org.tnsska2.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.tnsska2.domain.BoardVO;
import org.tnsska2.domain.Criteria;
import org.tnsska2.domain.SearchCriteria;
import org.tnsska2.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	@Transactional
	@Override
	public void regist(BoardVO board) throws Exception {
		dao.create(board);
		
		String[] files = board.getFiles();
		
		if(files == null) {
			return;
		}
		
		for(String fileName : files) {
			dao.addAttach(fileName);
		}
		
	}
	
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(Integer bno) throws Exception {
		dao.updateViewCnt(bno);
		return dao.read(bno);
	}

	@Transactional
	@Override
	public void modify(BoardVO board) throws Exception {
		
		dao.update(board);
		
		// 현재 접속된 게시물 번호를 가져온다.
		Integer bno = board.getBno();
		
		// 게시물 번호의 첨부파일을 삭제해준다.
		dao.deleteAttach(bno);
		
		// 파일 이름을 담을 files 객체를 가져온다.
		String[] files = board.getFiles();
		
		if(files == null) {
			return ;
		}
		
		for(String fileName : files) {
			dao.replaceAttach(fileName, bno);
		}
		
	}

	@Transactional
	@Override
	public void remove(Integer bno) throws Exception {
		dao.deleteAttach(bno);
		dao.delete(bno);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {

		return dao.listCriteria(cri);
	}
	
	// 10페이지 씩 끊어서 보여주도록 구현
	@Override
	public int listCountCriteria(Criteria cri) throws Exception {

		return dao.countPaging(cri);
	}

	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {

		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {

		return dao.listSearchCount(cri);
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {

		return dao.getAttach(bno);
	}

}
