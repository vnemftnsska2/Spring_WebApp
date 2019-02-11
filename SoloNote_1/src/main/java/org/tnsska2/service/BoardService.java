package org.tnsska2.service;

import java.util.List;

import org.tnsska2.domain.BoardVO;
import org.tnsska2.domain.Criteria;
import org.tnsska2.domain.SearchCriteria;

public interface BoardService {

	public void regist(BoardVO board)throws Exception;
	
	public BoardVO read(Integer bno)throws Exception;
	
	public void modify(BoardVO board)throws Exception;
	
	public void remove(Integer bno)throws Exception;
	
	public List<BoardVO> listAll()throws Exception;
	
	public List<BoardVO> listCriteria(Criteria cri)throws Exception;
	
	public int listCountCriteria(Criteria cri)throws Exception;
	
	public List<BoardVO> listSearchCriteria(SearchCriteria cri)throws Exception;
	
	public int listSearchCount(SearchCriteria cri)throws Exception;
	
	public List<String> getAttach(Integer bno)throws Exception;
	
}
