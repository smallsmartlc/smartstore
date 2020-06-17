package smartStore;
import java.sql.*;
public class BuyerBean {
	private String memberID = null ;    
	private String memberName = null; 
	private String pwd = null;			
	private int logontimes = -1;
	private String phoneCode = null;
	private String email = null;
	 
	private static String strDBDriver = "com.mysql.jdbc.Driver";  
	private static String strDBUrl="jdbc:mysql://localhost:3306/store"; 
	private static final String USER_NAME="root";
	private static final String PASS_WORD="password";
	
	private Connection conn =null;            
	private ResultSet rs = null;					
	
	public BuyerBean(String memberID, String memberName, String pwd, String phoneCode, String email) {
		super();
		this.memberID = memberID;
		this.memberName = memberName;
		this.pwd = pwd;
		this.phoneCode = phoneCode;
		this.email = email;
	}


	public BuyerBean (){

		try {
			Class.forName(strDBDriver );
		}

		catch(java.lang.ClassNotFoundException e){
			System.err.println("BuyerBean():" + e.getMessage());
		}	
	}
	

	public int checkLogin(String memberID , String pwd) {
		setMemberID(memberID);
		setPwd(pwd);
		int logintimes = getLogontimes();
		return logintimes+1;
	}
	
	public boolean creatNewBuyer(){
		String strSql = null;
		try {
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
			Statement stmt = conn.createStatement();
			strSql = "insert into buyerinfo (memberID,memberName,pwd,logontimes,phoneCode,email)"
					+ " values( '"+ getMemberID() + "', '" + getMemberName() + "','"+ getPwd()+ "', "+0+ ", '" + getPhoneCode()+ "','"
					+ getEmail() + "')";

			stmt.executeUpdate(strSql);
			stmt.close();
			conn.close();
			
			return true;
		} catch (Exception e) {
			System.err.println("BuyerBean.creatNewBuyer():" + e.getMessage());
			return false;
		}
	}
	
	public int getLogontimes(){
		String strSql = null;
		try{
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);

			Statement stmt = conn.createStatement();
	strSql ="Select logontimes,membername from buyerinfo where memberID = '" + 
			memberID + "' and pwd ='" + pwd + "'";
			rs = stmt.executeQuery(strSql);
			while (rs.next()){				

				logontimes = rs.getInt("logontimes");

				 memberName = rs.getString("membername"); 						
			}			
			rs.close();
		
			if (logontimes != -1 ) {
				strSql = "Update buyerInfo set logontimes = logontimes +1 where memberID = '" + memberID +"'";
				stmt.executeUpdate(strSql);
			}
			stmt.close();
			conn.close();
			
		}
	
		catch(SQLException e){
			System.err.println("BuyerBean.getLogontimes( ):" + e.getMessage());
		}
		return logontimes ;
	}
	
	public  void setMemberID(String ID){
		this.memberID = ID;
	}
	
	public void  setPwd(String password){
		this.pwd = password;
	}
        
public String getMemberName(){
		return memberName;
	}
		
 public String getMemberNameById(String memberID) {
	 String strSql = null;
	 String memberName = null;
	 try{
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);

			Statement stmt = conn.createStatement();
			strSql ="Select membername from buyerinfo where memberID = '" + 
			memberID + "'";
			rs = stmt.executeQuery(strSql);
			while (rs.next()){
				 memberName = rs.getString("membername"); 						
			}			
			rs.close();
			stmt.close();
			conn.close();
		}catch(SQLException e){
			System.err.println("BuyerBean.getnameByID( ):" + e.getMessage());
		}
	 return memberName;
 }

public String getMemberID() {
	return memberID;
}


public String getPwd() {
	return pwd;
}


public String getPhoneCode() {
	return phoneCode;
}


public void setPhoneCode(String phoneCode) {
	this.phoneCode = phoneCode;
}


public String getEmail() {
	return email;
}


public void setEmail(String email) {
	this.email = email;
}





public void setMemberName(String memberName) {
	this.memberName = memberName;
}


public void setLogontimes(int logontimes) {
	this.logontimes = logontimes;
}


public  static void main(String args[]){
	BuyerBean buyer = new BuyerBean();
	buyer.setMemberID("2017211167");
	buyer.setPwd("123456");
	System.out.println(buyer.getLogontimes());
	System.out.println(buyer.getMemberName());

}

public boolean upLoadName(String memberID,String name) {
	String strSql = "UPDATE buyerinfo SET memberName = '"+name+"' WHERE memberID = '"+memberID+"'";
	try {
		conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(strSql);
		stmt.close();
		conn.close();
		
		return true;
	} catch (Exception e) {
		System.err.println("BuyerBean.upLoadName():" + e.getMessage());
		return false;
	}
}
public boolean upLoadEmail(String memberID,String email) {
	String strSql = "UPDATE buyerinfo SET email = '"+email+"' WHERE memberID = '"+memberID+"'";
	try {
		conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(strSql);
		stmt.close();
		conn.close();
		
		return true;
	} catch (Exception e) {
		System.err.println("BuyerBean.upLoadEmail():" + e.getMessage());
		return false;
	}
}
public boolean upLoadPhoneCode(String memberID, String PhoneCode) {
	String strSql = "UPDATE buyerinfo SET phoneCode = '"+PhoneCode+"' WHERE memberID = '"+memberID+"'";
	try {
		conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(strSql);
		stmt.close();
		conn.close();
		
		return true;
	} catch (Exception e) {
		System.err.println("BuyerBean.upLoadEmail():" + e.getMessage());
		return false;
	}
}


public boolean upLoadPwd(String memberID, String pwd,String oldpwd) {
	String strSql1 = "Select pwd FROM buyerinfo WHERE memberID = '"+memberID+"'";
	String strSql = "UPDATE buyerinfo SET pwd = '"+pwd+"' WHERE memberID = '"+memberID+"'";
	try {
		conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
		Statement stmt = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		ResultSet rs = stmt.executeQuery(strSql1);
		if(rs.next()) { 
			if(!rs.getString("pwd").equals(oldpwd)) {
				return false; 
			}
		}
		stmt2.executeUpdate(strSql);
		stmt.close();
		stmt2.close();
		conn.close();
		
		return true;
	} catch (Exception e) {
		System.err.println("BuyerBean.upLoadPwd():" + e.getMessage());
		return false;
	}
}	
}
