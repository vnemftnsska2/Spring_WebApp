package org.tnsska2.persistence;

import java.util.List;

import org.tnsska2.domain.BoardVO;
import org.tnsska2.domain.Criteria;

public interface BoardDAO {

	public void create(BoardVO vo)throws Exception;
	
	public BoardVO read(Integer bno)throws Exception;
	
	public void update(BoardVO vo)throws Exception;
	
	public void delete(Integer bno)throws Exception;
	
	public List<BoardVO> listAll()throws Exception;

	public List<BoardVO> listPage(int page)throws Exception;

	public List<BoardVO> listCriteria(Criteria cri)throws Exception;
	
}
