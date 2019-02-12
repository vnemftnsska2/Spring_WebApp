package org.tnsska2.service;

import java.util.Date;

import org.tnsska2.domain.UserVO;
import org.tnsska2.dto.LoginDTO;

public interface UserService {

	public UserVO login(LoginDTO dto)throws Exception;
	
	public void keepLogin(String uid, String sessionId, Date next)throws Exception;
	
	public UserVO checkLoginBefore(String value);
}
