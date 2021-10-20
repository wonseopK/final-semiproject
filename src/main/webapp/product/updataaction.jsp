<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


	//이미지가 업로드된 실제 경로 구하기
	String realPath = getServletContext().getRealPath("/save");//tomcat server에 업로드된 파일명을 db에 저장
	System.out.println(realPath);
	/* D:\bitjava0719\javawork\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MiniProject\save
	여기로 저장됩니다!<콘솔확인하기/
	폴더이동해서 확인해보기*/

	int uploadSize = 1024*1024*16; //2mb
	MultipartRequest multi = null;

	try{
		multi = new MultipartRequest(request,realPath,uploadSize,"utf-8",
				new DefaultFileRenamePolicy());//5개의 생성자가 들어간다.
		//(주의)request가 아닌 multi변수의 모든 폼데이타를 읽어야한다
		/* MultipartRequest 라는 클래스를 사용
  생성자 (request,fileDirectory(업로드할 경로),1024*5(업로드할 파일의 크기),
"euc-kr"(한글타입) , new DefaultFileRenamePolicy() <-같은이름이 있을경우
  다른이름으로 저장 ) */
  
 		String num=multi.getParameter("num");
				
		ProductDao dao = new ProductDao();
		String gu_photoname=dao.getData(num).getPhotoname();
		
		
		String content = multi.getParameter("content");
		String subject = multi.getParameter("subject");
		String writer = multi.getParameter("writer");
		String photoname = multi.getFilesystemName("photo");//실제 업로드된 파일명
		//페이지 번호 읽기
		String currentPage=multi.getParameter("currentPage");
		
			//데이터 읽어서 dto에 넣기
		ProductDto dto = new ProductDto();
		dto.setWriter(writer);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setPhotoname(photoname==null?gu_photoname:photoname);
		dto.setNum(num);
		ProductDao ldao = new ProductDao();
		ldao.updataProduct(dto);
		
		
		String pp = dto.getWriter();
		
		

		//일단 목록으로 간 다음 나중에 detail 페이지로 가는거로 수정하기
	 	String path = "../index.jsp?main=product/productform.jsp?go="+ pp + ".jsp";
		response.sendRedirect(path); 
	}catch(Exception e){
		System.out.println("업로드 오류: " + e.getMessage());
	}

%>