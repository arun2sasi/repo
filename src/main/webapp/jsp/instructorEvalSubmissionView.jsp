<%@ page import="teammates.common.Common"%>
<%@ page import="teammates.common.datatransfer.CourseData"%>
<%@ page import="teammates.common.datatransfer.EvaluationData"%>
<%@ page import="teammates.common.datatransfer.SubmissionData"%>
<%@ page import="teammates.ui.controller.InstructorEvalSubmissionViewHelper"%>
<%	InstructorEvalSubmissionViewHelper helper = (InstructorEvalSubmissionViewHelper)request.getAttribute("helper"); %>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="/favicon.png">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teammates - Instructor</title>
	<link rel="stylesheet" href="/stylesheets/common.css" type="text/css">
	<link rel="stylesheet" href="/stylesheets/instructorEvalSubmissionView.css" type="text/css">
	
	<script type="text/javascript" src="/js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="/js/tooltip.js"></script>
	<script type="text/javascript" src="/js/date.js"></script>
	<script type="text/javascript" src="/js/CalendarPopup.js"></script>
	<script type="text/javascript" src="/js/AnchorPosition.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
	<script type="text/javascript" src="/js/instructor.js"></script>
    <jsp:include page="../enableJS.jsp"></jsp:include>
</head>

<body>
	<div id="dhtmltooltip"></div>
	<div id="frameTop">
		<jsp:include page="<%= Common.JSP_INSTRUCTOR_HEADER %>" />
	</div>

	<div id="frameBody">
		<div id="frameBodyWrapper">
			<div id="topOfPage"></div>
			<div id="headerOperation">
				<h1>View Student's Evaluation</h1>
				<table class="inputTable" id="studentEvaluationInfo">
					<tr>
						<td class="label rightalign" width="30%">Course ID:</td>
						<td class="leftalign"><%= helper.evaluation.course %></td>
					</tr>
					<tr>
						<td class="label rightalign" width="30%">Evaluation Name:</td>
						<td class="leftalign"><%=InstructorEvalSubmissionViewHelper.escapeForHTML(helper.evaluation.name)%></td>
					</tr>
				</table>
			</div>
			<div id="studentEvaluationSubmissions">
			<%
				for(boolean byReviewee = true, repeat=true; repeat; repeat = byReviewee, byReviewee=false){
			%>
				<h2 style="text-align: center;"><%=InstructorEvalSubmissionViewHelper.escapeForHTML(helper.student.name) + (byReviewee ? "'s Result" : "'s Submission")%></h2>
				<table class="resultTable">
					<thead><tr>
						<th colspan="2" width="10%">
							<span class="resultHeader"><%=byReviewee ? "Reviewee" : "Reviewer"%>: </span><%=helper.student.name%></th>
						<th><span class="resultHeader"
								onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_CLAIMED%>')"
								onmouseout="hideddrivetip()">
							Claimed Contributions: </span><%=InstructorEvalSubmissionViewHelper.printSharePoints(helper.result.claimedToInstructor,true)%></th>
						<th><span class="resultHeader"
								onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_PERCEIVED%>')"
								onmouseout="hideddrivetip()">
							Perceived Contributions: </span><%=InstructorEvalSubmissionViewHelper.printSharePoints(helper.result.perceivedToInstructor,true)%></th>
					</tr></thead>
					<tr>
						<td colspan="4"><span class="color_neutral">Self evaluation:</span><br>
								<%=InstructorEvalSubmissionViewHelper.printJustification(helper.result.getSelfEvaluation())%></td>
						</tr>
						<tr>
							<td colspan="4"><span class="color_neutral">Comments about team:</span><br>
								<%=InstructorEvalSubmissionViewHelper.printComments(helper.result.getSelfEvaluation(), helper.evaluation.p2pEnabled)%></td>
						</tr>
					<tr class="resultSubheader">
						<td width="15%"><%=byReviewee ? "From" : "To"%> Student</td>
						<td width="5%">Contribution</td>
						<td width="40%">Comments</td>
						<td width="40%">Messages</td>
					</tr>
					<%
						for(SubmissionData sub: (byReviewee ? helper.result.incoming : helper.result.outgoing)){ if(sub.reviewer.equals(sub.reviewee)) continue;
					%>
						<tr>
							<td><b><%=InstructorEvalSubmissionViewHelper.escapeForHTML(byReviewee ? sub.reviewerName : sub.revieweeName)%></b></td>
							<td><%= InstructorEvalSubmissionViewHelper.printSharePoints(sub.normalizedToInstructor,false) %></td>
							<td><%= InstructorEvalSubmissionViewHelper.printJustification(sub) %></td>
							<td><%= InstructorEvalSubmissionViewHelper.printComments(sub, helper.evaluation.p2pEnabled) %></td>
						</tr>
					<%	} %>
				</table>
				<br><br>
				<% } %>
				<div class="centeralign">
					<input type="button" class="button" id="button_back" value="Close"
							onclick="window.close()">
					<input type="button" class="button" id="button_edit" value="Edit Submission"
							onclick="window.location.href='<%= helper.getInstructorEvaluationSubmissionEditLink(helper.evaluation.course, helper.evaluation.name, helper.student.email) %>'">
				</div>
				<br><br>
			</div>
		</div>
	</div>

	<div id="frameBottom">
		<jsp:include page="<%= Common.JSP_FOOTER %>" />
	</div>
</body>
</html>