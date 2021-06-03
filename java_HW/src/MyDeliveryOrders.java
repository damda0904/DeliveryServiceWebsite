import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MyDeliveryOrders {
    public MyDeliveryOrders(int dnum) {
        showMyOrders(dnum);
    }

    //본인이 배달원으로 입력된 모든 주문 리스트 출력
    public void showMyOrders(int dnum) {
        Connection conn = null;
        Statement str = null;
        ResultSet rs = null;

        String onum, rname, fname, count, price;

        //1단계
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("");
        } catch (Exception e) {
            System.out.println("MySQL JDBC Driver 로딩을 실패하였습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //2단계
        try{
            String URL = "jdbc:mysql://localhost:3305/homework?serverTimezone=UTC";
            conn = DriverManager.getConnection(URL, "root", "123456");
        } catch(Exception e) {
            System.out.println("DB 서버 접속을 실패하였습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //3단계 : 리스트 검색 및 출력
        try {
            str = conn.createStatement();

            String query = "select o.onum, r.name, f.name, o.price, o.count " +
                    "from orders o, restaurant r, food f " +
                    "where o.rnum = r.rnum " +
                    "and o.fnum = f.fnum " +
                    "and o.dnum = " + dnum;

            rs = str.executeQuery(query);
            System.out.println("주문번호 | 가게명 | 메뉴명 | 주문 수량 | 결제금액");
            System.out.println("-------------------------------------------");
            while(rs.next()) {
                onum = rs.getString("o.onum");
                rname = rs.getString("r.name");
                fname = rs.getString("f.name");
                count = rs.getString("o.count");
                price = rs.getString("o.price");
                System.out.println(onum + " | " + rname + " | " + fname + " | " + count + " | " + price);
            }
            System.out.println("-------------------------------------------");

            rs.close();
            str.close();
            conn.close();

        } catch(Exception e){
            System.out.println("데이터를 가져오지 못했습니다.");
            System.out.println(e);
        }
    }
}
