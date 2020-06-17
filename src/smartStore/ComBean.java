/**
 * 商品管理javabean
 * @author SmallSmart
 *
 */


package smartStore;
import java.io.File;
import java.sql.*;
public class ComBean {
	private String comKey = null;	
	private String comName = null;		
	private String sellerName = null;	
	private float price =0;		
	private String introduce = null;		
	private String imgsrc = null;		
	 
	private static String strDBDriver = "com.mysql.jdbc.Driver";  
	private static String strDBUrl="jdbc:mysql://localhost:3306/store"; 
	private static final String USER_NAME="root";
	private static final String PASS_WORD="password";
	
	private Connection conn =null;
	private ResultSet rs = null;

	public static boolean deleteComImg(String filePath,String systempath) {
		
		boolean delete_flag = false;
		File file = new File(systempath,filePath);
		if (file.exists() && file.isFile() && file.delete()) {
			delete_flag = true;
			System.out.println("成功");
		} 
		else{
			delete_flag = false;
			System.out.println("失败");
		}
		return delete_flag;
	}

	public boolean addCom(String comKey, String comName, String sellerName, String price, String introduce,String imgsrc) {
		try{
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
			Statement stmt = conn.createStatement();
			String strSql = "insert into cominfo (comKey,comName,sellerName,price,introduce,imgsrc)"
					+ " values( '"+comKey + "', '" + comName + "', '"
					+ sellerName + "', "  
					+ price + ", '" + introduce + "','"+imgsrc+"')" ;
			System.out.println(strSql);
				stmt.executeUpdate(strSql);
				return true;
		}catch(SQLException e){
			System.err.println("comBeanaddcom()" + e.getMessage());
			return false;
		}
	}
	public boolean modifyCom(String comKey,String comName,String sellerName,String price, String introduce, String imgsrc, String systemPath) {
		try {
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
			Statement stmt = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			String imgsql = "select imgsrc from cominfo where comKey='"+comKey+"'";
			ResultSet rs = stmt2.executeQuery(imgsql);
			String oldimgsrc = "";
			while(rs.next()) {
				oldimgsrc = rs.getString("imgsrc");
			}
			if(imgsrc.toUpperCase().endsWith("PNG")||imgsrc.toUpperCase().endsWith("JPG")||imgsrc.toUpperCase().endsWith("GIF")) {
				deleteComImg(oldimgsrc, systemPath);
			}else {
				imgsrc = oldimgsrc;
			}
			String sql="update cominfo set comName='"+ comName+"',sellerName='"+ sellerName+ "',price="+price+",introduce='"+introduce+"',imgsrc='"+imgsrc+"' where comKey='"+comKey+"'";
			stmt.executeUpdate(sql); 
			stmt.close();
			return true;
		} catch (SQLException e) {
			System.err.println("ComBean.delete():" + e.getMessage());
			return false;
		}
	}
	public boolean delete(String comKey, String systemPath) {
		try {
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
			Statement stmt = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			String imgsql = "select imgsrc from cominfo where comKey='"+comKey+"'";
			ResultSet rs = stmt2.executeQuery(imgsql);
			String imgsrc = "";
			while(rs.next()) {
				imgsrc = rs.getString("imgsrc");
			}
			String sql="delete from cominfo where comKey='"+comKey+"'";
			stmt.executeUpdate(sql); 
			deleteComImg(imgsrc,systemPath);
			return true;
		} catch (SQLException e) {
			System.err.println("ComBean.delete():" + e.getMessage());
			return false;
		}
	}
	
	public String getImgsrc() {
		return imgsrc;
	}
	public ResultSet getGuessRs() {
		return getComByKey(getGuess(),getGuess(),getGuess());
	}
	public ResultSet getComByKey(String c1,String c2,String c3) {
		String strSql = null;
		try{
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
			Statement stmt = conn.createStatement();
			strSql = "Select * from comInfo where comkey="+c1+" or comkey="+c2+" or comkey="+c3;
			rs = stmt.executeQuery(strSql);			
		}
		catch(SQLException e){
			System.err.println("ComBean.getComList():" + e.getMessage());
		}
		return rs ;
	}
	
	
	public ComBean() {

			try {
				Class.forName(strDBDriver );
			}
			catch(java.lang.ClassNotFoundException e){
				System.err.println("ComBean():" + e.getMessage());
			}
	}	
	
	public ResultSet getComList(){
		String strSql = null;
		try{

			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);


			Statement stmt = conn.createStatement();
			strSql = "Select comKey,comName,sellerName,price,introduce,imgsrc from comInfo order by comKey DESC";
			rs = stmt.executeQuery(strSql);			
		}

		catch(SQLException e){
			System.err.println("ComBean.getComList():" + e.getMessage());
		}
		return rs ;
	}
	public int getMaxID() {
		int max = -1;
		try{
			Connection con = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select max(comkey) from cominfo");
			while(rs.next()){
				max = java.lang.Integer.valueOf(rs.getString("max(comKey)"));	
			}
		}catch(SQLException e){
			System.err.println("addcom.jsp" + e.getMessage());
		}
		return max;
	}
	public String getGuess() {
		int res = (int) (Math.random()*(getMaxID()-123))+123;
		return ""+res;
	}
	public void getComInfo(String Key){
		String strSql = null;
		comName = null;
		sellerName = null;
		introduce = null;
		price = 0;
		try{

			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);

			Statement stmt = conn.createStatement();
			strSql = "Select * from comInfo where comKey = '" + Key + "'";
			rs = stmt.executeQuery(strSql);			
			while (rs.next()){
				comName = rs.getString("comName");
				sellerName = rs.getString("sellerName");
				introduce = rs.getString("introduce");
				price = rs.getFloat("price");
				imgsrc = rs.getString("imgsrc");
			}
		}

		catch(SQLException e){
			System.err.println("ComBean.getComInfo():" + e.getMessage());
		}		
	}

   
		public void setComKey(String comKey) {
			this.comKey = comKey;
			
		}

		public String getComKey() {
			return comKey;
		}

		public String getComName() {
			return comName;
		}

		public String getSellerName() {
			return sellerName;
		}

		public float getPrice() {
			return price;
		}

		public String getIntroduce() {
			return introduce;
		}
		

//		public static void main(String args[]){
//			ComBean com1 = new ComBean();
//			
//			deleteComImg("img/comimg/1-1.PNG");
//		}
//		
		
}
