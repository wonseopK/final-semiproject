<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="data.dao.EcommentDao"%>
<%@page import="data.dto.EcommentDto"%>
<%@page import="data.dao.EpartiDao"%>
<%@page import="data.dto.EpartiDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.EventDto"%>
<%@page import="data.dao.EventDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Liquor Store - Free Bootstrap 4 Template by Colorlib</title>
 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
 <style type="text/css">
 
 body{
 	font-family: 'Noto Sans KR', sans-serif;
 	background-color: WhiteSmoke;
 }
 .box{
 	width: 150px;
 	height: 150px;
 	border-radius: 70px;
 	overflow: hidden;
 }
 .profile{
 	width: 100%;
 	height: 100%;
 	object-fit: cover;
 }
 div.mainimg{

		background-color: white;
		width: 120px;
		height: 160px;
		border-radius: 10px;
		-moz-border-radius: 10px;
		-khtml-border-radius: 10px;
		-webkit-border-radius: 10px;
		overflow: hidden;
		text-align: center;
		float:left;
		margin: 0px 0px 20px 20px;
	}
 div.header {
  position: fixed;
  bottom: 0;
  width: 100%;
  background-color: white;
  z-index:1;
  border-top: solid 2px lightgray;
  padding-top:20px;
  padding-bottom:20px;
  height: 130px;
}

.partitb{
	width: 700px;
	table-layout: fixed;
}
.subbg{
	background-color: White;
	height: 230px;
	border-top: solid 2px lightgray;
	border-bottom: solid 2px lightgray;
	
}

.subbg1{
position: absolute;

left: -9999px;
/* right: -9999px; */
right: 0;
}
div.box1{
	float:left;
}

div.ta{
	display: inline-block;
	background-color:white;
	width: 340px;
	height: 300px;
	border-radius: 20px;
	-moz-border-radius: 20px;
	-khtml-border-radius: 20px;
	-webkit-border-radius: 20px;
	overflow: hidden;
	padding:20px 20px 20px 20px;
	margin-right: 20px;
	
}

 </style>
 <script type="text/javascript">
 $(function(){
	
	 var check = <%= request.getParameter("check")%>;
	 if(check){
		 alert("?????? ?????????????????????.");
		 history.replaceState({}, null, location.pathname);
	 }
	 
		//?????? ?????? ?????????
		$("span.edel").click(function(){
			var idx=$(this).attr("idx");
			//alert(idx);
			$.ajax({
				type:"get",
				dataType:"html",
				url:"event/ecommentdelete.jsp",
				data:{"idx":idx},
				success:function(data){
					//????????????
					location.reload();
				}
			});
		});
		//??????????????? ????????? ???????????? ??????
		$('div.ecommnetupdateform').hide();
		//?????? ????????? ??????????????? ?????????/???????????? ??????
		$("span.eupdate").click(function(){
			var idx=$(this).attr("idx");
			$("#ecommnetupdateform"+idx).show();
			$("div.tbcomment"+idx).hide();
		});
		
});
 
 
 
 
 </script>
 </head>
 <body>
<%
String num = request.getParameter("num");
String currentPage = request.getParameter("currentPage");
if(currentPage==null)
	currentPage="1";
//key??? ??????????????? ?????? ???????????? ??? ????????? null???
String key = request.getParameter("key");
String check = request.getParameter("check");

EventDao dao = new EventDao();
//???????????? ????????? ???????????? ????????? 1 ????????????
if(key!=null)
	dao.updateReadcount(num);

//num ??? ???????????? dto ??????
EventDto dto = dao.getData(num);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy??? MM??? dd??? E??????");
SimpleDateFormat ssdf = new SimpleDateFormat("MM??? dd??? (E), a H:mm");

//?????????,????????? ??????
String myid = (String)session.getAttribute("myid");
LoginDao Ldao = new LoginDao();
LoginDto Ldto = Ldao.getUserInfo(2, myid);

//????????? ?????? ????????? ????????? ????????????
String loginok = (String)session.getAttribute("loginok");

//?????????
EcommentDao edao = new EcommentDao();


SimpleDateFormat esdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>
	

   <!--  <section style="height: 100px;background-image: url('images/bg_2.jpg');"  data-stellar-background-ratio="0.5">
    </section> -->
    
    
<div class="header">
	<nav style="text-align:center;">
    <span style="font-size: 15pt;"><%=sdf.format(dto.getWriteday()) %></span><br>
   	<span style="font-size: 20pt; font-wight:400;"><b><%=dto.getSubject() %></b></span>
   	
   	<%
  // 	String chid = epdao
  // 	epdto.getMyid().equals(myid);
   	%>
   	
   	<%
	if(loginok!=null){//???????????? ???????????????????????? ????????? ??????
	%>
  	<form action="event/epartiaction.jsp" method="post">
   	<input type="hidden" name="num" id="num" value="<%=dto.getNum()%>">
	<input type="hidden" name="myid" id="myid" value="<%=myid%>">
	<input type="hidden" name="currentPage" id="currentPage" value="<%=currentPage%>">
   	<span style="font-size: 15pt;">
   	<button type="submit" class="btn btn-danger pull-right"
	style="width: 200px; height: 70px; border-radius: 5px;
	-moz-border-radius: 5px;
	-khtml-border-radius: 5px;
	-webkit-border-radius: 5px;
	margin-top:-70px;"
	onclick="submitContents(this)">????????? ??????</button>
	</span>
	</form>
	</nav>
	<%}else{ %>
		<div style="float:right; margin-right:40px;">????????? ??? ????????????</div>
	<%} %>
</div>

    <!-- ?????? -->
   <section>
   	<div class="subbg">
   	<div class="container">
  	<span style="font-size: 15pt;"><%=sdf.format(dto.getWriteday()) %></span><br>
   	<h2 style="margin-top: -10px; font-size: 35pt; font-wight:700;"><b><%=dto.getSubject() %></b></h2>
  	<img style="border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	overflow: hidden;
	width: 70px;
	height: 70px;"
	align="left"
	src="images/person_4.jpg"/>
	<p style="margin-left: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;Hosted by<br>
	&nbsp;&nbsp;&nbsp;&nbsp;<b style="font-size:20pt; font-wight:700;"><%=dto.getWriter() %></b></p>
  	</div>
  	</div>
   </section>
   
 <div class="container">  
   <!-- ?????? ?????? -->
    <section>
    <div style="margin-bottom:200px;">
	    <div>
			<img src="/Team/save/<%=dto.getPhotoname()%>" 
			onerror="this.style.display='none'" 
			style="margin-bottom:30px; margin-top:50px;" width="800" height="500">
		</div>
		<div>
			<h1 class="mb-4">????????????</h1>
			<p style="font-size:20pt;"><%=dto.getContent()%></p>
		</div>
	</div>
	</section>
   
   <!-- ?????????????????? -->
  <section>
	<%
	EpartiDto epdto = new EpartiDto();
   	EpartiDao epdao = new EpartiDao();
   	List<EpartiDto> plist=epdao.getAllEparti(dto.getNum());
  	%>
  <span style="font-size:20pt;" num="<%=epdto.getIdx()%>">?????????<b>(<%=plist.size()%>)</b><br></span>
  <span style="display: inline-block; width: 73%; text-align: right;">
  <a href="index.jsp?main=event/epartilist.jsp?num=<%=dto.getNum()%>">????????????</a></span>
  <div class="container">
  <div class="partitb">
  	<%
	int n = 0;
   	for(EpartiDto eptdto: plist)
	{
	if(n>9){
		break;
	}%>
		<div class="mainimg">
			<div>
			<img style="border-radius: 70px;
					-moz-border-radius: 70px;
					-khtml-border-radius: 70px;
					-webkit-border-radius: 70px;
					overflow: hidden;
					width: 60px;
					height: 60px;"
					src="images/profile.PNG"/>
			</div>
			<div>
			<span><b><%=eptdto.getMyid() %></b></span>
			</div>
			<div><span>??????</span></div>
		</div>
	<%n++;}
	%>
	</div>
</div>
<div style="padding-bottom:200px;">
</div>
   </section>
   
<section>
<!-- ?????? & ?????? -->
<div>
<table>	
	<tr>
		<td>
			<%
			List<EcommentDto> elist=edao.getAllEcomment(dto.getNum());
			EcommentDto edto = new EcommentDto();
			EcommentDao eldao = new EcommentDao();
			%>	
			<span class="comment" style="cursor: pointer; font-size:20pt;" num="<%=edto.getIdx()%>">?????? <%=elist.size()%></span>
					<br><br>
					<span class="glyphicon glyphicon-heart"
					 style="color: red;font-size: 0px"></span>
					<div class="ecomment" style="margin-left: 30px;">
						<div class="commentlist">
						 
						 <%
					//	 String[] arr = {"images/person_1","images/person_2","images/person_3","images/person_4"};
						 int ran = 0;
						 for(EcommentDto eldto:elist)
						 {%>
								
								 <%  ran = (int)(Math.random()*4)+1;%>
					<div class="container">
					<div class="box1">			 
					<img style="border-radius: 70px;
					-moz-border-radius: 70px;
					-khtml-border-radius: 70px;
					-webkit-border-radius: 70px;
					overflow: hidden;
					width: 40px;
					height: 40px;
					margin-right: 20px;"
					align="left"
					src="images/profile.PNG"/>
					
					</div>
					<div class="box1">
					<div class="ecommnetupdateform" id="ecommnetupdateform<%=eldto.getIdx()%>">
						<form action="event/ecommentupdateaction.jsp" method="post">
							<input type="hidden" name="idx" value="<%=eldto.getIdx()%>">
							<input type="hidden" name="currentPage" value="<%=currentPage%>">
							<input type="hidden" name="num" value="<%=dto.getNum()%>">
						<table style="margin-bottom:30px;">
							 <tr>
								<td width="480">
									<textarea style="width: 630px;height: 100px;"
									name="content" required="required"
									class="form-control"><%=eldto.getContent()%></textarea>
								</td>
								<td>
									<button type="submit" class="btn btn-info"
									style="width: 70px;height:70px;">??????</button>
									
									<button type="button" class="btn btn-info"
						  	  		style="width: 70px;height:70px;"
						  	  		onclick="window.location.reload()">??????</button>
								</td>
							</tr>
						</table>
						</form>	
					</div>
					
					<div class="tbcomment<%= eldto.getIdx()%>">
						 <table class="commenttb" style="border-radius: 10px;
								-moz-border-radius: 10px;
								-khtml-border-radius: 10px;
								-webkit-border-radius: 10px;
								width: 700px; background-color: white;
								max-width:700px;
								table-layout: fixed;">
							<tr>
								<td>
									<%										
									//???????????? ??????
									String aname = eldto.getMyid();
									%>
									<b><%=aname%></b>
									&nbsp;
									<%
									//??? ???????????? ????????? ???????????? ????????????
									if(dto.getWriter().equals(eldto.getMyid())){%>
										<span style="color: red;">?????????</span>
								</td>
									<%}
									%>
								
								
									<%
									//?????? ????????? ????????????????????? ???????????? ???????????? ?????? ????????????
									//?????? ????????? ????????? ??????
									if(loginok!=null && eldto.getMyid().equals(myid)){%>
										<td style="text-align:right; font-size:0.8em">
										<!-- <a href="index.jsp?main=event/ecommentupdateform.jsp?num=<%= dto.getNum()%>&idx=<%=eldto.getIdx()%>&currentPage=<%=currentPage%>" 
										style="color: black;">??????</a> -->
										<span class='eupdate'
										idx="<%=eldto.getIdx()%>"
										style="color:margenta;cursor: pointer;">??????&nbsp;</span>
										
										<span class='edel'
										idx="<%=eldto.getIdx()%>"
										style="color:margenta;cursor: pointer;margin-left: 10px;margin-right:10px;">??????&nbsp;</span>
										</td>
									<%}
									%>
								
							</tr>
							<tr>
								<td style="max-width:650px;">
									<span style="font-size: 10pt;">
										<%=eldto.getContent()%>
									</span>
									<br>									
								</td>
							</tr> 
						</table>
						<span style="font-size: 9pt;color: gray;margin-left: 20px;">
							<%=sdf.format(eldto.getWriteday()) %>
							<br>
						</span>
						</div>
						</div>
						</div>
						<br><br>
						 <%}
						 %>
						 
						 <%
						if(loginok!=null){//???????????? ???????????????????????? ????????? ??????
						%>
						<div class="ecommnetform" style="margin-top: 100px;">
						  <form action="event/ecommentinsert.jsp" method="post">
						  	<input type="hidden" name="num" value="<%=dto.getNum()%>">
						  	<input type="hidden" name="myid" value="<%=myid%>">
						  	<input type="hidden" name="currentPage" value="<%=currentPage%>">
						  	<table>
						  	  <tr>
						  	  	<td width="480">
						  	  		<textarea style="width: 730px;height: 70px;"
						  	  		name="content" required="required"
						  	  		class="form-control"
						  	  		placeholder="????????? ???????????????"></textarea>
						  	  	</td>
						  	  	<td>
						  	  		<button type="submit" class="btn btn-info"
						  	  		style="width: 70px;height:70px;">??????</button>
									
						  	  	</td>
						  	  </tr>
						  	</table>
						  </form>	
						</div>
						<br>
						<%} %>
						 
						</div>
					</div>
				</td>
			</tr>
			
		</table>
</div>
</section>
	
	
<%

EventDto pdto = dao.getPre(num);
EventDto ndto = dao.getNext(num);


%> 

<hr style="margin-top:100px;">

<h2 class="mb-3" style="color:gray; margin-top:40px;">?????? ?????????</h2>
	<a href="index.jsp?main=event/eventlist.jsp">
	<p style="text-align:right; color:gray;">????????????</p></a>

 <%
    if(dto.getNum()!=null){
  %>

<div class="ta">
	<p class="mb-4">
	<span style="font-size:9pt;"><%=ssdf.format(dto.getWriteday()) %>&nbsp;EDT</span><br>
	<a style="font-size:13pt; color: gray;"
	href="index.jsp?main=event/eventdetail.jsp?num=<%=dto.getNum()%>&currentPage=<%= currentPage%>&key=list">
	<b>
	<%
	if(dto.getSubject().length()>=20){%>
	<%=dto.getSubject().substring(0, 20) %>
	...
	<% }else{%>
	<%=dto.getSubject()%>
	<%} %>
	</b></a>
	
	<br>
	<span>
	
	<%
	if(dto.getContent().length()>=50){%>
	<%=dto.getContent().substring(0, 50) %>
	...
	<% }else{%>
	<%=dto.getContent()%>
	<%} %>
	
	</span>
	
	<br><br><br>
	<img style="border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	overflow: hidden;
	width: 70px;
	height: 70px;"
	align="left"
	src="/Team/save/<%=dto.getPhotoname()%>"
	onerror="this.src='./images/image_4.jpg'"/>&nbsp;&nbsp;
	????????? ?????????
	</p>
</div>

<%} %>
<%
   if(pdto.getNum()!=null){
 %>
 
 <div class="ta">
	<p class="mb-4">
	<span style="font-size:9pt;"><%=ssdf.format(pdto.getWriteday()) %>&nbsp;EDT</span><br>
	<a style="font-size:13pt; color: gray;"
	href="index.jsp?main=event/eventdetail.jsp?num=<%=pdto.getNum()%>&currentPage=<%= currentPage%>&key=list">
	<b>
	<%
	if(pdto.getSubject().length()>=20){%>
	<%=pdto.getSubject().substring(0, 20) %>
	...
	<% }else{%>
	<%=pdto.getSubject()%>
	<%} %>
	</b></a>
	
	<br>
	<span>
	
	<%
	if(pdto.getContent().length()>=50){%>
	<%=pdto.getContent().substring(0, 50) %>
	...
	<% }else{%>
	<%=pdto.getContent()%>
	<%} %>
	
	</span>
	
	<br><br><br>
	<img style="border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	overflow: hidden;
	width: 70px;
	height: 70px;"
	align="left"
	src="/Team/save/<%=pdto.getPhotoname()%>"
	onerror="this.src='./images/image_4.jpg'"/>&nbsp;&nbsp;
	????????? ?????????
	</p>
</div>
 <%} %>
<%
   if(ndto.getNum()!=null){
 %>
 
 <div class="ta">
	<p class="mb-4">
	<span style="font-size:9pt;"><%=ssdf.format(ndto.getWriteday()) %>&nbsp;EDT</span><br>
	<a style="font-size:13pt; color: gray;"
	href="index.jsp?main=event/eventdetail.jsp?num=<%=ndto.getNum()%>&currentPage=<%= currentPage%>&key=list">
	<b>
	<%
	if(ndto.getSubject().length()>=20){%>
	<%=ndto.getSubject().substring(0, 20) %>
	...
	<% }else{%>
	<%=ndto.getSubject()%>
	<%} %>
	</b></a>
	
	<br>
	<span>
	
	<%
	if(ndto.getContent().length()>=50){%>
	<%=ndto.getContent().substring(0, 50) %>
	...
	<% }else{%>
	<%=ndto.getContent()%>
	<%} %>
	
	</span>
	
	<br><br><br>
	<img src="/Team/save/<%=ndto.getPhotoname()%>"
	onerror="this.src='./images/image_4.jpg'"
	style="border-radius: 70px;
	-moz-border-radius: 70px;
	-khtml-border-radius: 70px;
	-webkit-border-radius: 70px;
	overflow: hidden;
	width: 70px;
	height: 70px;"
	align="left"/>&nbsp;&nbsp;
	????????? ?????????
	</p>
</div>
 
  <%} %>


		<section class="ftco-counter ftco-section ftco-no-pt ftco-no-pb img bg-light" id="section-counter">
    	<div class="container">
    		<div class="row">
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-4 mb-4">
              <div class="text align-items-center">
                <strong class="number" data-number="3000">0</strong>
                <span>Our Satisfied Customers</span>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-4 mb-4">
              <div class="text align-items-center">
                <strong class="number" data-number="115">0</strong>
                <span>Years of Experience</span>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-4 mb-4">
              <div class="text align-items-center">
                <strong class="number" data-number="100">0</strong>
                <span>Kinds of Liquor</span>
              </div>
            </div>
          </div>
          <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
            <div class="block-18 py-4 mb-4">
              <div class="text align-items-center">
                <strong class="number" data-number="40">0</strong>
                <span>Our Branches</span>
              </div>
            </div>
          </div>
        </div>
    	</div>
    </section>
</div>
     

    
  </body>
</html>