<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
<head>
<title>风险批改查看</title>
<%@ include  file="meta_and_script.jsp"%>
</head>
<body>
<%@ include  file="navigation.jsp"%>

<script>

	var reportState = ${reportState};
	if (reportState != 1) {
		alert("该风险批改情况未经老师审核通过，不能查看！");
		history.go(-1);
	}

</script>
	<div class="admission">
	   <div class="container">
	   	  <h2>风险批改查看</h2>
	   	  

	   	  <div class="clearfix"> </div>
			<table class="timetable" id="assignmentTable">
				<thead>
					<tr>
						<th>学号</th>
						<th>得分</th>
						<th>备注</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="item" items="${marks}">
					<tr>
						<td>${item.uid}</td>
						<c:if test="${item.mark<-0.5 }">
							<td><input name="name_1" type="text" class="no-box" value="" readOnly="readOnly"/></td>
						</c:if>
						<c:if test="${item.mark>-0.5 }">
							<td><input name="name_1" type="text" class="no-box" value="${item.mark}" readOnly="readOnly"/></td>
						</c:if>
						<c:if test="${empty item.comment}">
							<td><input name="name_1" type="text" class="no-box" value="" readOnly="readOnly"></td>
						</c:if>
						<c:if test="${not empty item.comment}">
							<td><input name="name_1" type="text" class="no-box" value="${item.comment}" readOnly="readOnly"></td>
						</c:if>
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
			<div class="clearfix"> </div>
	   </div>
	</div>
	
<%@ include  file="footer.jsp"%>
</body>
</html>	
