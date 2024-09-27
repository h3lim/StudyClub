package com.semiprj.mapper;

import java.util.List;

import com.semiprj.model.FreeBoardVO;
import com.semiprj.util.PageVO;

//interface 2
public interface FreeBoardMapper {

	// 글 등록
	void regist(FreeBoardVO vo);

	// 글 목록
	List<FreeBoardVO> getList(PageVO vo);

	int getTotal(PageVO vo); // 게시글의 총 개수 조회 -> 페이징 처리할 때 전체 게시글 수로 반환.

	// 상세보기
	FreeBoardVO getContent(int bno);

	void update(FreeBoardVO vo);

	// 삭제
	void delete(int bno);

}
