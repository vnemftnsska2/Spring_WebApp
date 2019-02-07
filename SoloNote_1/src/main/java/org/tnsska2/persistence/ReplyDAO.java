package org.tnsska2.persistence;

import java.util.List;

import org.tnsska2.domain.Criteria;
import org.tnsska2.domain.ReplyVO;

public interface ReplyDAO {

	// 댓글 리스트
	public List<ReplyVO> list(Integer bno) throws Exception;
	
	// 댓글 등록
	public void create(ReplyVO vo) throws Exception;
	
	// 댓글 수정
	public void update(ReplyVO vo) throws Exception;
	
	// 댓글 삭제
	public void delete(Integer rno) throws Exception;
	
	// 페이징 처리
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception;
	
	// 해당 게시물의 댓글 갯수
	public int count(Integer bno) throws Exception;
}
