/**
 * 
 */
package com.ccl.action.assignment;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ccl.Utility;
import com.ccl.action.BaseAction;
import com.ccl.model.Assignment;
import com.ccl.service.AssignmentService;
import com.ccl.service.NoticeService;

/**
 *
 * @author 霄汉
 * @since 2016年3月20日 上午8:53:31
 * @version 1.0
 */
@Controller
public class AddAssignmentAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4726665445585140062L;

	@Autowired
	private AssignmentService service;
	@Autowired
	private NoticeService noticeService;
	
	private String result;
	
	public String execute() {
		
			
		int cid = Integer.parseInt(request.getParameter("cid"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String possibility = request.getParameter("possibility");
		String impact = request.getParameter("impact");
		String trig = request.getParameter("trig");
		String[] followers = request.getParameter("followers").split("-");
		
		Assignment ass = new Assignment();
		ass.setCid(cid);
		ass.setTitle(title);
		ass.setCreatedAt(new Date());
		ass.setContent(content);
		ass.setImpact(impact);
		ass.setPossibility(possibility);
		ass.setSubmitUid(Utility.getUser(request).getUid());
		ass.setTrig(trig);
		
		boolean flag = service.addAssignment(ass, followers);
		if (flag) {
			setResult("success");
			noticeService.sendAssignmentNotice(cid);
		}else {
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

}
