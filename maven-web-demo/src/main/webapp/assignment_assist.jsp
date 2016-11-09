<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>风险批改</title>
<%@ include  file="meta_and_script.jsp"%>
</head>
<body>
<%@ include  file="navigation.jsp"%>
	<div class="admission">
	   <div class="container">
	   	  <h2>风险批改</h2>

	   	  <table class="timetable" id="assignmentTable">
							    <thead>
									<tr>
										<th>标题</th>	
										<th>分值</th>
										<th>描述</th>  
										<th>提交截止日期</th>
										<th>批改截止日期</th> 
										<th>下载风险</th>
										<th>批改</th>
								    </tr>
								</thead>
								<tbody>

						   </tbody>
			</table>
		   <div class="clearfix"> </div>
	   </div>
	</div>
	
	
<script>
	var cid = ${cid};
	
	refreshAssignmentTable();
		
		function fillAssignmentTable(data) {
			var table = document.getElementById("assignmentTable");
			var rowNum = table.rows.length;
			for (var i = 1; i < rowNum; i++) {
				table.deleteRow(i);
				rowNum = rowNum - 1;
				i = i - 1;
			}
			var count=data.length;
			for (var i = 0; i < count; i++) {
				var ass = data[i];
				var row = table.insertRow();
				row.insertCell(0)
						.appendChild(document.createTextNode(ass.title));
				row.insertCell(1).appendChild(
						document.createTextNode(ass.point));
				row.insertCell(2).appendChild(
						document.createTextNode(ass.description));
				row.insertCell(3).appendChild(
						document.createTextNode(format(ass.submitDeadline)));
				row.insertCell(4).appendChild(
						document.createTextNode(format(ass.markDeadline)));
				
				var downloadBtn = document.createElement("input");
				downloadBtn.setAttribute("type", "button");
				downloadBtn.setAttribute("name", ass.assignmentid);
				downloadBtn.setAttribute("value", "下载");
				downloadBtn.setAttribute("class", "course-submit");
				downloadBtn.setAttribute("onclick", "downloadSubmissions(this)");
				row.insertCell(5).appendChild(downloadBtn);
				
				var checkBtn = document.createElement("input");
				checkBtn.setAttribute("type", "button");
				checkBtn.setAttribute("name", ass.assignmentid);
				checkBtn.setAttribute("value", "批改");
				checkBtn.setAttribute("class", "course-submit");
				checkBtn.setAttribute("onclick", "mark(this)");
				row.insertCell(6).appendChild(checkBtn);
				
			}
		}
		
		function mark(btn) {
			var assignmentid = btn.name;
			window.location.href="/maven-web-demo/assignment/MarksPage.action?assignmentid=" + assignmentid+"&cid="+cid;
		}
		
		function refreshAssignmentTable() {
			$.ajax({
				type : "get",
				url : "/maven-web-demo/assignment/GetAssignments",
				data : {
					cid: cid
				},
				dataType : "json",
				success : function(data) {
					fillAssignmentTable(data);
				},
				error : function() {
					alert("系统异常，请稍后重试！")
				}
			});
		}
		
		function downloadSubmissions(btn) {
			var assignmentid = btn.name;
			$.ajax({
				type : "get",
				url : "/maven-web-demo/assignment/DownloadAssignments",
				data : {
					assignmentid:assignmentid
				},
				dataType : "json",
				success : function(data) {
					if (data=="empty") {
						alert("无可下载文件！")
					}else {
						window.location.href = "/maven-web-demo/download/FileDownload.action?uri=" + data;
					}
				},
				error : function() {
					alert("系统异常，请稍后重试！")
				}
			});
		}
		
		function format(date) {
			return date.substring(0,10);
		}
		
		
	</script>	
	
<%@ include  file="footer.jsp"%>
</body>
</html>	
