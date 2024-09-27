package com.semiprj.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.semiprj.model.ReplyVO;
import com.semiprj.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/reply")
@Slf4j
public class ReplyController {

	@Autowired
	private ReplyService service;

	// 댓글 등록
	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String replyRegist(@RequestBody ReplyVO vo) {
		service.replyRegist(vo);
		System.out.println("댓글 등록은 완료 되었습니다.");
		return "regSuccess";
	}

	// 목록 요청(페이징 포함)
	@RequestMapping(value = "/getList/{bno}/{pageNum}", method = RequestMethod.GET)
	public Map<String, Object> getList(@PathVariable int bno, @PathVariable int pageNum) {

		List<ReplyVO> list = service.getList(bno, pageNum);
		int total = service.getTotal(bno);

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);

		System.out.println("제발 돌아가라;");

		return map;
	}

	// 댓글 수정 요청
	@RequestMapping(value = "/{rno}", method = RequestMethod.PUT)
	public String update(@PathVariable int rno, @RequestBody ReplyVO vo) {
		vo.setRno(rno);
		if (service.pwCheck(vo)) {
			service.update(vo);
			return "updateSuccess";
		} else {
			return "pwFail";
		}
	}

	@RequestMapping(value = "/{rno}", method = RequestMethod.DELETE)
	public String delete(@PathVariable int rno, @RequestBody ReplyVO vo) {
		vo.setRno(rno);
		if (service.pwCheck(vo)) {
			service.delete(rno);
			return "delSuccess";
		} else {
			return "pwFail";
		}

	}

}