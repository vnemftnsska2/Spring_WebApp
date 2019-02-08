package org.tnsska2.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAOImpl implements PointDAO{

	@Inject
	private SqlSession session;
	
	private String namespace = "org.tnsska2.mapper.PointMapper";
	
	@Override
	public void updatePoint(String uid, int point) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uid", uid);
		paramMap.put("point", point);
		
		session.update(namespace + ".updatePoint", paramMap);
	}

	
}
