package com.semiprj.service;

import java.util.List;


import com.semiprj.model.ReplyVO;

public interface ReplyService {

	// 댓글 등록
	void replyRegist(ReplyVO vo);

	// 목록 요청
	List<ReplyVO> getList(int bno, int pageNum);

	// 댓글 개수
	int getTotal(int bno);

	// 비밀번호 확인
	boolean pwCheck(ReplyVO vo);

	// 댓글 수정
	void update(ReplyVO vo);

	// 댓글 삭제
	void delete(int rno);

}
