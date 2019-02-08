package org.tnsska2.persistence;

import org.tnsska2.domain.MessageVO;

public interface MessageDAO {

	// 메세지 등록
	public void create(MessageVO vo) throws Exception;
	
	// 메세지 읽기
	public MessageVO readMessage(Integer mid) throws Exception;
	
	// 메세지 수정, 업데이트
	public void updateState(Integer mid) throws Exception;
	
}
