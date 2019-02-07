package org.tnsska2.service;

import java.util.List;

import org.tnsska2.domain.Criteria;
import org.tnsska2.domain.ReplyVO;

public interface ReplyService {

	// 댓글 추가
	public void addReply(ReplyVO vo) throws Exception;
	
	// 댓글 리스트 출력
	public List<ReplyVO> listReply(Integer bno) throws Exception;
	
	// 댓글 수정
	public void modifyReply(ReplyVO vo) throws Exception;
	
	// 댓글 삭제
	public void removeReply(Integer rno) throws Exception;
	
	// 페이징 처리를 위한 추가 작업
	public List<ReplyVO> listReplyPage(Integer bno, Criteria cri) throws Exception;
	
	// 카운트
	public int count(Integer bno) throws Exception;
	
}
