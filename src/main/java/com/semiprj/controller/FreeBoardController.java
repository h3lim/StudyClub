package com.semiprj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.semiprj.model.FreeBoardVO;
import com.semiprj.service.FreeBoardService;
import com.semiprj.util.PageCreator;
import com.semiprj.util.PageVO;

import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/freeboard")
@Slf4j
public class FreeBoardController {

	@Autowired
	private FreeBoardService service;

	// 목록 화면 짜보자
	@RequestMapping(value = "/freeList", method = RequestMethod.GET)
	public void freeList(PageVO vo, Model model) {
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		System.out.println(pc);
	    List<FreeBoardVO> boardList = service.getList(vo);

		model.addAttribute("boardList", service.getList(vo));
		model.addAttribute("pc", pc);

	}
	 // 글쓰기 페이지
    @RequestMapping(value = "/freeRegist", method = RequestMethod.GET)
    public String regist() {
        System.out.println("글 등록을 요청합니다. 삐빅");
        return "freeboard/freeRegist";
    }

    // 글 등록 처리
    @RequestMapping(value = "/freeRegist", method = RequestMethod.POST)
    public String regist(FreeBoardVO vo) {
        service.regist(vo);
        System.out.println(vo.getBno());
        System.out.println(vo.getContent());
        System.out.println(vo.getWriter());
        System.out.println(vo.getTitle());
        return "redirect:/freeboard/freeList";
    }

	
	
	@RequestMapping(value = "/content/{bno}", method = RequestMethod.GET)
	public String getContent(@PathVariable int bno, @ModelAttribute("p") PageVO vo, Model model) {
		model.addAttribute("article", service.getContent(bno));
		return "freeboard/freeDetail";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(@ModelAttribute("article") FreeBoardVO vo) { 
		return "freeboard/freeModify";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(FreeBoardVO vo) { 
		service.update(vo);
		return "redirect:/freeboard/content/" + vo.getBno(); 
	}

	@RequestMapping(value = "content/delete", method = RequestMethod.POST)
	public String delete(@RequestParam("bno") int bno) {
		service.delete(bno);
		return "redirect:/freeboard/freeList";
	}

}
