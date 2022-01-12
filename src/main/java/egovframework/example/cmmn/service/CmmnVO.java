package egovframework.example.cmmn.service;

public class CmmnVO {
	
	private long rows = 6;	// 한페이지에 보여질 row수
	
	private long page = 1; 	// 현재 보여질 페이지 수
	
	private long totalPage; 	// 총페이지 수		
	
	private long startPage = 1; 		// 시작 페이지 수 ( 4 5 6 부터 시작하면 4가 시작페이지 수)
	
	private long endPage;
	
	private long pageScale=3;	// 한 화면에 보여질 페이지수 
	
	
	public long getRows() {
		return rows;
	}
	
	public void setRows(long rows) {
		this.rows = rows;
	}
	
	public long getPage() {
		return page;
	}
	
	public void setPage(long page) {
		this.page = page;
	}
	
	public long getTotalPage() {
		return totalPage;
	}
	
	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}
	
	public long getStartPage() {
		return startPage;
	}
	
	public void setStartPage(long startPage) {
		this.startPage = startPage;
	}
	
	public long getEndPage() {
		return endPage;
	}
	
	public void setEndPage(long endPage) {
		this.endPage = endPage;
	}
	
	public long getPageScale() {
		return pageScale;
	}
	
	public void setPageScale(long pageScale) {
		this.pageScale = pageScale;
	}
	
}
