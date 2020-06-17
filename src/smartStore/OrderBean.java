package smartStore;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;


public class OrderBean {
	private static String strDBDriver = "com.mysql.jdbc.Driver";   //JDBC驱动
	private static String strDBUrl="jdbc:mysql://localhost:3306/store"; //数据库bookstore
	private static final String USER_NAME="root";
	private static final String PASS_WORD="password";
	 
	
	private Connection conn = null;
	private ResultSet rs = null;
	private java.lang.String cominfo = null;
	private Float orderPrice = null;
	private java.lang.String orderDate = null;
	private int orderID;
	private java.lang.String orderRem = null;
	private java.lang.String receiverAddress = null;
	private java.lang.String receiverName = null;
	private java.lang.String receiverZip = null;
	private java.lang.String userID = null;
	private java.lang.String memo = null;
	
	public OrderBean(){
		try {
			Class.forName(strDBDriver );
		}
		catch(java.lang.ClassNotFoundException e){
			System.err.println("OrderBean():" + e.getMessage());
		}
	}

	public float getOrderPrice() {
		return orderPrice;
	}
  //可以用sql里的now()方法代替
	public java.lang.String getOrderDate(){
//		orderDate = new java.util.Date().toString();
		Date date =new java.util.Date();
//		java.sql.Date sqlDate=new java.sql.Date(date.getTime());
//		orderDate=sqlDate.toString();
		orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		return orderDate;
	}

	public int getOrderID() {
		return orderID;
	}

	public java.lang.String getOrderRem() {
		return orderRem;
	}

	public java.lang.String getReceiverAddress() {
			return receiverAddress;
	}

	public java.lang.String getReceiverName() {
		return receiverName;
	}

	public java.lang.String getReceiverZip() {
		return receiverZip;
	}

	public java.lang.String getUserID() {
		return userID;
	}
	
	public void setCominfo(java.lang.String newCominfo) {
		cominfo = newCominfo;
		createNewOrder();
		int fromIndex = 0;
		int tmpIndex = 0;
		int tmpEnd = 0;
		String strSql = null;
		try{
			
			conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);

			Statement stmt = conn.createStatement();
			while(cominfo.indexOf(';',fromIndex) != -1 ){
				tmpEnd = cominfo.indexOf(';',fromIndex);
				tmpIndex = cominfo.lastIndexOf('=',tmpEnd);
				strSql = "insert into orderdetail(orderID ,comKey,comcount)"
					+ " values( "+ getOrderID() + ", '" 
						+ cominfo.substring(fromIndex ,tmpIndex) + "', "
						+ cominfo.substring(tmpIndex+1 ,tmpEnd) + " )" ;
				stmt.executeUpdate(strSql);
			fromIndex = tmpEnd + 1;
			}
			stmt.close();
			conn.close();
		}
		catch(SQLException e){
			System.err.println("orderBean.setcominfo():" + e.getMessage());
		}
}

	public void setOrderPrice(java.lang.Float orderPrice) {
		this.orderPrice = orderPrice;
	}

	public void setOrderRem(java.lang.String orderRem) {
		this.orderRem = orderRem;
	}

	public void setReceiverAddress(java.lang.String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	public void setReceiverName(java.lang.String receiverName) {
		this.receiverName = receiverName;
	}

	public void setReceiverZip(java.lang.String receiverZip) {
		this.receiverZip = receiverZip;
	}

	public void setUserID(java.lang.String userID) {
		this.userID = userID;
	}
	
	
	public java.lang.String getMemo() {
		return memo;
	}

	public void setMemo(java.lang.String memo) {
		this.memo = memo;
	}

	/**
	 * 创建一个新定单
	 */
	private void createNewOrder() {
			String strSql = null;
		try{
				conn = DriverManager.getConnection(strDBUrl,USER_NAME,PASS_WORD);


				Statement stmt = conn.createStatement();
				String date = getOrderDate();
				strSql = "insert into orderInfo (userID,receiverName,receiverAddress,receiverZip,orderPrice,orderDate,memo)"
					+ " values( '"+ getUserID() + "', '" + getReceiverName() + "', '"
					+ getReceiverAddress() + "', '"+ getReceiverZip() + "', " + getOrderPrice() + ",'" +date + "','" +getMemo() + "')" ;

				
/*				//date可以用sql里的now()函数解决
				strSql = "insert into orderInfo (userID,receiverName,receiverAddress,receiverZip,orderRem,orderPrice,orderDate,memo)"
						+ " values( '"+ getUserID() + "', '" + getReceiverName() + "', '"
						+ getReceiverAddress() + "', '"  
		+ getReceiverZip() + "', '" + getOrderRem() + "', "
						+ getOrderPrice() + " ,now(),'" +getMemo() + "')" ;
*/							
				stmt.executeUpdate(strSql);
			strSql = "select max(orderID) from  orderInfo where userID = '" +getUserID()+ "' and receiverName = '" + getReceiverName() 
	+ "' and receiverAddress =  '" + getReceiverAddress()+"' and receiverZip =  '"  + getReceiverZip() 
	+ "'  and orderDate  = '"+ date+"' and memo =  '"  + getMemo()
	+ "'" ;
			orderID = 0;
			rs = stmt.executeQuery(strSql);
			while (rs.next()){
				 orderID =java.lang.Integer.valueOf(rs.getString("max(orderID)"));
			}
			rs.close();
			stmt.close();
			conn.close();

		}
		catch(Exception e){
			System.out.println("111");
			System.err.println("OrderBean.creatNewOrder():" + e.getMessage());
		}
	}
	public  static void main(String args[]){
	OrderBean o=new OrderBean();
	o.getOrderDate();
	System.out.println(o.getOrderID());;
	
	}
	
	
}

