package com.semiprj.service;

import java.util.List;


import com.semiprj.model.FreeBoardVO;
import com.semiprj.util.PageVO;

public interface FreeBoardService {
	
	void regist(FreeBoardVO vo);

	// 글 목록
	List<FreeBoardVO> getList(PageVO vo);

	int getTotal(PageVO vo);

	FreeBoardVO getContent(int bno);

	// 수정
	void update(FreeBoardVO vo); 

	// 삭제
	void delete(int bno);

}
