
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/common/meta.jsp"%>
<%@ include file="/WEB-INF/jsp/common/title.jsp"%>
<script type="text/javascript">
	$(function() {
		var form = $("form[name=listForm]");
		initGrid(form);
		var win = $("#win").window({
			title : "新增",
			modal : true
		});
		var handler = function() {
			var hid = function() {
				win.window("close");
			};
			$("input[type='button']").click(hid);
		};
		$("#btn_add").click(
				function() {
					win.window('open');
					$("#msg").load(
							"${ctx}/tlogBusinesslogController.do?method=add",
							"", handler);
				});
		$("#btn_modify")
				.click(
						function() {
							var ids = getSelected(true);
							if (ids) {
								win.window('open');
								$("#msg")
										.load(
												"${ctx}/tlogBusinesslogController.do?method=modify",
												{
													id : ids
												}, handler);
							}
						});
		$("#btn_remove").click(
				function() {
					if (!confirm("确定删除选中的记录吗？"))
						return;
					form.attr("action",
							"${ctx}/tlogBusinesslogController.do?method=delete&ids="
									+ getSelected());
					form.submit();
				});
		$("#btn_search").click(function() {
			form.submit();
		});
		$("#container").layout();
	});
</script>
</head>
<body>
	<form method="post" target="_self"
		action="
		${ctx}/tlogBusinesslogController.do?method=list "
		name="listForm" style="width: 100%;height: 90%;">
		<input type="hidden" name="error" value='' />
		<table class="FormView" border="0" cellspacing="1" cellpadding="0">
			<col class="Label" />
			<col class="Data" />
			<col class="Label" />
			<col class="Data" />
			<col class="Label" />
			<col class="Data" />
			<col class="Label" />
			<col class="Data" />
			<col class="Label" />
			<col class="Data" />
			<tr>
				<td align="right"><fmt:message key="tlogbusinesslog.userid" />
				</td>
				<td><input type="text" class="text" name="srh_userid"
					value="${userid}"></td>
					
				<td align="right"><fmt:message key="tlogbusinesslog.orgid" />
				</td>
				<td><input type="text" class="text" name="srh_orgid"
					value="${orgid}"/>
				</td>
			</tr>
			<tr>
				<td align="right"><fmt:message key="tlogbusinesslog.createDate" />
				</td>
				<td><input type="text" name="srh_beginDate"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
					value="${beginDate}"/> 至 <input type="text"
					name="srh_endDate"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
					value="${endDate}"/>
				</td>
				<td align="right"><fmt:message key="tlogbusinesslog.custip" />
				</td>
				<td><input type="text" class="text" name="srh_custip"
					value="${custip}"/>
				</td>
			</tr>
		</table>
	<div class="easyui-layout" style="border: none;" fit="true" id="container">
			<div class="datagrid-toolbar" region="north" style="height: 31px;"
				border="false">
				<hih:auth operate="DELETE" module="LOG_BUSINESSLOG" value="button.remove"
					id="btn_remove" iconCls="icon-remove" />
				<hih:auth operate="QUERY" module="LOG_BUSINESSLOG" value="button.query"
					id="btn_search" iconCls="icon-search" />
			</div>
			<div id="grid-body" class="grid-body" region="center">
				<table class="data-grid" cellspacing="0" cellpadding="0">
					<thead>
						<tr class="data-grid-header">
							<th><input type="checkbox" id="selectAll" /></th>
							<th width="120"><fmt:message
									key="tlogbusinesslog.createDate" /></th>
							<th width="120"><fmt:message key="tlogbusinesslog.custip" />
							</th>
							<th width="120"><fmt:message key="tlogbusinesslog.moduleid" />
							</th>
							<th width="120"><fmt:message key="tlogbusinesslog.operateid" />
							</th>
							<th width="120"><fmt:message key="tlogbusinesslog.orgid" />
							</th>
							<th width="120"><fmt:message key="tlogbusinesslog.userid" />
							</th>
						</tr>
					</thead>
					<c:forEach items="${list}" var="tlogbusinesslog"
						varStatus="paStatus">
						<tr>
							<td width="100" class="checkbox"><input type="checkbox"
								name="ckh" value="${tlogbusinesslog.logid}" /></td>
							<td width="120">${tlogbusinesslog.createDate}</td>
							<td width="120">${tlogbusinesslog.custip}</td>
							<td width="120">${tlogbusinesslog.moduleid}</td>
							<td width="120">${tlogbusinesslog.operateid}</td>
							<td width="120">${tlogbusinesslog.orgid}</td>
							<td width="120">${tlogbusinesslog.userid}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<jsp:include page="/WEB-INF/jsp/common/page.jsp" />
		</div>
	</form>
	<div id="win" closed="true" style="width: 450px; height: 350px;">
		<div id="msg"></div>
	</div>
</body>
</html>
