/**
 * 
 */
package com.ccl.vo;

/**
 *
 * @author 霄汉
 * @since 2016年3月21日 下午7:57:03
 * @version 1.0
 */
public class StatisticsVO {
	
	private int year;
	private int month;	//1表示1月 12表示12月
	
	private int assignmentCount;
	private int expectSubmission;
	private int actualSubmission;
	private double submissionPercent;
	
	private double maxScoringPercent;
	private double minScoringPercent;
	private double averageScoringPercent;
	
	private int maxPersonalMarkCount;
	private int minPersonalMarkCount;
	private double averagePersonalMarkCount;
	
	private int maxAssignCount;
	private int minAssignCount;
	private double averageAssignCount;
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getAssignmentCount() {
		return assignmentCount;
	}
	public void setAssignmentCount(int assignmentCount) {
		this.assignmentCount = assignmentCount;
	}
	public int getExpectSubmission() {
		return expectSubmission;
	}
	public void setExpectSubmission(int expectSubmission) {
		this.expectSubmission = expectSubmission;
	}
	public int getActualSubmission() {
		return actualSubmission;
	}
	public void setActualSubmission(int actualSubmission) {
		this.actualSubmission = actualSubmission;
	}
	public double getSubmissionPercent() {
		return submissionPercent;
	}
	public void setSubmissionPercent(double submissionPercent) {
		this.submissionPercent = submissionPercent;
	}
	public double getMaxScoringPercent() {
		return maxScoringPercent;
	}
	public void setMaxScoringPercent(double maxScoringPercent) {
		this.maxScoringPercent = maxScoringPercent;
	}
	public double getMinScoringPercent() {
		return minScoringPercent;
	}
	public void setMinScoringPercent(double minScoringPercent) {
		this.minScoringPercent = minScoringPercent;
	}
	public double getAverageScoringPercent() {
		return averageScoringPercent;
	}
	public void setAverageScoringPercent(double averageScoringPercent) {
		this.averageScoringPercent = averageScoringPercent;
	}
	public int getMaxPersonalMarkCount() {
		return maxPersonalMarkCount;
	}
	public void setMaxPersonalMarkCount(int maxPersonalMarkCount) {
		this.maxPersonalMarkCount = maxPersonalMarkCount;
	}
	public int getMinPersonalMarkCount() {
		return minPersonalMarkCount;
	}
	public void setMinPersonalMarkCount(int minPersonalMarkCount) {
		this.minPersonalMarkCount = minPersonalMarkCount;
	}
	public double getAveragePersonalMarkCount() {
		return averagePersonalMarkCount;
	}
	public void setAveragePersonalMarkCount(double averagePersonalMarkCount) {
		this.averagePersonalMarkCount = averagePersonalMarkCount;
	}
	public int getMaxAssignCount() {
		return maxAssignCount;
	}
	public void setMaxAssignCount(int maxAssignCount) {
		this.maxAssignCount = maxAssignCount;
	}
	public int getMinAssignCount() {
		return minAssignCount;
	}
	public void setMinAssignCount(int minAssignCount) {
		this.minAssignCount = minAssignCount;
	}
	public double getAverageAssignCount() {
		return averageAssignCount;
	}
	public void setAverageAssignCount(double averageAssignCount) {
		this.averageAssignCount = averageAssignCount;
	}
	
}
