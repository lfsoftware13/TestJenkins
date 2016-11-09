<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>统计数据</title>
<%@ include file="meta_and_script.jsp"%>

<script src="http://ajax.useso.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
</head>
<body>
	<%@ include file="navigation.jsp"%>
	<div class="admission">
		<div class="container">
			<h2>统计数据</h2>

			<div class="col-md-3 admission_left">
				<div class="select-block1">
					<select id="startYear">
						<option value="0">开始年份</option>
						<option value="2010">2010</option>
						<option value="2011">2011</option>
						<option value="2012">2012</option>
						<option value="2013">2013</option>
						<option value="2014">2014</option>
						<option value="2015">2015</option>
						<option value="2016">2016</option>
						<option value="2017">2017</option>
					</select>
				</div>

				<div class="select-block1">
					<select id="startMonth">
						<option value="">开始月份</option>
						<option value="">1月</option>
						<option value="">2月</option>
						<option value="">3月</option>
						<option value="">4月</option>
						<option value="">5月</option>
						<option value="">6月</option>
						<option value="">7月</option>
						<option value="">8月</option>
						<option value="">9月</option>
						<option value="">10月</option>
						<option value="">11月</option>
						<option value="">12月</option>
					</select>
				</div>

				<div class="select-block1">
					<select id="endYear">
						<option value="0">结束年份</option>
						<option value="2010">2010</option>
						<option value="2011">2011</option>
						<option value="2012">2012</option>
						<option value="2013">2013</option>
						<option value="2014">2014</option>
						<option value="2015">2015</option>
						<option value="2016">2016</option>
						<option value="2017">2017</option>
					</select>
				</div>

				<div class="select-block1">
					<select id="endMonth">
						<option value="">结束月份</option>
						<option value="">1月</option>
						<option value="">2月</option>
						<option value="">3月</option>
						<option value="">4月</option>
						<option value="">5月</option>
						<option value="">6月</option>
						<option value="">7月</option>
						<option value="">8月</option>
						<option value="">9月</option>
						<option value="">10月</option>
						<option value="">11月</option>
						<option value="">12月</option>
					</select>
				</div>

				<input type="submit" value="查询" id="queryBtn" class="course-submit-wide" onclick="query()" />
			</div>

			<div class="col-md-9 admission_right">
									<!-- 选项卡栏目 -->
						<ul id="myTab" class="nav nav-tabs nav-tabs1" role="tablist">
							<li role="presentation" class="active"><a href="#assignments"
								id="assignments-tab" role="tab" data-toggle="tab"
								aria-controls="assignments" aria-expanded="true">风险数据</a></li>
							<li role="presentation"><a href="#students" role="tab"
								id="students-tab" data-toggle="tab" aria-controls="students">参与者数据</a>
							</li>
							<li role="presentation"><a href="#assists" role="tab"
								id="assists-tab" data-toggle="tab" aria-controls="assists">助教数据</a>
							</li>
							<li role="presentation"><a href="#teachers" role="tab"
								id="teachers-tab" data-toggle="tab" aria-controls="teachers">教师数据</a>
							</li>
						</ul>

						<div id="myTabContent" class="tab-content">
						
							<!-- 第一个选项卡 -->
							<div role="tabpanel" class="tab-pane fade in active" id="assignments" aria-labelledby="assignments">
								<div id="assignmentsChartContainer" style="height:400px;width:60%;"></div>
							</div>

							<!-- 第二个选项卡内容 -->
							<div role="tabpanel" class="tab-pane fade" id="students" aria-labelledby="students-tab">
								<div id="studentsChartContainer" style="height:400px;width:60%; "></div>
							</div>

							<!-- 第三个选项卡内容 -->
							<div role="tabpanel" class="tab-pane fade" id="assists" aria-labelledby="assists-tab">
								<div id="assistsChartContainer" style="height:400px;width:60%; "></div>
							</div>

							<!-- 第四个选项卡内容 -->
							<div role="tabpanel" class="tab-pane fade" id="teachers" aria-labelledby="teachers-tab">
								<div id="teachersChartContainer" style="height:400px;width:60%; "></div>
							</div>			
					</div>

			<div class="clearfix"></div>
		</div>
	</div>
	</div>


	<script>

	
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
				checkBtn.setAttribute("value", "查看");
				checkBtn.setAttribute("class", "course-submit");
				checkBtn.setAttribute("onclick", "checkMark(this)");
				row.insertCell(6).appendChild(checkBtn);
				
				var delBtn = document.createElement("input");
				delBtn.setAttribute("type", "button");
				delBtn.setAttribute("name", ass.assignmentid);
				delBtn.setAttribute("value", "删除");
				delBtn.setAttribute("class", "course-submit");
				delBtn.setAttribute("onclick", "delAssignment(this)");
				row.insertCell(7).appendChild(delBtn);
			}
		}

		
		function query() {
			var startYear = document.getElementById("startYear").value;
			var startMonth = document.getElementById("startMonth").selectedIndex;
			var endYear = document.getElementById("endYear").value;
			var endMonth = document.getElementById("endMonth").selectedIndex;
			if (startYear == 0 || startMonth == 0 || endYear == 0 || endMonth == 0) {
				alert("请完整填写查询条件！");
				return;
			}
			
			$.ajax({
				type : "get",
				url : "/maven-web-demo/statistics/GetStatistics",
				data : {
					startYear:startYear,
					startMonth:startMonth,
					endYear:endYear,
					endMonth:endMonth
				},
				dataType : "json",
				success : function(data) {
					var height = data.length * 50 + "px";
					document.getElementById("assignmentsChartContainer").style.height = height;
					document.getElementById("studentsChartContainer").style.height = height;
					document.getElementById("assistsChartContainer").style.height = height;
					document.getElementById("teachersChartContainer").style.height = height;
					refreshAssignmentsChart(data);
					refreshStudentsChart(data);
					refreshAssistsChart(data);
					refreshTeachersChart(data);
				},
				error: function() {
					alert("系统异常，请稍后重试！");
                },
			});
		}
		
		function refreshAssignmentsChart(data) {
			var categories = [];
			var expects = [];
			var actuals = [];
			var expectsMap = {};
			var actualsMap = {};
			for (var i = 0 ; i< data.length; i++) {
				var vo = data[i];
				categories.push(vo.year + "." + vo.month);
				expects.push(vo.expectSubmission);
				actuals.push(vo.actualSubmission);
			}
			expectsMap['name']="预期提交风险数";
			expectsMap['data']=expects;
			actualsMap['name']="实际提交风险数";
			actualsMap['data']=actuals;
			
			$(function () { 
			    $('#assignmentsChartContainer').highcharts({
			        chart: {
			            type: 'bar'
			        },
			        title: {
			            text: '风险提交情况'
			        },
			        xAxis: {
			            categories: categories
			        },
			        yAxis: {
			            title: {
			                text: '数量'
			            }
			        },
			        series: [expectsMap, actualsMap]
			    });
			});
		}

		function refreshStudentsChart(data) {
			var categories = [];
			var max = [];
			var min = [];
			var avg = [];
			var maxMap = {};
			var minMap = {};
			var avgMap = {};
			for (var i = 0 ; i< data.length; i++) {
				var vo = data[i];
				categories.push(vo.year + "." + vo.month);
				max.push(vo.maxScoringPercent);
				min.push(vo.minScoringPercent);
				avg.push(vo.averageScoringPercent);
			}
			maxMap['name']="最高得分率";
			maxMap['data']=max;
			minMap['name']="最低得分率";
			minMap['data']=min;
			avgMap['name']="平均得分率";
			avgMap['data']=avg;
			
			$(function () { 
			    $('#studentsChartContainer').highcharts({
			        chart: {
			            type: 'bar'
			        },
			        title: {
			            text: '参与者得分率情况'
			        },
			        xAxis: {
			            categories: categories
			        },
			        yAxis: {
			            title: {
			                text: '得分率'
			            }
			        },
			        series: [maxMap, minMap, avgMap]
			    });
			});
		}

		function refreshAssistsChart(data) {
			var categories = [];
			var max = [];
			var min = [];
			var avg = [];
			var maxMap = {};
			var minMap = {};
			var avgMap = {};
			for (var i = 0 ; i< data.length; i++) {
				var vo = data[i];
				categories.push(vo.year + "." + vo.month);
				max.push(vo.maxPersonalMarkCount);
				min.push(vo.minPersonalMarkCount);
				avg.push(vo.averagePersonalMarkCount);
			}
			maxMap['name']="最高批改数";
			maxMap['data']=max;
			minMap['name']="最低批改数";
			minMap['data']=min;
			avgMap['name']="平均批改数";
			avgMap['data']=avg;
			
			$(function () { 
			    $('#assistsChartContainer').highcharts({
			        chart: {
			            type: 'bar'
			        },
			        title: {
			            text: '助教批改情况'
			        },
			        xAxis: {
			            categories: categories
			        },
			        yAxis: {
			            title: {
			                text: '批改数'
			            }
			        },
			        series: [maxMap, minMap, avgMap]
			    });
			});
		}

		function refreshTeachersChart(data) {
			var categories = [];
			var max = [];
			var min = [];
			var avg = [];
			var maxMap = {};
			var minMap = {};
			var avgMap = {};
			for (var i = 0 ; i< data.length; i++) {
				var vo = data[i];
				categories.push(vo.year + "." + vo.month);
				max.push(vo.maxAssignCount);
				min.push(vo.minAssignCount);
				avg.push(vo.averageAssignCount);
			}
			maxMap['name']="最高布置数量";
			maxMap['data']=max;
			minMap['name']="最低布置数量";
			minMap['data']=min;
			avgMap['name']="平均布置风险";
			avgMap['data']=avg;
			
			$(function () { 
			    $('#teachersChartContainer').highcharts({
			        chart: {
			            type: 'bar'
			        },
			        title: {
			            text: '教师布置风险情况'
			        },
			        xAxis: {
			            categories: categories
			        },
			        yAxis: {
			            title: {
			                text: '风险数量'
			            }
			        },
			        series: [maxMap, minMap, avgMap]
			    });
			});
		}

		function format(date) {
			return date.substring(0,10);
		}
		
		
	</script>

	<%@ include file="footer.jsp"%>
</body>
</html>
