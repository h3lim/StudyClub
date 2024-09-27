package com.semiprj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.semiprj.model.ReplyVO;
import com.semiprj.mapper.ReplyMapper;
import com.semiprj.util.PageVO;


@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper mapper;

	@Override
	public void replyRegist(ReplyVO vo) {
		vo.setReplyPw(vo.getReplyPw());
		mapper.replyRegist(vo);
	}

	@Override
	public List<ReplyVO> getList(int bno, int pageNum) {

		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCpp(5);

		Map<String, Object> data = new HashMap<>();
		data.put("paging", vo);
		data.put("bno", bno);

		return mapper.getList(data);

	}

	@Override
	public int getTotal(int bno) {
		return mapper.getTotal(bno);
	}

	@Override
	public boolean pwCheck(ReplyVO vo) {
	    String dbPw = mapper.pwCheck(vo.getRno()); // 데이터베이스에서 가져온 암호화되지 않은 비밀번호

	    // 입력한 비밀번호(vo.getReplyPw())와 데이터베이스에서 가져온 비밀번호(dbPw)를 평문으로 비교
	    return vo.getReplyPw().equals(dbPw);
	}


	@Override
	public void update(ReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int rno) {
		mapper.delete(rno);

	}

}
