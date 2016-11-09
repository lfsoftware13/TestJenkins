/**
 * 
 */
package com.ccl.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccl.dao.AssignmentDao;
import com.ccl.dao.FollowDao;
import com.ccl.dao.MarkDao;
import com.ccl.dao.ReportDao;
import com.ccl.dao.SelectionDao;
import com.ccl.dao.SubmissionDao;
import com.ccl.model.Assignment;
import com.ccl.model.Follow;
import com.ccl.model.Mark;
import com.ccl.model.Report;
import com.ccl.model.Submission;
import com.ccl.model.User;
import com.ccl.service.AssignmentService;
import com.ccl.vo.SubmissionInfoVO;

/**
 *
 * @author 霄汉
 * @since 2016年3月20日 下午2:04:06
 * @version 1.0
 */
@Service
public class AssignmentServiceImpl implements AssignmentService{
	
	@Autowired
	private AssignmentDao assignmentDao;
	@Autowired
	private SubmissionDao submissionDao;
	@Autowired
	private MarkDao markDao;
	@Autowired
	private ReportDao reportDao;
	@Autowired
	private FollowDao followDao;
	@Autowired
	private SelectionDao selectionDao;

	/* (non-Javadoc)
	 * @see com.ccl.service.TeachCourseService#addAssignment(com.ccl.model.Assignment)
	 */
	@Override
	public boolean addAssignment(Assignment assignment, String[] followers) {
		try {
			assignmentDao.save(assignment);
			int aid = assignment.getAssignmentid();
			for (String fid : followers) {
				Follow follow = new Follow();
				follow.setAssignmentid(aid);
				follow.setCreatedAt(new Date());
				follow.setUid(fid);
				followDao.save(follow);
			}
			return true;
		}catch (Exception e) {
			return false;
		}
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.TeachCourseService#delAssignment(int)
	 */
	@Override
	public void delAssignment(int assignmentid) {
		assignmentDao.delete(Assignment.class, assignmentid);
		
	}
	
	/* (non-Javadoc)
	 * @see com.ccl.service.TeachCourseService#getAssignments(int)
	 */
	@Override
	public List<Assignment> getAssignments(int cid) {
		return assignmentDao.getListByColumn(Assignment.class, "cid",  cid);
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#getSubmissionInfo(int, java.lang.String)
	 */
	@Override
	public List<SubmissionInfoVO> getSubmissionInfo(int cid, String uid) {
		return assignmentDao.getSubmissionInfo(cid, uid);
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#writeSubmissionRecord(com.ccl.model.Submission)
	 */
	@Override
	public void writeSubmissionRecord(Submission submission) {
		submissionDao.overwriteSubmissionRecord(submission);
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#getMarks(int)
	 */
	@Override
	public List<Mark> getMarks(int assignmentid) {
		return markDao.getAllMarks(assignmentid);
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#getReport(int)
	 */
	@Override
	public Report getReport(int assignmentid) {
		return reportDao.findByColumn(Report.class, "assignmentid", assignmentid);
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#writeMarks(java.util.List)
	 */
	@Override
	public void writeMarks(List<Mark> marks) {
		for (Mark m : marks) {
			markDao.overwriteMark(m);
		}
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#writeReport(com.ccl.model.Report)
	 */
	@Override
	public void writeReport(Report report) {
		reportDao.save(report);
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#getUserInProject(int)
	 */
	@Override
	public List<User> getUserInProject(int cid) {
		List<User> users = selectionDao.getAttendUserByCid(cid);
		return users;
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#getReports(int)
	 */
	@Override
	public List<Report> getReports(int assignmentid) {
		return reportDao.getListByColumn(Report.class, "assignmentid", assignmentid);
		
	}

	/* (non-Javadoc)
	 * @see com.ccl.service.AssignmentService#isFollower(java.lang.String, int)
	 */
	@Override
	public boolean isFollower(String uid, int assignmentid) {
		List<User> followers = followDao.getFollowUserByAssignmentid(assignmentid);
		boolean isFollower = false;
		for (User user : followers) {
			if (user.getUid().equals(uid)) {
				isFollower = true;
				break;
			}
		}
		return isFollower;
	}



}
