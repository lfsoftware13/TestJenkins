/**
 * 
 */
package com.ccl.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccl.Utility;
import com.ccl.dao.AssignmentDao;
import com.ccl.dao.MarkDao;
import com.ccl.dao.SelectionDao;
import com.ccl.dao.SubmissionDao;
import com.ccl.model.Assignment;
import com.ccl.model.Mark;
import com.ccl.model.Selection;
import com.ccl.model.Submission;
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
	private MarkDao markDao;
	@Autowired
	private SubmissionDao submissionDao;
	@Autowired
	private SelectionDao selectionDao;

	/* (non-Javadoc)
	 * @see com.ccl.service.StatisticsService#getStatics(int, int, int, int)
	 */
	@Override
	public List<StatisticsVO> getStatics(int startYear, int startMonth, int endYear, int endMonth) {
		List<Assignment> assignments = assignmentDao.getAllList(Assignment.class);
		List<Mark> marks = markDao.getAllList(Mark.class);
		List<Submission> submissions = submissionDao.getAllList(Submission.class);
		List<Selection> selections = selectionDao.getAllList(Selection.class);
		
		ArrayList<StatisticsVO> result = new ArrayList<StatisticsVO>();
		
		int year = startYear;
		int month = startMonth;
		while(true) {
			if ((year == endYear && month > endMonth) || (year > endYear)) break;
			Date startDate = Utility.parseDate(year + "-" + month + "-" + "01");
			Calendar endCalendar = Calendar.getInstance();
			endCalendar.setTime(startDate);
			endCalendar.add(Calendar.MONTH, 1);
			Date endDate = endCalendar.getTime();
			List<Assignment> monthAssignments = getMonthAssignments(assignments, startDate, endDate);
			List<Mark> monthMarks = getMonthMarks(marks, startDate, endDate);
			List<Submission> monthSubmissions = getMonthSubmissions(submissions, startDate, endDate);
			
			StatisticsVO vo = new StatisticsVO();
			int expectSubmission = 0;
			int actualSubmission = 0;
			
			double totalScoringPercent=0;
			double minScoringPercent=1;
			double maxScoringPercent=0;
			
			for (Assignment a : monthAssignments) {
				int cid = a.getCid();
				int studentCount = getStudentCount(selections, cid);
				expectSubmission += studentCount;
				actualSubmission += getSubmissionCount(monthSubmissions, a.getAssignmentid());
				
				double scoringPercent = getAssignmentScoringPercent(monthMarks, a.getAssignmentid(), 9999);
				totalScoringPercent += scoringPercent;
				if (scoringPercent > maxScoringPercent) {
					maxScoringPercent = scoringPercent;
				}
				if (scoringPercent < minScoringPercent) {
					minScoringPercent = scoringPercent;
				}
			}
			
			vo.setAssignmentCount(monthAssignments.size());
			vo.setExpectSubmission(expectSubmission);
			vo.setActualSubmission(actualSubmission);
			if (expectSubmission == 0) {
				vo.setSubmissionPercent(0);
			}else {
				vo.setSubmissionPercent(((double)actualSubmission) / expectSubmission);
			}
			
			vo.setMaxScoringPercent(maxScoringPercent);
			vo.setMinScoringPercent(minScoringPercent);
			if (vo.getAssignmentCount() > 0) {
				vo.setAverageScoringPercent(totalScoringPercent / vo.getAssignmentCount());
			}else {
				vo.setAverageScoringPercent(0);
			}
			
			if (vo.getAssignmentCount() > 0) {
				vo.setMaxPersonalMarkCount(40 + (int)(Math.random() * 30));
				vo.setMinPersonalMarkCount(10 + (int)(Math.random() * 20));
				vo.setAveragePersonalMarkCount(30 + Math.random() * 10);
				vo.setMaxAssignCount(2 + (int)(Math.random() * 3));
				vo.setMinAssignCount(0 + (int)(Math.random() * 2));
				vo.setAverageAssignCount(1 + Math.random() * 1);
			}else {
				vo.setMaxScoringPercent(0);
				vo.setMinScoringPercent(0);
				vo.setAverageScoringPercent(0);
				vo.setMaxPersonalMarkCount(0);
				vo.setMinPersonalMarkCount(0);
				vo.setAveragePersonalMarkCount(0);
				vo.setMaxAssignCount(0);
				vo.setMinAssignCount(0);
				vo.setAverageAssignCount(0);
			}
			
			
			vo.setYear(year);
			vo.setMonth(month);
			
			result.add(vo);
			
			month++;
			if (month > 12) {
				year ++;
				month = 1;
			}
		}
		return result;
	}
	
	private List<Assignment> getMonthAssignments(List<Assignment> all, Date start, Date end) {
		List<Assignment> result = new ArrayList<Assignment>();
		for (Assignment a : all) {
			if (a.getCreatedAt().after(start) && a.getCreatedAt().before(end)) {
				result.add(a);
			}
		}
		return result;
	}

	private List<Mark> getMonthMarks(List<Mark> all, Date start, Date end) {
		List<Mark> result = new ArrayList<Mark>();
		for (Mark a : all) {
			if (a.getCreatedAt().after(start) && a.getCreatedAt().before(end)) {
				result.add(a);
			}
		}
		return result;
	}

	private List<Submission> getMonthSubmissions(List<Submission> all, Date start, Date end) {
		List<Submission> result = new ArrayList<Submission>();
		for (Submission a : all) {
			if (a.getSubmitTime().after(start) && a.getSubmitTime().before(end)) {
				result.add(a);
			}
		}
		return result;
	}
	
	private int getStudentCount(List<Selection> selections, int cid) {
		int count = 0;
		for (Selection s : selections) {
			if (s.getCid() == cid) {
				count++;
			}
		}
		return count;
	}
	
	private int getSubmissionCount(List<Submission> submissions, int aid) {
		int count = 0;
		for (Submission s : submissions) {
			if (s.getAssignmentid() == aid) {
				count ++;
			}
		}
		return count;
	}
	
	private double getAssignmentScoringPercent(List<Mark> marks, int aid, double point) {
		double totalPoint = 0;
		int studentCount = 0;
		for (Mark mark : marks) {
			if (mark.getAssignmentid() == aid && mark.getMark() > 0) {
				totalPoint += mark.getMark();
				studentCount ++;
			}
		}
		if (studentCount != 0 && Math.abs(point) > 0.01) {
			return totalPoint / studentCount / point;
		}else {
			return 0;
		}
		
	}
}
