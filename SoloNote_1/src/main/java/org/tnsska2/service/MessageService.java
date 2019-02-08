package org.tnsska2.service;

import org.tnsska2.domain.MessageVO;

public interface MessageService {

	public void addMessage(MessageVO vo) throws Exception;
	
	public MessageVO readMessage(String uid, Integer mid) throws Exception;
	
}
