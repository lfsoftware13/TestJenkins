<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>风险状态跟踪</title>
<%@ include file="meta_and_script.jsp"%>
</head>
<body>
	<%@ include file="navigation.jsp"%>
	<div class="admission">
		<div class="container">


			<div class="row">

				<h2>风险基本信息</h2>

				<div class="col-md-6 admission_left">
					<form action="" method="post" id="riskDetialForm" onsubmit="return false;">

						<div class="input-group input-group1" style="text-align:center;">
							<span style="padding-top:5px;float:left;font-size:20px;">风险编号：</span> 
							<input type="text" readonly name="assignment.assignmentid" style="width:80%;float:right;" value="<s:property value='assignment.assignmentid' />" class="form-control has-dark-background" />
						</div>
						
						<div class="input-group input-group1" style="text-align:center;">
							<span style="padding-top:5px;float:left;font-size:20px;">风险标题：</span> 
							<input type="text" name="assignment.title" style="width:80%;float:right;" value="<s:property value='assignment.title' />" class="form-control has-dark-background" />
						</div>
						
						<div class="input-group input-group1" style="text-align:center;">
							<span style="padding-top:5px;float:left;font-size:20px;">风险内容：</span> 
							<input type="text" name="assignment.content" style="width:80%;float:right;" value="<s:property value='assignment.content' />" class="form-control has-dark-background" />
						</div>
						
						<div class="input-group input-group1" style="text-align:center;">
							<span style="padding-top:5px;float:left;font-size:20px;">可能性：</span> 
							<input type="text" name="assignment.possibility" style="width:80%;float:right;" value="<s:property value='assignment.possibility' />" class="form-control has-dark-background" />
						</div>
						
						<div class="input-group input-group1" style="text-align:center;">
							<span style="padding-top:5px;float:left;font-size:20px;">影响程度：</span> 
							<input type="text" name="assignment.impact" style="width:80%;float:right;" value="<s:property value='assignment.impact' />" class="form-control has-dark-background" />
						</div>
						
						<div class="input-group input-group1" style="text-align:center;">
							<span style="padding-top:5px;float:left;font-size:20px;">触发器：</span> 
							<input type="text" name="assignment.trig" style="width:80%;float:right;" value="<s:property value='assignment.trig' />" class="form-control has-dark-background" />
						</div>
						
						<div class="input-group input-group1" style="text-align:center;">
							<span style="padding-top:5px;float:left;font-size:20px;">提交者：</span> 
							<input type="text" readonly name="assignment.submitUid" style="width:80%;float:right;" value="<s:property value='assignment.submitUid' />" class="form-control has-dark-background" />
						</div>
						
						<div style="height:10px;"></div>
						
						<input type="button" id="updateRiskBtn" value="保存" class="course-submit" onclick="checkUpdateRisk()" />
						
					</form>

				</div>


			</div>
			
			<br />
			<br />
			
			<div class="row">
				<h2>风险跟踪者</h2>
			
			</div>
			
			<br />
			<br />

			<div class="row">

			<h2>风险状态跟踪</h2>

			<div class="col-md-6 admission_left">
				<div class="input-group input-group1">
					<select id="stateDesc">
						<option value="risk">风险</option>
						<option value="problem">问题</option>
					</select>
				</div>
				<div class="input-group input-group1">
					<input class="form-control has-dark-background" id="content"
						placeholder="详细信息" type="text" />
				</div>
			</div>

			<div>
				<input class="course-submit" type="submit" value="发布" id="submitBtn" />
			</div>
			
			</div>

			<div class="clearfix"></div>
			<table class="timetable" id="assignmentTable">
				<thead>
					<tr>
						<th>时间</th>
						<th>状态描述</th>
						<th>详细信息</th>
						<th>提交者</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="item" items="${reports}">
						<tr>
							<td>${item.createdAt}</td>
							<td><input name="name_1" type="text" class="no-box"
								value="${item.stateDesc}" readOnly="readOnly"></td>
							<td><input name="name_1" type="text" class="no-box"
								value="${item.content}" readOnly="readOnly" /></td>
							<td><input name="name_1" type="text" class="no-box"
								value="${item.uid}" readOnly="readOnly"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="clearfix"></div>
		</div>
	</div>

	<script>
		var assignmentid = $
		{
			assignmentid
		};

		var $btn = $("#submitBtn");
		$btn.bind("click", function() {
			var stateDesc = $('#stateDesc option:selected').val();
			var content = $("#content").val();
			$.ajax({
				type : "post",
				url : "/maven-web-demo/assignment/SubmitReport",
				data : {
					stateDesc : stateDesc,
					content : content,
					assignmentid : assignmentid
				},
				dataType : "json",
				success : function(data) {
					if (data == "deny") {
						alert("操作拒绝：您不是该风险的跟踪者。");
					} else if (data == "success") {
						alert("发布成功！");
						window.location.reload(true);
					} else {
						alert("发布失败：请检查输入。");
					}
				},
				error : function() {
					alert("系统异常，请稍后重试！");
				},
			});
		});
		
		function format(date) {
			return date.substring(0, 10);
		}
		
		function checkUpdateRisk(){
			console.log($("#riskDetialForm").serialize());
			
			var d=$("#riskDetialForm").serialize();
			
			$.ajax({
				type : "post",
				url : "/maven-web-demo/assignment/AddAssignment!updateAssignmentInf",
				data : d,
				dataType : "json",
				success : function(data) {
					if (data == "deny") {
						alert("操作拒绝：您不是该风险的跟踪者。");
					} else if (data == "success") {
						alert("修改成功！");
						window.location.reload(true);
					} else {
						alert("修改失败：请检查输入。");
					}
				},
				error : function() {
					alert("系统异常，请稍后重试！");
				},
			});
			
		}
		
	</script>

	<%@ include file="footer.jsp"%>
</body>
</html>
