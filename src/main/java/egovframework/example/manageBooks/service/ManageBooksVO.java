package egovframework.example.manageBooks.service;

public class ManageBooksVO {

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
	private String author;
	private String publisher;
	private String publishDate;
	private String classification;
	private String content;
	private String imgDes;
	private String bookPage;
	private String rentCnt;
	
	/*
	 * 아래 필드는 책의 자세한 사항을 저장하는 것인데
	 * 처음에 책 추가하면 반드시 추가하게 끔 하기위해 여기 VO에 포함시킨다. 
	 */
	private String callNumber;
	private String state;
	private String returnTerm;
	private String bookId;
	
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
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImgDes() {
		return imgDes;
	}
	public void setImgDes(String imgDes) {
		this.imgDes = imgDes;
	}
	public String getBookPage() {
		return bookPage;
	}
	public void setBookPage(String bookPage) {
		this.bookPage = bookPage;
	}
	public String getCallNumber() {
		return callNumber;
	}
	public void setCallNumber(String callNumber) {
		this.callNumber = callNumber;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getReturnTerm() {
		return returnTerm;
	}
	public void setReturnTerm(String returnTerm) {
		this.returnTerm = returnTerm;
	
	}
	public String getBookId() {
		return bookId;
	}
	public void setBookId(String bookId) {
		this.bookId = bookId;
	}
	public String getRentCnt() {
		return rentCnt;
	}
	public void setRentCnt(String rentCnt) {
		this.rentCnt = rentCnt;
	}
	
}