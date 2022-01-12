package egovframework.example.book.service;

import egovframework.example.cmmn.service.CmmnVO;

public class BookSearchPagingVO extends CmmnVO {
	private String type;
	private String keyword;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
}
