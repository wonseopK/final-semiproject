package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import data.dto.ProductDto;
import mysql.db.DbConnect;

public class ProductDao {

	DbConnect db = new DbConnect();
	//insert
	public void insertSmart(ProductDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into product (writer,subject,content,photoname,writeday) values (?,?,?,?,now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			//���ε�
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPhotoname());
			
			//����
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	
	//��ü����
	public int getTotalCount(String writer) {
		
		int n = 0;
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		/* String sql = "select count(*) from product"; */
		
		String sql = "select count(*) from product where writer=?";
		 
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				n = rs.getInt(1);

			

		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return n;
	}
	
	

	public List<ProductDto> getTotal() {
		
		List<ProductDto> list = new Vector<ProductDto>();
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from Product";
		
		try {
			pstmt = conn.prepareStatement(sql);
			//���ε�
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPhotoname(rs.getString("photoname"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				//list�� �߰�
				list.add(dto);
				
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//���������� �ʿ��� ��ŭ�� ����
	public List<ProductDto> getAllDatas() {
		
		List<ProductDto> list = new Vector<ProductDto>();
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from Product order by num desc";
//		String sql = "select * from Product where writer=? order by num desc";
		
		try {
			pstmt = conn.prepareStatement(sql);
			//���ε�
			/* pstmt.setString(1, writer); */
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPhotoname(rs.getString("photoname"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				//list�� �߰�
				list.add(dto);
				
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	
	//���������� �ʿ��� ��ŭ�� ����
	public List<ProductDto> getList(String writer,int start,int perpage) {
		
		List<ProductDto> list = new Vector<ProductDto>();
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from Product where writer=? order by num desc limit ?,?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			//���ε�
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, perpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setNum(rs.getString("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setPhotoname(rs.getString("photoname"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				//list�� �߰�
				list.add(dto);
				
			}
			

		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//num�� �ش��ϴ� dto��ȯ (��ȯ �޾Ƽ� ������..?)
	   public ProductDto getData(String num) {
		   ProductDto dto = new ProductDto();
	      Connection conn = db.getConnection();
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "select * from product where num=?";

	      try {
	         pstmt = conn.prepareStatement(sql);
	         //���ε�
	         pstmt.setString(1, num);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
					dto.setNum(rs.getString("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPhotoname(rs.getString("photoname"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setWriteday(rs.getTimestamp("writeday"));
	         }
	      } catch (Exception e) {
	      } finally {
	         db.dbClose(rs, pstmt, conn);
	      }
	      return dto;
	   }

	   
	   //��ȸ�� ����
	   public void updateReadcount(String num) {
	      Connection conn = db.getConnection();
	      PreparedStatement pstmt = null;
	      String sql = "update product set readcount=readcount+1 where num=?";

	      try {
	         pstmt = conn.prepareStatement(sql);
	         //���ε�
	         pstmt.setString(1,num);

	         //����
	         pstmt.execute();
	      } catch (Exception e) {
	      } finally {
	         db.dbClose(pstmt, conn);
	      }
	   }
	   
		//��� �߰��� ���� ������ num�� ����
	   public String getMaxNum() {
		  ProductDto dto = new ProductDto();
	      Connection conn = db.getConnection();
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "select max(num) from product";
	      String num = "";

	      try {
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();

	         if(rs.next()) {
					num = rs.getString(1);
	         }
	      } catch (Exception e) {
	      } finally {
	         db.dbClose(rs, pstmt, conn);
	      }
	      return num;
	   }

	   public void deleteProduct(String num) {
		      Connection conn = db.getConnection();
		      PreparedStatement pstmt = null;
		   String sql = "delete from product where num=?";
		   
		try {
			pstmt = conn.prepareStatement(sql);
			
			//���ε�
			pstmt.setString(1, num);
			//����
			pstmt.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			db.dbClose(pstmt, conn);
		}
	   }
	   
	   
	   public void updataProduct(ProductDto dto) {
		   Connection conn = db.getConnection();
		   PreparedStatement pstmt = null;
		   String sql = "update product set writer=?, subject=?,content=?, photoname=? where num=?";
		   
		   try {
			   pstmt = conn.prepareStatement(sql);
			   
			   //���ε�
			   pstmt.setString(1, dto.getWriter());
			   pstmt.setString(2, dto.getSubject());
			   pstmt.setString(3, dto.getContent());
			   pstmt.setString(4, dto.getPhotoname());
			   pstmt.setString(5, dto.getNum());
			   //����
			   pstmt.execute();
		   } catch (Exception e) {
			   // TODO: handle exception
		   }finally {
			   db.dbClose(pstmt, conn);
		   }
	   }
	   
		//��ü����
		public int getSearchTotalCount(String search) {
			
			int n = 0;
			
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			/* String sql = "select count(*) from product"; */
			
			String sql = "select count(*) from product where subject like '%"+search+"%' or writer like '%"+search+"%'";
			System.out.println(sql);
			try {
				pstmt = conn.prepareStatement(sql);
				/*
				 * pstmt.setString(1, "%"+search+"%"); pstmt.setString(2, "%"+search+"%");
				 */
				rs = pstmt.executeQuery();
				
				if(rs.next())
					n = rs.getInt(1);

				

			} catch (Exception e) {
				// TODO: handle exception
			}finally {
				db.dbClose(rs, pstmt, conn);
			}
			
			return n;
		}
		
		public List<ProductDto> getSearch(String search,int start,int perpage) {
			
			List<ProductDto> list = new Vector<ProductDto>();
			
			Connection conn = db.getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "select * from product where subject like '%"+search+"%' or writer like '%"+search+"%' order by num desc limit ?,?";
			System.out.println(sql);
			try {
				pstmt = conn.prepareStatement(sql);
				
				//pstmt.setString(1, "%"+search+"%");
				//pstmt.setString(2, "%"+search+"%");
				pstmt.setInt(1, start);
				pstmt.setInt(2, perpage);
				
				//���ε�
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDto dto = new ProductDto();
					dto.setNum(rs.getString("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setPhotoname(rs.getString("photoname"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setWriteday(rs.getTimestamp("writeday"));
					
					//list�� �߰�
					list.add(dto);
					
				}
				
				
			} catch (Exception e) {
				// TODO: handle exception
			}finally {
				db.dbClose(rs, pstmt, conn);
			}
			System.out.println("count:"+list.size());
			return list;
		}
		
}

