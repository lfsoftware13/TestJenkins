<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<title>风险</title>
<%@ include  file="meta_and_script.jsp"%>
<script src="/maven-web-demo/js/ajaxfileupload.js"></script>
</head>
<body>
<%@ include  file="navigation.jsp"%>
	<div class="admission">
	   <div class="container">
	   
	   	  <table class="timetable" id="assignmentTable">
							    <thead>
									<tr>
										<th>标题</th>	
										<th>分值</th>
										<th>描述</th>  
										<th>截止日期</th>
										<th>已提交</th>
										<th>选择文件</th>
										<th>提交</th>
										<th>样例</th>
										<th>点评</th>
										<th>分数查看</th>
								    </tr>
								</thead>
								<tbody>
						   </tbody>
			</table>
		   <div class="clearfix"> </div>
	   </div>
	</div>
	<script>

	
	var uid = ${sessionScope.user.uid};
	var cid = ${cid};
	
	refreshAssignmentTable();
	addBtn();
	
		function addBtn() {
			var $btn = $("#addBtn");
			$btn.bind("click", function() {
				$.ajax({
					type : "post",
					url : "/maven-web-demo/assignment/AddAssignment",
					data : {
						cid:cid,
						title:$("#title").val(),
						point:$("#point").val(),
						description:$("#description").val(),
						submitDeadline:$("#submitDate").val(),
						markDeadline:$("#markDate").val()
					},
					dataType : "json",
					success : function(data) {
						if (data == "success") {
							alert("发布成功!");
							refreshAssignmentTable();
						}else {
							alert("发布失败：请检查输入");
						}
					},
					error: function() {
						alert("系统异常，请稍后重试！");
                    },
				});
			})
		}
		
		function ajaxFileUpload(btn) {
				var assignmentid=btn.name;
		        $.ajaxFileUpload  
		        (  
		            {
		            	type:"get",
		                url:"/maven-web-demo/assignment/UploadSubmission.action?uid="+ uid +"&assignmentid="+assignmentid, 
		                secureuri:false,//一般设置为false  
		                fileElementId:'file' + assignmentid,//文件上传空间的id属性
		                dataType: 'json',//返回值类型 一般设置为json  
		                success: function (data){//服务器成功响应处
		                	if (data=="success") {
		                		alert("上传成功！");
		                	}else {
		                		alert("上传失败：请稍后再试。")
		                	}
		                },
						error : function() {
							alert("系统异常，请稍后重试！")
						}
		            })
		            alert("上传成功！");
		}
	
		
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
						document.createTextNode(format(ass.deadline)));
				row.insertCell(4).appendChild(
						document.createTextNode((ass.submited)));
				
				if (ass.isOver) {
					row.insertCell(5).appendChild(document.createTextNode("已经结束"));
					row.insertCell(6).appendChild(document.createTextNode("不能提交"));
				}else {
					var file = document.createElement("input");
					file.setAttribute("type", "file");
					file.setAttribute("name","file");
					file.setAttribute("id", "file" + ass.assignmentid);
					row.insertCell(5).appendChild(file);
					
					var submitBtn = document.createElement("input");
					submitBtn.setAttribute("type", "button");
					submitBtn.setAttribute("name", ass.assignmentid);
					submitBtn.setAttribute("value", "提交");
					submitBtn.setAttribute("class", "course-submit");
					submitBtn.setAttribute("onclick", "ajaxFileUpload(this)");
					row.insertCell(6).appendChild(submitBtn);
				}
				
				var directionBtn = document.createElement("input");
				directionBtn.setAttribute("type", "button");
				directionBtn.setAttribute("value", "下载");
				directionBtn.setAttribute("class", "course-submit");
				directionBtn.setAttribute("onclick", "downloadFile('" +ass.directionPath + "')");
				if ((ass.directionPath) == "null" || ass.directionPath==null) {
					row.insertCell(7).appendChild(document.createTextNode("暂无"));
				}else {
					row.insertCell(7).appendChild(directionBtn);
				}
				
				
				var reviewBtn = document.createElement("input");
				reviewBtn.setAttribute("type", "button");
				reviewBtn.setAttribute("value", "下载");
				reviewBtn.setAttribute("class", "course-submit");
				reviewBtn.setAttribute("onclick", "downloadFile(" +ass.reviewPath + ")");
				if ((ass.reviewPath) == "null" || ass.reviewPath==null) {
					row.insertCell(8).appendChild(document.createTextNode("暂无"));
				}else {
					row.insertCell(8).appendChild(reviewBtn);
				}
				
				var lookBtn = document.createElement("input");
				lookBtn.setAttribute("type", "button");
				lookBtn.setAttribute("name", ass.assignmentid);
				lookBtn.setAttribute("value", "查看");
				lookBtn.setAttribute("class", "course-submit");
				lookBtn.setAttribute("onclick", "lookMark(this)");
				row.insertCell(9).appendChild(lookBtn);
			}
		}
		
		function downloadFile(path) {
			window.location.href = "/maven-web-demo/download/FileDownload.action?uri=" + path;
		}
		
		function lookMark(btn) {
			var assignmentid = btn.name;
			window.location.href="/maven-web-demo/assignment/MarksLookPage.action?assignmentid=" + assignmentid;
		}

		function refreshAssignmentTable() {
			$.ajax({
				type : "get",
				url : "/maven-web-demo/assignment/GetSubmissionInfo",
				data : {
					cid: cid,
					uid:uid
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
		
		function format(date) {
			return date.substring(0,10);
		}
		
	</script>	
	
<%@ include  file="footer.jsp"%>
</body>
</html>	
