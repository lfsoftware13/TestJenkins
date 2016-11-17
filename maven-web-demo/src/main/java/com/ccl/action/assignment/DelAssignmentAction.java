/**
 * 
 */
package com.ccl.action.assignment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ccl.action.BaseAction;
import com.ccl.service.AssignmentService;

/**
 *
 * @author 霄汉
 * @since 2016年3月20日 上午8:51:59
 * @version 1.0
 */
@Controller
public class DelAssignmentAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4428296136922971026L;

	@Autowired
	private AssignmentService service;
	
	private String result;
	
	private int cid;
	
	private int aid;
	
	public String execute() {
		int assignmentid = Integer.parseInt(request.getParameter("assignmentid"));
		service.delAssignment(assignmentid);
		setResult("success");
		return SUCCESS;
	}
	
	public String removeAssignmentFromProject(){
		if(cid<=0){
			setResult("fail_project_null");
			return SUCCESS;
		}
		if(aid<=0){
			setResult("success");
			return SUCCESS;
		}
		boolean flag=service.removeAssignment(cid, aid);
		if(flag){
			setResult("success");
		}else{
			setResult("fail");
		}
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

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

}
