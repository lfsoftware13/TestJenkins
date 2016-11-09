<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>教学计划</title>
<%@ include file="meta_and_script.jsp"%>
<script src="/maven-web-demo/js/mysift.js" ></script>
</head>
<body>
	<%@ include file="navigation.jsp"%>
	<div class="courses_box1">
		<div class="container">
			<form class="contact_form">
				<div class="col-md-4 grid_6">
					<input type="text" class="text" name="coursename" id="coursename" placeholder="项目"  /> 
					<input type="text" class="text" name="semester" id="semester" placeholder="学期" />
					<input type="text" class="text" name="comment" id="comment" placeholder="备注" />
					<div class="col-sm-2 submit_button">
						<input type="button" class="course-submit-wide" value="添加" id="addBtn" onclick="return false"/>
					</div>
				</div>
				<div class="clearfix"></div>
			</form>

			<script>
				var semesternames = [];
				var semesterids = [];
				<c:forEach var="item" items="${semesters}">
					semesternames.push("${item.semestername}");
					semesterids.push("${item.semesterid}")
				</c:forEach>
				var semesterDropdown = new mSift('semesterDropdown', 20);
				//数据 
				semesterDropdown.Data = semesternames;
				semesterDropdown.Ids = semesterids;
				//指定文本框对象建立特效 
				semesterDropdown.Create(document.getElementById('semester'));
				
				var coursenames = [];
				var courseids = [];
				<c:forEach var="item" items="${courses}">
					coursenames.push("${item.coursename}" + "   " + "${item.teacher}");
					courseids.push("${item.cid}")
				</c:forEach>
				var courseDropdown = new mSift('courseDropdown', 20);
				courseDropdown.Data = coursenames;
				courseDropdown.Ids=courseids;
				courseDropdown.Create(document.getElementById('coursename'));
				
				 refreshScheduleTable();
				addBtn();
				
				function addBtn() {
					var $btn = $("#addBtn");
					$btn.bind("click", function() {
						$.ajax({
							type : "post",
							url : "schedule/AddSchedule",
							data : {
								cid:courseDropdown.GetSelectedId(),
								semesterid:semesterDropdown.GetSelectedId(),
								comment:$("#comment").val()
							},
							dataType : "json",
							success : function(data) {
								if (data=="success") {
									alert("添加成功！");
									refreshScheduleTable();
									document.getElementById("coursename").value="";
									document.getElementById("semester").value="";
									document.getElementById("comment").value="";
								}else {
									alert("添加失败：请检查输入。")
								}
							},
							error: function() {
								alert("系统异常，请稍后重试！");
		                    },
						});
					})
				}
				
				function fillScheduleTable(data) {
					var table = document.getElementById("scheduleTable");
					var rowNum = table.rows.length;
					for (var i = 1; i < rowNum; i++) {
						table.deleteRow(i);
						rowNum = rowNum - 1;
						i = i - 1;
					}
					var count=data.length;
					for (var i = 0; i < count; i++) {
						var schedule = data[i];
						var row = table.insertRow();
						row.insertCell(0)
								.appendChild(document.createTextNode(schedule.coursename));
						row.insertCell(1).appendChild(
								document.createTextNode(schedule.teacher));
						row.insertCell(2).appendChild(
								document.createTextNode(schedule.semesterName));
						
						var delBtn = document.createElement("input");
						delBtn.setAttribute("type", "button");
						delBtn.setAttribute("id", schedule.cid);
						delBtn.setAttribute("value", "删除");
						delBtn.setAttribute("class", "course-submit");
						delBtn.setAttribute("onclick", "delSchedule(this)");
						row.insertCell(3).appendChild(delBtn);
					}
				}

				function refreshScheduleTable() {
					$.ajax({
						type : "get",
						url : "schedule/GetScheduledCourses",
						data : {},
						dataType : "json",
						success : function(data) {
							fillScheduleTable(data);
						},
						error : function() {
							alert("系统异常，请稍后重试！")
						}
					});
				}
				
				function delSchedule(btn) {
					var cid = btn.id;
					$.ajax({
						type : "post",
						url : "schedule/DelSchedule",
						data : {
							cid: cid,
						},
						dataType : "json",
						success : function(data) {
							if (data == "success") {
								alert("删除成功");
								refreshScheduleTable();
							}else {
								alert("删除失败：系统异常。")
							}
						},
						error : function() {
							alert("系统异常，请稍后重试！")
						}
					});
				}

			</script>


			<table class="timetable" id="scheduleTable">
				<thead>
					<tr>
						<th>项目名称</th>
						<th>教师</th>
						<th>学期</th>
						<th>删除</th>
					</tr>
				</thead>
				<tbody id="tbd">
				</tbody>
			</table>
			

		</div>
	</div>


	<%@ include file="footer.jsp"%>
</body>
</html>
