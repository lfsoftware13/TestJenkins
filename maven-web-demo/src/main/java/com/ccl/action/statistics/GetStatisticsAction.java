/**
 * 
 */
package com.ccl.action.statistics;

import java.rmi.activation.ActivationSystem;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ccl.action.BaseAction;
import com.ccl.service.StatisticsService;
import com.ccl.vo.StatisticsVO;

/**
 *
 * @author 霄汉
 * @since 2016年3月21日 下午9:36:20
 * @version 1.0
 */
@Controller
public class GetStatisticsAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2919733935238067748L;

	@Autowired
	private StatisticsService service;
	
	private List<StatisticsVO> result;
	
	public String execute() {
		int startYear = Integer.parseInt(request.getParameter("startYear"));
		int startMonth = Integer.parseInt(request.getParameter("startMonth"));
		int endYear = Integer.parseInt(request.getParameter("endYear"));
		int endMonth = Integer.parseInt(request.getParameter("endMonth"));
		setResult(service.getStatics(startYear, startMonth, endYear, endMonth));
		System.out.println(result.size());
		return SUCCESS;
	}

	public List<StatisticsVO> getResult() {
		return result;
	}

	public void setResult(List<StatisticsVO> result) {
		this.result = result;
	}

}
