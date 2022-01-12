package egovframework.example.manageMenu.service;

public class ManageMenuVO {

	private static final long serialVersionUID = 1L;

	private String rows; //필드
	
	private String page; 
	
	private String totalTotCnt;
	
	private String totalPage;
	
	private String serviceImplYn;
	
	private String param1;
	private String param;
	
	private String menuId;
	private String menuNm;
	private String menuUrl;
	private String menuClass;
	private String useYn;
	private String sortNo;
	private String innerLinkYn;
	
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
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	public String getMenuClass() {
		return menuClass;
	}
	public void setMenuClass(String menuClass) {
		this.menuClass = menuClass;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getSortNo() {
		return sortNo;
	}
	public void setSortNo(String sortNo) {
		this.sortNo = sortNo;
	}
	public String getInnerLinkYn() {
		return innerLinkYn;
	}
	public void setInnerLinkYn(String innerLinkYn) {
		this.innerLinkYn = innerLinkYn;
	
	}
}