package org.tnsska2.persistence;

import java.util.Date;

import org.tnsska2.domain.UserVO;
import org.tnsska2.dto.LoginDTO;

public interface UserDAO {

	public UserVO login(LoginDTO dto)throws Exception;
	
	public void keepLogin(String uid, String sessionId, Date next);
	
	public UserVO checkUserWithSessionKey(String value);
	
}
