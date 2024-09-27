package com.semiprj.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageVO {

	private int pageNum;
	private int cpp;

	// 검색 요청에 필요한 필드를 추가.
	private String keyword;
	private String condition;
	private String loginId;

	public PageVO() {
		this.pageNum = 1;
		this.cpp = 10;
	}
	
	
	
	
	//댓글에 쓸것임
	public int getPageStart() { // 현재 페이지의 시작 인덱스를 계산
		return (pageNum - 1) * cpp;
	}

	/*
	 * pageNum은 현재 페이지 번호를 나타내고, cpp는 페이지당 항목 수를 나타냄. 이 메서드는 현재 페이지의 첫 번째 항목이 시작하는
	 * 인덱스를 계산하여 반환하는데 페이지 번호가 1부터 시작하므로 (pageNum - 1)을 해주고, 그에 따른 항목 수를 곱해 시작 인덱스를
	 * 계산함.
	 * 
	 * 
	 * 사용자가 현재 페이지를 3페이지로 선택하고, 한 페이지 당 10개의 글을 보여주기로 설정했다고 가정한다면, (cpp = 10)
	 * pageNum이 3이므로, (3 - 1) * 10을 계산합니다. 결과적으로 20이 반환됩니다.
	 */
	
	
	
	//게시글에 쓸것임
	public int getStartRow() { // 페이지네이션에서 시작하는 행 번호를 계산
		return (pageNum - 1) * cpp;
	}
	/*
	 * 
	 * pageNum이 3이라면, (3 - 1) * 10을 계산합니다. 결과적으로 20이 반환됩니다.
	 * 
	 * 페이지네이션에서 시작하는 행 번호를 계산하는 메서드 현재 페이지의 시작하는 행 번호를 계산하여 리턴함.
	 */
	
	
	//게시글에 쓸것임
	public int getEndRow() { // 페이지네이션에서 끝나는 행 번호를 계산하는 메서드
		return pageNum * cpp;
	}

	/*
      사용자가 현재 페이지를 3페이지로 선택하고, 한 페이지 당 10개의 글을 보여주기로 설정했다고 가정한다면 (cpp = 10)
	  pageNum이 3이므로, 3 * 10을 계산합니다. 결과적으로 30이 반환됩니다.
	  	   
	  현재 페이지의 마지막 행 번호를 계산하여 반환하는데, pageNum은 현재 페이지 번호를 나타내고, cpp는 페이지당 항목 수를 나타내는데
	  현재 페이지의 마지막 항목이 끝나는 행 번호를 계산하기 위해 pageNum * cpp를 계산하여 리턴함
	 */

	
	
	
	
	// 겟셋
	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getCpp() {
		return cpp;
	}

	public void setCpp(int cpp) {
		this.cpp = cpp;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

}