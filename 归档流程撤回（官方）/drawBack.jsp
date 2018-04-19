<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE></TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
  <jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
  <%@ page import="weaver.general.Util" %>
  <%@ page import="java.util.*" %>
  <%@page contentType="text/html;charset=gb2312"%>

 </HEAD>
	<%
		request.setCharacterEncoding("gb2312");
		String requestid=Util.null2String(request.getParameter("requestid"));
		String nodeid=Util.null2String(request.getParameter("nodeid"));
		String status = Util.null2String(request.getParameter("status"));
		String userid = Util.null2String(request.getParameter("userid"));
		String username = Util.null2String(request.getParameter("username"));
		String password = Util.null2String(request.getParameter("password"));
		String groupDetailId = Util.null2String(request.getParameter("groupDetailId"));
		String receiveDate = Util.null2String(request.getParameter("receiveDate"));
		String receiveTime = Util.null2String(request.getParameter("receiveTime"));
		String sql = "";
		String workflowid = "";
		String workflowtype="";
		String afterNodes = "";
		ArrayList<ArrayList<String>> groupDetailIds = new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> nodes = new ArrayList<ArrayList<String>>();
		if(username.equals("administrator")&&password.equals("p@ssw0rd")){
			if(!request.equals("")){
				//查找workflowid,workflowtype,所有节点
				sql = "select t.workflowid, t1.workflowtype from workflow_requestbase t, workflow_base t1 where t.workflowid=t1.id and t.requestid="+requestid;
				rs.executeSql(sql);
				if(rs.next()){
					workflowid=Util.null2String(rs.getString("workflowid"));
					workflowtype = Util.null2String(rs.getString("workflowtype"));
				}
				//--查找到所有的节点及该节点之后的节点
				sql = "select workflow_nodebase.id,workflow_nodebase.nodename  from workflow_flownode, workflow_nodebase where (workflow_nodebase.IsFreeNode is null or workflow_nodebase.IsFreeNode != '1')"+
   "and workflow_nodebase.id = workflow_flownode.nodeid   and workflowid = "+workflowid+" order by workflow_flownode.nodetype, workflow_nodebase.id";
				rs.executeSql(sql);
				boolean after = false;
				while(rs.next()){
					String tmpnodeid=Util.null2String(rs.getString("id"));
					ArrayList<String> tmpArr = new ArrayList<String>();
					tmpArr.add(tmpnodeid);
					tmpArr.add(Util.null2String(rs.getString("nodename")));
					nodes.add(tmpArr);
					if(tmpnodeid.equals(nodeid)){
						after = true;
						continue;
					}
					if(after){
						if(afterNodes.equals(""))afterNodes = tmpnodeid;
						else{afterNodes +=","+tmpnodeid;}
					}
				}
				if(!nodeid.equals("")){
					//查找所有的groupdetailid供选择
					sql = "select * from workflow_nodegroup t, workflow_groupdetail t1 where t.id = t1.groupid and t.nodeid="+nodeid;
					rs.executeSql(sql);
					while(rs.next()){
						ArrayList<String> tmpArr = new ArrayList<String>();
						tmpArr.add(Util.null2String(rs.getString("id")));
						tmpArr.add(Util.null2String(rs.getString("groupname")));
						groupDetailIds.add(tmpArr);
					}

					//以下开始执行修复
					if(!status.equals("") && !userid.equals("") && !groupDetailId.equals("") && !receiveDate.equals("") && !receiveTime.equals("")){
						sql = "update workflow_requestbase   set  status = '"+status+"', currentnodeid = "+nodeid+",currentnodetype='1' where requestid = "+requestid;
						rs.executeSql(sql);
						out.println(sql+"<br/>");
						out.println("更新workflow_requestbase成功！<br/>");
						out.flush();
						sql = " update workflow_currentoperator set iscomplete='0' where requestid="+requestid;
						rs.executeSql(sql);
						out.println(sql+"<br/>");
						out.println("更新workflow_currentoperator表（iscomplete）成功！<br/>");
						out.flush();
						sql = "delete from workflow_currentoperator where requestid="+requestid+" and nodeid in ("+afterNodes+")";
						rs.executeSql(sql);
						out.println(sql+"<br/>");
						sql = "delete from workflow_currentoperator where requestid="+requestid+" and nodeid = "+nodeid+" and isremark != '0'";
						rs.executeSql(sql);
						out.println(sql+"<br/>");
						out.println("删除后续节点的workflow_currentoperator成功！<br/>");
						out.flush();
						sql = "select * from workflow_currentoperator where requestid="+requestid+" and nodeid = "+nodeid +" and isremark='0' and userid="+userid;
						rs.executeSql(sql);
						if(!rs.next()){
							sql = "insert into workflow_currentoperator (requestid, userid, groupid, workflowid, workflowtype, isremark, usertype, nodeid, agentorbyagentid,  agenttype,"+
									" showorder, receivedate, receivetime, viewtype, iscomplete, islasttimes, groupdetailid) values("+requestid+","+userid+", 0,"+workflowid+","+workflowtype+","+
									"'0', '0',"+  nodeid+",-1,0, 1,'"+receiveDate+"','"+receiveTime+"', '0', 0,  1, "+groupDetailId+")";
							rs.executeSql(sql);
							out.println(sql+"<br/>");
							out.println("插入当前节点的workflow_currentoperator成功！<br/>");
							out.flush();
						}
						else{
							out.println("插入当前节点的workflow_currentoperator的操作者已经存在，无需再次插入！<br/>");
							out.flush();
						}
						//更新workflow_nownode表
						sql = "update workflow_nownode   set nownodeid = "+nodeid+", nownodetype = '1' where requestid = "+requestid;
						rs.executeSql(sql);
						out.println(sql+"<br/>");
						out.println("更新workflow_nownode成功！<br/>");
						out.flush();
						//删除workflow_requestlog记录
						sql = " delete from workflow_requestlog where requestid="+requestid+" and nodeid in ("+afterNodes+","+nodeid+")";
						rs.executeSql(sql);
						out.println(sql+"<br/>");
						out.println("删除后续节点的workflow_requestlog成功！<br/>");
						out.flush();
						out.println("修复完成");
						}
					else{
						out.println("<script type='text/javascript'>alert('必要信息填写不完整！');</script>");
					}
				}
				
			}
		}else if(!username.equals("")||!password.equals("")){
			password = "";
			out.println("<script type='text/javascript'>alert('用户名或密码错误！');</script>");
		}
	%>
 <BODY>
		<form method="post" action="drawBack.jsp" id="fixForm" name="fixForm" onsubmit="if(confirm('确定执行修复吗？')){return true;}else{return false;}">
			<table border="1" width="100%">
				<tr>
					<td colspan="5" align="center"><font color="red"><b>修复前请备份数据库！！！</b></font></td>
				</tr>
				</tr>
				<tr>
					<td>用户名：<input class="InputStyle styled input" type="text" id="username" name="username" value="<%= username %>" /></td>
					<td>密&nbsp;&nbsp;码：<input class="InputStyle styled input" type="password" id="password" name="password" value="<%= password %>" /></td>
				</tr>
				<tr>
				<td class="Field" style="width:20%">请求ID：<input class="InputStyle styled input" type="text" id="requestid" name="requestid" value="<%= requestid %>" /></td>
				<td class="Field">恢复节点:
					<select class="wuiBrowser" id="nodeid" name="nodeid" value='<%=nodeid%>'>
						<option value=''></option>
						<%
							 for (Iterator it = nodes.iterator(); it.hasNext();) {
								ArrayList<String> s = (ArrayList<String>)it.next();
								String id = s.get(0);
								String nodename = s.get(1);
						%>
							<option value='<%=id%>' <%if(nodeid.equals(id)){%>selected="selected"<%}%>><%=nodename%></option>
						<%
							 }
						%>
					</select>
				</td>
				<td class="Field">流程状态：<input class="wuiBrowser" id="status" name="status" value="<%= status %>" /></td>
				<td class="Field">userID：<input class="wuiBrowser" id="userid" name="userid" value="<%= userid %>" /></td>
				</tr><tr>
				<td class="Field">节点操作者：
					<select class="wuiBrowser" id="groupDetailId" name="groupDetailId" value="<%= groupDetailId %>" >
						<option value=''></option>
						<%
							 for (Iterator it = groupDetailIds.iterator(); it.hasNext();) {
								ArrayList<String> s =  (ArrayList<String>)it.next();
								String id = s.get(0);
								String opername = s.get(1);
						%>
							<option value='<%=id%>' <% if(groupDetailId.equals(id)){%>selected="selected"<%}%>><%=opername%></option>
						<%
							 }
						%>
					</select>
				</td>
				<td class="Field">接收日期：<input class="wuiBrowser" id="receiveDate" name="receiveDate" value="<%= receiveDate %>" /></td>
				<td class="Field">接收时间：<input class="wuiBrowser" id="receiveTime" name="receiveTime" value="<%= receiveTime %>" /></td>
				<td class="Field"><input type="submit" name="submit" value="执行" /></td>
			</tr>
			</table>
		</form>
</HTML>
