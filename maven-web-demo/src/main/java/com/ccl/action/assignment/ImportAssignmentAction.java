package com.ccl.action.assignment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ccl.action.BaseAction;
import com.ccl.service.AssignmentService;
import com.ccl.service.NoticeService;

@Controller
public class ImportAssignmentAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5727284675944260297L;
	@Autowired
	private AssignmentService service;
	@Autowired
	private NoticeService noticeService;
	
	private String result;
	
	private List<Integer> alist;
	
	private int cid;
	
	public String execute() {
		
			
		int cid = Integer.parseInt(request.getParameter("cid"));
		int assignmentid = Integer.parseInt(request.getParameter("assignmentid"));
		
		service.importAssignment(cid, assignmentid);
		setResult("success");
		noticeService.sendAssignmentNotice(cid);

		return SUCCESS;

	}
	
	public String importSomeAssignment(){
		
		if(cid<=0){
			setResult("fail_project_null");
			return SUCCESS;
		}
		if(alist==null){
			setResult("success");
			return SUCCESS;
		}
		
		for(int i=0;i<alist.size();i++){
			service.importAssignment(cid, alist.get(i));
		}
		
		setResult("success");
		return SUCCESS;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public AssignmentService getService() {
		return service;
	}

	public void setService(AssignmentService service) {
		this.service = service;
	}

	public NoticeService getNoticeService() {
		return noticeService;
	}

	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	public List<Integer> getAlist() {
		return alist;
	}

	public void setAlist(List<Integer> alist) {
		this.alist = alist;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

}
