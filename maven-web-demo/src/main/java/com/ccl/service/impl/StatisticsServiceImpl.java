/**
 * 
 */
package com.ccl.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccl.dao.AssignmentDao;
import com.ccl.dao.ReportDao;
import com.ccl.model.Assignment;
import com.ccl.model.Report;
import com.ccl.service.StatisticsService;
import com.ccl.vo.StatisticsVO;

/**
 *
 * @author 霄汉
 * @since 2016年3月21日 下午8:33:23
 * @version 1.0
 */
@Service
public class StatisticsServiceImpl implements StatisticsService{
	
	@Autowired
	private AssignmentDao assignmentDao;
	@Autowired
	private ReportDao reportDao;
	
	@Override
	public List<StatisticsVO> getRecoStatics(Date start, Date end) {
		List<Report> reports = reportDao.getAllList(Report.class);
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for (Report r : reports) {
			if (r.getCreatedAt().before(end) && r.getCreatedAt().after(start)) {
				map.put(r.getAssignmentid(), map.getOrDefault(r.getAssignmentid(), 0) + 1);
			}
		}
		List<StatisticsVO> result = new ArrayList<StatisticsVO>();
		for (Entry<Integer, Integer> e : map.entrySet()) {
			int assignmentid = e.getKey();
			result.add(new StatisticsVO(assignmentDao.findById(Assignment.class, assignmentid), e.getValue()));
		}
		result.sort(new Comparator<StatisticsVO>(){
			public int compare(StatisticsVO v1, StatisticsVO v2) {
				return v2.count - v1.count;
			}
		});
		if (result.size() <= 5) {
			return result;
		}
		else {
			return result.subList(0, 5);
		}
	}
	@Override
	public List<StatisticsVO> getProbStatics(Date start, Date end) {
		List<Report> reports = reportDao.getAllList(Report.class);
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for (Report r : reports) {
			if (r.getCreatedAt().before(end) && r.getCreatedAt().after(start) && r.getStateDesc().equals("问题")) {
				map.put(r.getAssignmentid(), map.getOrDefault(r.getAssignmentid(), 0) + 1);
			}
		}
		List<StatisticsVO> result = new ArrayList<StatisticsVO>();
		for (Entry<Integer, Integer> e : map.entrySet()) {
			int assignmentid = e.getKey();
			result.add(new StatisticsVO(assignmentDao.findById(Assignment.class, assignmentid), e.getValue()));
		}
		result.sort(new Comparator<StatisticsVO>(){
			public int compare(StatisticsVO v1, StatisticsVO v2) {
				return v2.count - v1.count;
			}
		});
		if (result.size() <= 5) {
			return result;
		}
		else {
			return result.subList(0, 5);
		}
	}
	

}
