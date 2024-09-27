package com.semiprj.mapper;

import java.util.List;
import java.util.Map;

import com.semiprj.model.ReplyVO;

public interface ReplyMapper {

	void replyRegist(ReplyVO vo);

	List<ReplyVO> getList(Map<String, Object> data);

	int getTotal(int bno);

	String pwCheck(int rno); 

	// 댓글 수정
	void update(ReplyVO vo);

	// 댓글 삭제
	void delete(int rno); 

}
