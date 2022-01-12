package egovframework.example.manageLibroInformation.service;

public class ManageLibroInformationVO {

	private static final long serialVersionUID = 1L;

	private String rows; //필드
	
	private String page; 
	
	private String totalTotCnt;
	
	private String totalPage;
	
	private String serviceImplYn;
	
	private String param1;
	private String param;
	
	private String id;
	private String title;
	private String content;
	private String explantion;
	
	public String getRows() {
		return rows;
	}
	public void setRows(String rows) {
		this.rows = rows;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getTotalTotCnt() {
		return totalTotCnt;
	}
	public void setTotalTotCnt(String totalTotCnt) {
		this.totalTotCnt = totalTotCnt;
	}
	public String getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(String totalPage) {
		this.totalPage = totalPage;
	}
	public String getServiceImplYn() {
		return serviceImplYn;
	}
	public void setServiceImplYn(String serviceImplYn) {
		this.serviceImplYn = serviceImplYn;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getExplantion() {
		return explantion;
	}
	public void setExplantion(String explantion) {
		this.explantion = explantion;
	}
	
}